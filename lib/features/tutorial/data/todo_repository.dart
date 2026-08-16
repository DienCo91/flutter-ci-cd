import 'package:batterylevel/core/network/dio_client.dart';
import 'package:batterylevel/todos/models/todo.dart';
import 'package:dio/dio.dart';

class TodoRepository {
  TodoRepository({Dio? dio}) : _dio = dio ?? DioClient().dio;

  final Dio _dio;
  final baseUrl = 'https://6447e7537bb84f5a3e4cbd8d.mockapi.io/todo';

  Future<List<Todo>> fetchTodos({required int page, required int limit}) async {
    final response = await _dio.get(baseUrl, queryParameters: {"page": page, "limit": limit, "sortBy": "createdAt"});
    return (response.data as List).map((e) => Todo.fromJson(e)).toList();
  }

  Future<void> deleteTodoById({required String id}) async {
    await _dio.delete("$baseUrl/$id");
  }
}
