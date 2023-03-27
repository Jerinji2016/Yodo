part of task_editor;

class _TaskDatePicker extends StatefulWidget {
  final DateTime? initialDateTime;
  final Function(DateTime selectedDate) onDateSelected;

  const _TaskDatePicker({
    Key? key,
    this.initialDateTime,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  State<_TaskDatePicker> createState() => _TaskDatePickerState();
}

class _TaskDatePickerState extends State<_TaskDatePicker> {
  late DateTime? _selectedDate = widget.initialDateTime;

  bool get hasValidDate => _selectedDate != null;

  void _selectDate() async {
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

    widget.onDateSelected.call(selectedDate);
    setState(
      () => _selectedDate = selectedDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Due Date",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[600]!,
          ),
        ),
        const SizedBox(height: 4.0),
        GestureDetector(
          onTap: _selectDate,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
              border: Border.all(
                color: Theme.of(context).inputDecorationTheme.border!.borderSide.color,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Row(
                children: [
                  Text(
                    _selectedDate != null ? globalDateFormat.format(_selectedDate!) : "Select due date",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: _selectedDate != null ? null : darkDisabledColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
