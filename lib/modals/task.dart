import 'package:flutter/cupertino.dart';

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
