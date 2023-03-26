library task_editor;

import 'package:flutter/material.dart';

class TaskEditor extends StatefulWidget {
  const TaskEditor({Key? key}) : super(key: key);

  @override
  State<TaskEditor> createState() => _TaskEditorState();
}

class _TaskEditorState extends State<TaskEditor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Task"),
      ),
      body: Container(),
    );
  }
}
