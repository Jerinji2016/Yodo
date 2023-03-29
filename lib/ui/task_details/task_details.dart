library task_details;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yodo/utils/themes.dart';

import '../../modals/task.dart';
import '../../routes.dart';
import '../../utils/globals.dart';
import '../../widgets/primary_bottom_sheet.dart';
import '../task_editor/task_editor.dart';

part '_task_action_buttons.dart';

class TaskDetails extends StatelessWidget {
  static void showBottomModalSheet(BuildContext context, Task task) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      builder: (context) => TaskDetails._(task: task),
    );
  }

  final Task task;

  const TaskDetails._({
    Key? key,
    required this.task,
  }) : super(key: key);

  void _onEditTapped(BuildContext context) {
    TaskEditorArgs args = TaskEditorArgs.edit(task);
    Navigator.pushReplacementNamed(context, Routes.manageTask, arguments: args);
  }

  void _onDuplicateTapped(BuildContext context) {
    Task duplicateTask = task.copyWith(name: "${task.name} (Copy)");
    TaskEditorArgs args = TaskEditorArgs.duplicate(duplicateTask);
    Navigator.pushReplacementNamed(context, Routes.manageTask, arguments: args);
  }

  Future<void> _onDeleteTapped(BuildContext context) async {
    await PrimaryBottomSheet.show(
      context: context,
      title: "Delete Task",
      description: "Are you sure you want to delete the task ${task.name}?",
      yesButton: const PrimaryBottomSheetButton(
        "Delete",
        TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
      noButton: const PrimaryBottomSheetButton(
        "Cancel",
        TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ).then((response) {
      if (!response) return;

      User user = FirebaseAuth.instance.currentUser!;
      Navigator.pop(context);
      FirebaseFirestore.instance.collection("users").doc(user.uid).collection("tasks").doc(task.id).delete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    task.name,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close),
                )
              ],
            ),
            const SizedBox(height: 0.0),
            Text(
              task.description,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              "Due on: ${globalDateFormat.format(task.dueDate)}",
              style: const TextStyle(
                fontSize: 14.0,
                color: Color(0xFFACB2E5),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Wrap(
                runSpacing: 10.0,
                spacing: 8.0,
                children: [
                  _TaskActionButtons(
                    icon: Icons.copy,
                    text: "Duplicate",
                    onTap: () => _onDuplicateTapped(context),
                  ),
                  _TaskActionButtons(
                    icon: Icons.edit,
                    text: "Edit",
                    onTap: () => _onEditTapped(context),
                  ),
                  _TaskActionButtons(
                    icon: Icons.delete_outline,
                    text: "Delete",
                    color: Colors.red,
                    onTap: () => _onDeleteTapped(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
