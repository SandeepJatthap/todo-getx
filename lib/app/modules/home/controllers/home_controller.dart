import 'package:get/get.dart';

import '../../../data/data/model/todo_model.dart';
import '../../../data/data/repository/todo_repository.dart';

class HomeController extends GetxController {
  final loadingTodos = false.obs;
  final todoList = <TodoItem>[].obs;
  final TodoRepository repository;

  HomeController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    getTodos();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getTodos() async {
    loadingTodos(true);
    // todoList(await repository.getAllTodos());
    await Future.delayed(const Duration(seconds: 3));
    loadingTodos(false);
  }
}
