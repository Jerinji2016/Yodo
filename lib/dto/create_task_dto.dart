import '../modals/task.dart';

class CreateTaskDto {
  final Task task;

  CreateTaskDto(this.task);

  Map<String, dynamic> get map => {
        "name": task.name,
        "description": task.description,
        "dueDate": task.dueDate.millisecondsSinceEpoch,
      };
}
