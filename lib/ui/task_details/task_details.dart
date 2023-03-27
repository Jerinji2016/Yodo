library task_details;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yodo/ui/task_editor/task_editor.dart';
import 'package:yodo/utils/globals.dart';

import '../../modals/task.dart';
import '../../routes.dart';

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
    User user = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance.collection("users").doc(user.uid).collection("tasks").doc(task.id).delete().then(
      (value) {
        debugPrint("TaskDetails._onDeleteTapped: deleted");
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
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
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10.0),
            Text(
              task.description,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              "Due on: ${globalDateFormat.format(task.dueDate)}",
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24.0),
            Wrap(
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
            )
          ],
        ),
      ),
    );
  }
}

class _TaskActionButtons extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color color;

  const _TaskActionButtons({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.color = Colors.orange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderOnForeground: true,
      elevation: 4.0,
      shadowColor: Colors.grey[100]!,
      color: color,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(width: 4.0),
              Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
