import 'package:get/get.dart';

import '../../../data/data/repository/todo_repository.dart';
import '../controllers/create_update_todo_controller.dart';

class CreateUpdateTodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateUpdateTodoController>(
      () => CreateUpdateTodoController(repository: TodoRepository()),
    );
  }
}
