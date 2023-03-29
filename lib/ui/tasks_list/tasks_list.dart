library tasks_list;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yodo/providers/theme_provider.dart';
import 'package:yodo/utils/themes.dart';

import '../../modals/task.dart';
import '../../routes.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/profile_modal.dart';
import '../task_details/task_details.dart';

part '_no_tasks_view.dart';

class TasksList extends StatelessWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, Routes.manageTask),
        child: const Icon(
          Icons.add,
        ),
      ),
      backgroundColor: themeProvider.isDarkTheme ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .collection("tasks")
              .orderBy("dueDate", descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200.0,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                    collapseMode: CollapseMode.pin,
                    title: const Text(
                      "Yodo",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        const Image(
                          image: AssetImage("assets/images/header_bg.jpeg"),
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.lighten,
                          color: Colors.white12,
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Material(
                            color: Colors.black12,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  child: Center(
                                    child: Builder(builder: (context) {
                                      if (snapshot.data != null) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "${snapshot.data!.size}",
                                              style: const TextStyle(
                                                fontSize: 22.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const Text(
                                              "Tasks",
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.white54,
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                      return const Text("Loading..");
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              border: const Border(
                                bottom: BorderSide(
                                  width: 5.0,
                                  color: accentColor,
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  child: const Center(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    IconButton(
                      onPressed: () => ProfileModal.show(context),
                      padding: const EdgeInsets.all(16.0),
                      enableFeedback: true,
                      icon: const Icon(Icons.person),
                    ),
                  ],
                ),
                if (snapshot.data == null)
                  const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (snapshot.data != null)
                  snapshot.data!.docs.isEmpty
                      ? const _NoTasksView()
                      : SliverPadding(
                          padding: const EdgeInsets.only(bottom: 84.0),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot =
                                    snapshot.data!.docs.elementAt(index);
                                Task task = Task.fromJson(docSnapshot.id, docSnapshot.data());
                                return _TaskTile(task: task);
                              },
                              childCount: snapshot.data!.size,
                            ),
                          ),
                        ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  final Task task;

  const _TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[200]!,
            ),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => TaskDetails.showBottomModalSheet(context, task),
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(28.0),
                        ),
                        border: Border.all(
                          color: Colors.grey[200]!,
                        ),
                      ),
                      child: const SizedBox.square(
                        dimension: 56.0,
                        child: Icon(
                          Icons.task_alt_outlined,
                          color: accentColor,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                task.name,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            Text(
                              task.formattedDueDate,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          task.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
