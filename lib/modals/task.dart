import 'package:flutter/cupertino.dart';
import 'package:yodo/utils/globals.dart';

class Task {
  final String id;

  final String name;
  final String description;
  final DateTime dueDate;

  Task.create(this.name, this.description, this.dueDate) : id = UniqueKey().toString();

  Task.fromJson(this.id, Map<String, dynamic> json)
      : name = json["name"],
        description = json["description"],
        dueDate = DateTime.fromMillisecondsSinceEpoch(json["dueDate"]);

  String get formattedDueDate {
    DateTime today = DateTime.now().copyWith(hour: 0, minute: 0, second: 0, microsecond: 0, millisecond: 0);
    if (dueDate.isAtSameMomentAs(today)) {
      return "Today";
    }

    DateTime tomorrow = today.add(const Duration(days: 1));
    if (tomorrow.isAtSameMomentAs(dueDate)) {
      return "Tomorrow";
    }

    DateTime yesterday = today.subtract(const Duration(days: 1));
    if (yesterday.isAtSameMomentAs(dueDate)) {
      return "Yesterday";
    }

    return globalDateFormat.format(dueDate);
  }

  @override
  String toString() => "Task($name, $dueDate)";

  @override
  int get hashCode => Object.hash(name, description, dueDate);

  Task copyWith({String? name, String? description, DateTime? dueDate}) => Task.create(
        name ?? this.name,
        description ?? this.description,
        dueDate ?? this.dueDate,
      );

  @override
  bool operator ==(Object other) {
    if (other is Task) {
      return super.hashCode == other.hashCode;
    }
    return false;
  }
}
