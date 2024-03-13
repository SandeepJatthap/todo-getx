import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/app/global_components/background.dart';
import 'package:todo/app/modules/home/components/no_data_view.dart';
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
        title: const Text('Tasks'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.onNewTaskClick,
        child: const Icon(Icons.add),
      ),
      body: Obx(
        () => controller.loadingTodos.value
            ? const AppLoader()
            : RefreshIndicator(
                onRefresh: () async {
                  await controller.getTodos(showLoader: false);
                },
                child: controller.todoList.isNotEmpty
                    ? ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          var todo = controller.todoList[index];
                          return TodoItemView(
                            onClick: () => controller.onTaskClick(todo),
                            todoItem: todo,
                            onDelete: () => controller.deleteTask(todo),
                            onDone: () => controller.markTaskDone(todo),
                          );
                        },
                        itemCount: controller.todoList.length,
                      )
                    : const NoDataUi()),
      ),
    ));
  }
}
