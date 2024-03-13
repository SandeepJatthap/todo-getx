import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../data/data/model/task_model.dart';
import '../../../data/data/repository/todo_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/message_handler.dart';
import '../../../utils/services/internet_connectivity_service.dart';
import '../../../utils/services/notification_service.dart';

class HomeController extends GetxController {
  final loadingTodos = false.obs;
  final todoList = <TaskModel>[].obs;
  final TodoRepository repository;
  final connectionStatus = ConnectionStatusSingleton.instance;
  final submitting = false.obs;
  final deleting = false.obs;
  final hasConnection = true.obs;

  HomeController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    hasConnection.value = connectionStatus.hasConnection;
    connectionStatus.myStream.listen((event) {
      hasConnection.value = event;
    });
    checkNotificationPermission();
    getTodos();
  }

  void checkNotificationPermission() {
    Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
  }

  Future<void> onNewTaskClick() async {
    var result = await Get.toNamed(Routes.CREATE_UPDATE_TODO);
    if (result != null && result == true) {
      getTodos(showLoader: false);
    }
  }

  Future<void> onTaskClick(TaskModel taskModel) async {
    var result =
        await Get.toNamed(Routes.CREATE_UPDATE_TODO, arguments: taskModel);
    if (result != null && result == true) {
      getTodos(showLoader: false);
    }
  }

  Future<void> getTodos({bool showLoader = true}) async {
    if (showLoader) {
      loadingTodos(true);
    }
    var response = await repository.getAllTodos();
    if (response.isNotEmpty) {
      todoList(response);
    }
    loadingTodos(false);
  }

  Future<void> deleteTask(TaskModel todo) async {
    if (hasConnection.value) {
      deleting(true);
      showLoaderDialog("Deleting task");
      var response = await repository.deleteDio(todo.id!.toString());
      if (response?.id != null) {
        AppMessageHandler.showErrorMessage("Task deleted successfully");
        NotificationService().cancelNotitication(response!.id!.toInt());
        getTodos(showLoader: false);
      } else {
        AppMessageHandler.showErrorMessage(
            "Failed to delete task, Please try again.");
      }
      submitting(false);
      Get.back();
    } else {
      AppMessageHandler.showErrorMessage("Please check internet connection.");
    }
  }

  Future<void> markTaskDone(TaskModel todo) async {
    if (hasConnection.value) {
      submitting(true);
      showLoaderDialog("Marking task done");
      var response = await repository.markTaskDone(todo.id!.toString());
      if (response?.id != null) {
        AppMessageHandler.showErrorMessage("Task done successfully");
        NotificationService().cancelNotitication(response!.id!.toInt());
        getTodos(showLoader: false);
      } else {
        AppMessageHandler.showErrorMessage(
            "Failed to done task, Please try again.");
      }
      submitting(false);
      Get.back();
    } else {
      AppMessageHandler.showErrorMessage("Please check internet connection.");
    }
  }

  showLoaderDialog(String message) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          const SizedBox(width: 15),
          Expanded(child: Text(message))
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: alert,
        );
      },
    );
  }
}
