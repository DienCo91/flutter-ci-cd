import 'package:batterylevel/core/network/dio_client.dart';
import 'package:batterylevel/todos/models/todo.dart';
import 'package:dio/dio.dart';

class TodosRepository {
  TodosRepository({Dio? dio}) : _dio = dio ?? DioClient().dio;

  final Dio _dio;
  final String _baseUrl = "https://6447e7537bb84f5a3e4cbd8d.mockapi.io/todo";
  Future<List<Todo>> getTodos({int page = 1, int limit = 12}) async {
    try {
      final res = await _dio.get(
        _baseUrl,
        queryParameters: {
          "page": page,
          "limit": limit,
          "sortBy": "createdAt",
          "order": "desc",
        },
      );
      return (res.data as List).map((e) => Todo.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Load todos error: $e');
    }
  }

  Future<bool> deleteTodoById(String? id) async {
    try {
      await _dio.delete('$_baseUrl/$id');
      return true;
    } catch (e) {
      throw Exception('Delete todo error: $e');
    }
  }

  Future<Todo> createTodo(Todo todo) async {
    try {
      final res = await _dio.post(_baseUrl, data: todo.toJson());
      return Todo.fromJson(res.data);
    } catch (e) {
      throw Exception('Create todo error: $e');
    }
  }

  Future<Todo> updateTodo(Todo todo) async {
    try {
      final res = await _dio.put('$_baseUrl/${todo.id}', data: todo.toJson());
      return Todo.fromJson(res.data);
    } catch (e) {
      throw Exception('Create todo error: $e');
    }
  }
}
