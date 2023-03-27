import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:yodo/dto/create_task_dto.dart';
import 'package:yodo/ui/task_details/task_details.dart';

import '../../modals/task.dart';

class TaskEditorViewModal {
  late final TextEditingController nameController, descriptionController;
  DateTime? dueDate;
  String? taskId;

  final User user = FirebaseAuth.instance.currentUser!;

  TaskEditorViewModal() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
  }

  TaskEditorViewModal.fromTask(Task task) {
    taskId = task.id;
    nameController = TextEditingController(text: task.name);
    descriptionController = TextEditingController(text: task.description);
    dueDate = task.dueDate;
    debugPrint("TaskEditorViewModal.fromTask: $task");
  }

  bool get hasAllValuesEmpty => nameController.text.isEmpty && descriptionController.text.isEmpty && dueDate == null;

  /// Validates the form values and throws error if any of the fields are null or empty
  ///
  /// Returns [Task] if validation was successful
  Task validate() {
    String name = nameController.text.trim();
    if (name.isEmpty) throw "Name cannot be empty";

    String description = descriptionController.text.trim();
    if (description.isEmpty) throw "Description cannot be empty";

    if (dueDate == null) throw "Due date is not selected";

    return Task.create(name, description, dueDate!);
  }

  Future<void> createTask(BuildContext context, Task task) async {
    CreateTaskDto dto = CreateTaskDto(task);
    await FirebaseFirestore.instance.collection("users").doc(user.uid).collection("tasks").add(dto.map).then(
          (value) async => await value.get().then(
            (updatedTaskDocument) {
              Task createdTask = Task.fromJson(updatedTaskDocument.id, updatedTaskDocument.data()!);
              Navigator.pop(context);
              TaskDetails.showBottomModalSheet(context, createdTask);
            },
          ),
        );
  }

  Future<void> deleteTask() async =>
      await FirebaseFirestore.instance.collection("users").doc(user.uid).collection("tasks").doc(taskId).delete();

  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
  }
}
