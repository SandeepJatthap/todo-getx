import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/app/global_components/background.dart';
import 'package:todo/app/modules/create_update_todo/components/app_text_field.dart';
import 'package:todo/app/utils/validators/app_validations.dart';
import '../controllers/create_update_todo_controller.dart';

class CreateUpdateTodoView extends GetView<CreateUpdateTodoController> {
  const CreateUpdateTodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(

        child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(controller.todo != null ? 'Update Task' : 'Create Task'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Hero(
                tag: controller.todo?.id?.toString() ?? "",
                child: AppTextField(
                  controller: controller.titleController,
                  hint: "Title",
                  validator: AppValidations.validateTitle,
                ),
              ),
              AppTextField(
                controller: controller.contentController,
                hint: "Content",
                minLines: 4,
                maxLines: 5,
                validator: AppValidations.validateContent,
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: ElevatedButton(
          onPressed: controller.submit,
          child: const Text('Submit'),
        ).paddingSymmetric(horizontal: 20, vertical: 10),
      ),
    ));
  }
}
