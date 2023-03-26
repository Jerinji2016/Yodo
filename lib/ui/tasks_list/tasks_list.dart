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
        title: const Text("Yodo"),
        actions: [
          SafeArea(
            child: IconButton(
              onPressed: () => ProfileModal.show(context),
              padding: const EdgeInsets.all(16.0),
              enableFeedback: true,
              icon: Icon(
                Icons.person,
                color: Colors.grey[700]!,
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
        ),
      ),
      body: const _NoTasksView(),
    );
  }
}
