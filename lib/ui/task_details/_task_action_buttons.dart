part of task_details;

class _TaskActionButtons extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color color;

  const _TaskActionButtons({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.color = Colors.orange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderOnForeground: true,
      elevation: 4.0,
      shadowColor: Colors.grey[100]!,
      color: color,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(width: 4.0),
              Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
