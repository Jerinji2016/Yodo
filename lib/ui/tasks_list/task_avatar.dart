import 'package:flutter/material.dart';

import '../../utils/themes.dart';

class TaskAvatar extends StatelessWidget {
  static const List<IconData> _mIcons = [
    Icons.edit_note_rounded,
    Icons.task_alt_outlined,
    Icons.meeting_room_outlined,
    Icons.calendar_month_outlined,
    Icons.alarm_rounded,
  ];

  final double radius;
  final int id;

  const TaskAvatar({
    Key? key,
    this.id = 0,
    this.radius = 32.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(36.0),
        ),
        border: Border.all(
          color: Colors.grey[500]!,
        ),
      ),
      child: SizedBox.square(
        dimension: radius * 2,
        child: Icon(
          _mIcons.elementAt(id % _mIcons.length),
          color: accentColor,
          size: radius,
        ),
      ),
    );
  }
}
