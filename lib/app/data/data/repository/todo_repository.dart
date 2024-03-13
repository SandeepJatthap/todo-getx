import 'package:todo/app/data/data/model/todo_model.dart';

import '../model/generic_response.dart';
import '../model/send_login_otp_response.dart';
import '../provider/remote/DiaApiBaseHelper.dart';

class TodoRepository {
  Future<List<TodoItem>> getAllTodos() async {
    try {
      var res = await DioApiBaseHelper.get(
        DioApiBaseHelper.todo,
      );
      return List<TodoItem>.from(res.map((l) => TodoItem.fromMap(l))).toList();
    } catch (error, stacktrace) {
      return [];
    }
  }

  Future<GenericResponse?> createTodo(Map<String, dynamic> data) async {
    try {
      var res = await DioApiBaseHelper.postDio(DioApiBaseHelper.todo, data);
      return GenericResponse.fromJson(res);
    } catch (error, stacktrace) {
      return null;
    }
  }

  Future<GenericResponse?> updateTodo(Map<String, dynamic> data) async {
    try {
      var res = await DioApiBaseHelper.putDio(DioApiBaseHelper.todo, data);
      return GenericResponse.fromJson(res);
    } catch (error, stacktrace) {
      return null;
    }
  }

  Future<GenericResponse?> deleteDio(String id) async {
    try {
      var res = await DioApiBaseHelper.putDio(DioApiBaseHelper.todo, id);
      return GenericResponse.fromJson(res);
    } catch (error, stacktrace) {
      return null;
    }
  }
}
