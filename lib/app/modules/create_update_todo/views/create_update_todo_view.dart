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
        title: Text(controller.todo != null ? 'Task Details' : 'Create Task'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                controller: controller.titleController,
                // readOnly: controller.todo!=null,
                hint: "Title",
                minLines: 4,
                maxLines: 5,
                validator: AppValidations.validateTitle,
              ),
              if (controller.todo != null && controller.todo?.status == 1)
                const Row(
                  children: [
                    Icon(Icons.verified, size: 22),
                    SizedBox(width: 5),
                    Expanded(child: Text("This task is marked as complete."))
                  ],
                ).marginSymmetric(horizontal: 15, vertical: 10)
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: controller.todo == null
            ? Obx(
                () => ElevatedButton(
                  onPressed:
                      controller.submitting.value ? null : controller.submit,
                  child: controller.submitting.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        )
                      : const Text('Submit'),
                ),
              ).paddingSymmetric(horizontal: 20, vertical: 10)
            : Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: (controller.submitting.value ||
                            controller.deleting.value)
                        ? null
                        : controller.deleteTask,
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                    child: controller.deleting.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                            ),
                          )
                        : const Text(
                            'Delete',
                            style: TextStyle(color: Colors.white),
                          ),
                  )),
                  if (controller.todo?.status == 0) const SizedBox(width: 10),
                  if (controller.todo?.status == 0)
                    Expanded(
                        child: ElevatedButton(
                      onPressed: (controller.submitting.value ||
                              controller.deleting.value)
                          ? null
                          : controller.markTaskDone,
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      child: controller.submitting.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                              ),
                            )
                          : const Text(
                              'Mark Done',
                              style: TextStyle(color: Colors.white),
                            ),
                    )),
                ],
              ).paddingSymmetric(horizontal: 20, vertical: 10),
      ),
    ));
  }
}
