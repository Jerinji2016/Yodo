library manage_task;

import 'package:flutter/material.dart';

class ManageTask extends StatefulWidget {
  const ManageTask({Key? key}) : super(key: key);

  @override
  State<ManageTask> createState() => _ManageTaskState();
}

class _ManageTaskState extends State<ManageTask> {
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
