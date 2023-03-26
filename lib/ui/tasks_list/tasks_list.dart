library tasks_list;

import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/profile_modal.dart';

part '_no_tasks_view.dart';

class TasksList extends StatelessWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5.0,
        shadowColor: Colors.grey[100]!,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
        ),
        title: const Text(
          "Yodo",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        actions: [
          SafeArea(
            child: IconButton(
              onPressed: () => ProfileModal.show(context),
              padding: const EdgeInsets.all(16.0),
              enableFeedback: true,
              icon: const Icon(
                Icons.person,
                color: Colors.orange,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, Routes.manageTask),
        backgroundColor: Colors.orange,
        child: const Icon(
          Icons.add,
          // color: Colors.white,
        ),
      ),
      body: const _NoTasksView(),
    );
  }
}
