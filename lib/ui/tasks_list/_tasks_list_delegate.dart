part of tasks_list;

class _TasksListDelegate extends StatelessWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> data;

  const _TasksListDelegate({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      padding: const EdgeInsets.only(bottom: 32.0, top: 10.0),
      itemBuilder: (context, index) {
        QueryDocumentSnapshot<Map<String, dynamic>> snapshot = data.elementAt(index);
        Task task = Task.fromJson(snapshot.id, snapshot.data());
        return _TaskTile(task: task);
      },
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Material(
        color: Colors.white,
        elevation: 8.0,
        shadowColor: Colors.grey[100],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: InkWell(
          onTap: () {},
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.name,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        task.description,
                        style: const TextStyle(),
                      ),
                    ],
                  ),
                ),
                Text(
                  globalDateFormat.format(task.dueDate),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
