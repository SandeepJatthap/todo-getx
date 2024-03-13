import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo/app/data/data/model/todo_model.dart';
import 'package:todo/app/utils/message_handler.dart';

import '../../../data/data/repository/todo_repository.dart';

class CreateUpdateTodoController extends GetxController {
  final todo = Get.arguments as TodoItem?;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final submitting = false.obs;
  final TodoRepository repository;

  CreateUpdateTodoController({required this.repository});

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    titleController.dispose();
    contentController.dispose();
  }

  Map<String, dynamic> buildData() {
    var data = <String, dynamic>{
      'title': titleController.text.trim(),
      'content': contentController.text.trim(),
    };
    if (todo != null) {
      data['id'] = todo?.id;
    }
    return data;
  }

  Future<void> submit() async {
    submitting(true);
    var data = buildData();
    var response = todo == null
        ? await repository.createTodo(data)
        : await repository.updateTodo(data);
    if (response?.status == 1) {
      AppMessageHandler.showErrorMessage("Todo created successfully");
      // int randomNumber = Random().nextInt(9000);
      // NotificationService().showNotification(
      //     randomNumber, title, description, dateTime, priority, remindIn);
      // NotificationService().cancelNotitication(editedEvent.id);

      Get.back(result: true);
    } else {
      AppMessageHandler.showErrorMessage(
          "Failed to add todo, Please try again.");
    }
    submitting(false);
  }
}
