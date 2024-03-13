import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/app/global_components/background.dart';
import 'package:todo/app/modules/home/components/todo_item_view.dart';
import 'package:todo/app/routes/app_pages.dart';
import '../components/loader.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('TODO'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.CREATE_UPDATE_TODO);
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(() => controller.loadingTodos.value
          ? const AppLoader()
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                var todo = controller.todoList[index];
                return TodoItemView(
                    onClick: () {
                      Get.toNamed(Routes.CREATE_UPDATE_TODO, arguments: todo);
                    },
                    todoItem: todo);
              },
              itemCount: controller.todoList.length,
            )),
    ));
  }
}
