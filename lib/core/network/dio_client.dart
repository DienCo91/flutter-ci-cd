import 'package:dio/dio.dart';

class DioClient {
  DioClient._internal();

  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  static const Duration _defaultTimeout = Duration(seconds: 15);

  String Function()? onGetToken;

  late final Dio dio = _createDio();

  Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: _defaultTimeout,
        receiveTimeout: _defaultTimeout,
        sendTimeout: _defaultTimeout,
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      ),
    );

    dio.interceptors.addAll([
      // LogInterceptor(
      //   request: true,
      //   requestHeader: true,
      //   requestBody: true,
      //   responseHeader: false,
      //   responseBody: true,
      //   error: true,
      // ),
      _AppInterceptor(this),
    ]);

    return dio;
  }
}

class _AppInterceptor extends Interceptor {
  _AppInterceptor(this._client);

  final DioClient _client;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _client.onGetToken?.call();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      handler.next(response);
    } else {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          message: 'Lỗi không xác định (${response.statusCode}).',
          type: DioExceptionType.badResponse,
          response: response,
        ),
      );
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        handler.next(
          DioException(
            requestOptions: err.requestOptions,
            message: 'Kết nối bị timeout. Vui lòng thử lại.',
            type: err.type,
            error: err.error,
          ),
        );
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final serverMessage = err.response?.data is Map ? (err.response?.data as Map)['message'] : null;
        String message;
        switch (statusCode) {
          case 400:
            message = serverMessage ?? 'Yêu cầu không hợp lệ (400).';
          case 401:
            message = 'Không có quyền truy cập (401).';
          case 403:
            message = 'Bị từ chối truy cập (403).';
          case 404:
            message = 'Không tìm thấy tài nguyên (404).';
          case 500:
            message = 'Lỗi máy chủ (500).';
          default:
            message = serverMessage ?? 'Lỗi máy chủ ($statusCode).';
        }
        handler.next(
          DioException(
            requestOptions: err.requestOptions,
            message: message,
            type: err.type,
            error: err.error,
            response: err.response,
          ),
        );
      case DioExceptionType.connectionError:
        handler.next(
          DioException(
            requestOptions: err.requestOptions,
            message: 'Không thể kết nối đến máy chủ. Kiểm tra kết nối mạng.',
            type: err.type,
            error: err.error,
          ),
        );
      default:
        handler.next(err);
    }
  }
}
