import 'package:flutter/material.dart';

import '../widgets/profile_modal.dart';

class TasksList extends StatelessWidget {
  const TasksList({Key? key}) : super(key: key);

  void _navigateToCreateTask(BuildContext context) {
    debugPrint("TasksList._navigateToCreateTask: ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
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
        onPressed: () => _navigateToCreateTask(context),
      ),
    );
  }
}
