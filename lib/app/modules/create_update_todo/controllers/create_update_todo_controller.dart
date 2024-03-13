import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/app/data/data/model/task_model.dart';
import 'package:todo/app/utils/message_handler.dart';

import '../../../data/data/repository/todo_repository.dart';
import '../../../utils/services/internet_connectivity_service.dart';
import '../../../utils/services/notification_service.dart';

class CreateUpdateTodoController extends GetxController {
  final todo = Get.arguments as TaskModel?;
  final TextEditingController titleController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final hasConnection = true.obs;
  final submitting = false.obs;
  final deleting = false.obs;
  final TodoRepository repository;
  final connectionStatus = ConnectionStatusSingleton.instance;

  CreateUpdateTodoController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    hasConnection.value = connectionStatus.hasConnection;
    connectionStatus.myStream.listen((event) {
      hasConnection.value = event;
    });
    setData();
  }

  void setData() {
    if (todo != null) {
      titleController.text = todo!.taskName ?? "";
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    titleController.dispose();
  }

  Map<String, dynamic> buildData() {
    var data = <String, dynamic>{
      'task_name': titleController.text.trim(),
    };
    if (todo != null) {
      data['id'] = todo?.id;
    }
    return data;
  }

  Future<void> submit() async {

    NotificationService().showNotification(
        89,
        titleController.text.trim(),
        "description",
        DateTime.now().add(const Duration(minutes: 2)),
        Colors.green,
        0);
    return;
    if (hasConnection.value) {
      submitting(true);
      var data = buildData();
      var response = todo == null
          ? await repository.createTodo(data)
          : await repository.updateTodo(data);
      if (response?.id != null) {
        AppMessageHandler.showErrorMessage(todo == null
            ? "Task created successfully"
            : "Task updated successfully");
        NotificationService().showNotification(
            response!.id!.toInt(),
            titleController.text.trim(),
            "description",
            DateTime.now().add(const Duration(minutes: 10)),
            Colors.green,
            5);
        // NotificationService().cancelNotitication(editedEvent.id);

        Get.back(result: true);
      } else {
        AppMessageHandler.showErrorMessage(
            "Failed to add task, Please try again.");
      }
      submitting(false);
    } else {
      AppMessageHandler.showErrorMessage("Please check internet connection.");
    }
  }

  Future<void> deleteTask() async {
    if (hasConnection.value) {
      deleting(true);
      var response = await repository.deleteDio(todo!.id!.toString());
      if (response?.id != null) {
        AppMessageHandler.showErrorMessage("Task deleted successfully");
        NotificationService().cancelNotitication(response!.id!.toInt());
        Get.back(result: true);
      } else {
        AppMessageHandler.showErrorMessage(
            "Failed to delete task, Please try again.");
      }
      submitting(false);
    } else {
      AppMessageHandler.showErrorMessage("Please check internet connection.");
    }
  }

  Future<void> markTaskDone() async {
    if (hasConnection.value) {
      submitting(true);
      var response = await repository.markTaskDone(todo!.id!.toString());
      if (response?.id != null) {
        AppMessageHandler.showErrorMessage("Task done successfully");
        NotificationService().cancelNotitication(response!.id!.toInt());
        Get.back(result: true);
      } else {
        AppMessageHandler.showErrorMessage(
            "Failed to done task, Please try again.");
      }
      submitting(false);
    } else {
      AppMessageHandler.showErrorMessage("Please check internet connection.");
    }
  }
}
