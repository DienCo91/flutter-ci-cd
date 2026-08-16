import 'package:batterylevel/core/network/dio_client.dart';
import 'package:batterylevel/features/tutorial/domain/joke.dart';
import 'package:dio/dio.dart';

class JokeRepository {
  JokeRepository({Dio? dio}) : _dio = dio ?? DioClient().dio;

  final Dio _dio;
  final baseUrl = 'https://official-joke-api.appspot.com';

  Future<Joke> fetchRandomJoke() async {
    final response = await _dio.get<Map<String, Object?>>('$baseUrl/random_joke');

    return Joke.fromJson(response.data!);
  }
}
