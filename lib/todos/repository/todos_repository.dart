import 'package:batterylevel/todos/models/todo.dart';
import 'package:dio/dio.dart';

class TodosRepository {
  final dio = Dio();
  final String _baseUrl = "https://6447e7537bb84f5a3e4cbd8d.mockapi.io/todo";
  Future<List<Todo>> getTodos({page = 1, limit = 12}) async {
    try {
      final res = await dio.get(
        _baseUrl,
        queryParameters: {"page": page, "limit": limit, "sortBy": "createdAt", "order": "desc"},
      );
      return (res.data as List).map((e) => Todo.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Load todos error: $e');
    }
  }

  Future<bool> deleteTodoById(String? id) async {
    try {
      await dio.delete('$_baseUrl/$id');
      return true;
    } catch (e) {
      throw Exception('Delete todo error: $e');
    }
  }

  Future<Todo> createTodo(Todo todo) async {
    try {
      final res = await dio.post(_baseUrl, data: todo.toJson());
      return Todo.fromJson(res.data);
    } catch (e) {
      throw Exception('Create todo error: $e');
    }
  }

  Future<Todo> updateTodo(Todo todo) async {
    try {
      final res = await dio.put('$_baseUrl/${todo.id}', data: todo.toJson());
      return Todo.fromJson(res.data);
    } catch (e) {
      throw Exception('Create todo error: $e');
    }
  }
}
