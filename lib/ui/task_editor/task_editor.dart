library task_editor;

import 'package:flutter/material.dart';
import 'package:yodo/utils/globals.dart';
import 'package:yodo/widgets/primary_button.dart';
import 'package:yodo/widgets/primary_text_button.dart';

part '_task_date_picker.dart';

class TaskEditor extends StatefulWidget {
  const TaskEditor({Key? key}) : super(key: key);

  @override
  State<TaskEditor> createState() => _TaskEditorState();
}

class _TaskEditorState extends State<TaskEditor> {
  void _onSubmitTapped() async {
    debugPrint("_TaskEditorState._onSubmitTapped: ");
  }

  void _onDeleteTapped() async {
    debugPrint("_TaskEditorState._onDeleteTapped: ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Task"),
        iconTheme: IconThemeData(
          color: Colors.grey[700]!,
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                label: Text("Task name"),
              ),
            ),
            const SizedBox(height: 16.0),
            const TextField(
              minLines: 4,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                label: Text("Task description"),
                alignLabelWithHint: true,
                floatingLabelAlignment: FloatingLabelAlignment.start,
              ),
            ),
            const SizedBox(height: 16.0),
            const _TaskDatePicker(),
            const Expanded(
              child: SizedBox(),
            ),
            PrimaryButton(
              text: "Submit",
              expandedWidth: true,
              onTap: _onSubmitTapped,
            ),
            const SizedBox(height: 8.0),
            PrimaryTextButton(
              text: "Delete",
              onTap: _onDeleteTapped,
              textStyle: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
