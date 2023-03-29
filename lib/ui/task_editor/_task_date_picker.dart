part of task_editor;

class _TaskDatePicker extends StatefulWidget {
  final TaskEditorViewModal viewModal;
  final VoidCallback onTap;

  const _TaskDatePicker({
    Key? key,
    required this.viewModal,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_TaskDatePicker> createState() => _TaskDatePickerState();
}

class _TaskDatePickerState extends State<_TaskDatePicker> {
  late DateTime? _selectedDate = widget.viewModal.dueDate;
  final TextEditingController dateController = TextEditingController();

  bool get hasValidDate => _selectedDate != null;

  @override
  void initState() {
    super.initState();
    if (widget.viewModal.dueDate != null) {
      dateController.text = globalDateFormat.format(widget.viewModal.dueDate!);
    }
  }

  void _selectDate() async {
    widget.onTap.call();

    DateTime now = DateTime.now();
    DateTime firstDate = now, lastDate = now.copyWith(year: 2100);

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate == null) {
      //  ignore no date selected
      return;
    }

    widget.viewModal.dueDate = selectedDate;
    setState(
      () {
        dateController.text = globalDateFormat.format(widget.viewModal.dueDate!);
        _selectedDate = selectedDate;
      },
    );
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: _selectDate,
          child: TextField(
            enabled: false,
            controller: dateController,
            style: Theme.of(context).textTheme.headlineSmall,
            decoration: InputDecoration(
              label: const Text("Due Date"),
              disabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
            ),
          ),
        ),
      ],
    );
  }
}
