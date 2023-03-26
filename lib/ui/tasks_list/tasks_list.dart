library tasks_list;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yodo/utils/globals.dart';

import '../../modals/task.dart';
import '../../routes.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/profile_modal.dart';

part '_no_tasks_view.dart';
part '_tasks_list_delegate.dart';

class TasksList extends StatelessWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;

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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .collection("tasks")
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            if (snapshot.data!.docs.isNotEmpty) {
              return _TasksListDelegate(
                data: snapshot.data!.docs,
              );
            } else {
              return const _NoTasksView();
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
