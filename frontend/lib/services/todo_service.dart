import 'package:dio/dio.dart';
import '../models/todo_model.dart';

class TodoService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:8080/api/todos',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<List<TodoModel>> fetchTodos() async {
    try {
      final response = await _dio.get('');
      final List<dynamic> data = response.data;
      return data.map((json) => TodoModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load todos: ${e.message}');
    }
  }

  Future<void> addTodo(String content) async {
    try {
      await _dio.post('', data: {
        'content': content,
        'isCompleted': false,
      });
    } on DioException catch (e) {
      throw Exception('Failed to add todo: ${e.message}');
    }
  }

  Future<void> toggleTodo(int id, bool isCompleted) async {
    try {
      await _dio.put('/$id', data: {
        'isCompleted': isCompleted,
      });
    } on DioException catch (e) {
      throw Exception('Failed to update todo: ${e.message}');
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      await _dio.delete('/$id');
    } on DioException catch (e) {
      throw Exception('Failed to delete todo: ${e.message}');
    }
  }
}
