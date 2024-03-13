import 'package:get/get.dart';

import '../../../data/data/repository/todo_repository.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(repository: TodoRepository()),
    );
  }
}
