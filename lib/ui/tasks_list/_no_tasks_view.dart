part of tasks_list;

class _NoTasksView extends StatelessWidget {
  const _NoTasksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Image(
                  image: AssetImage(
                    "assets/images/no_tasks_illustration.png",
                  ),
                  color: Colors.transparent,
                  colorBlendMode: BlendMode.difference,
                ),
              ),
              Text(
                "Congrats! You dont have no Incomplete tasks",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryButton(
                prefixIcon: Icons.add,
                text: "New TODO",
                borderRadius: 30.0,
                onTap: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
