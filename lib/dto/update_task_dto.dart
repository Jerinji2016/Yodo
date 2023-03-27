import '../modals/task.dart';

class UpdateTaskDto {
  final Task task;

  UpdateTaskDto(this.task);

  Map<String, dynamic> get map => {
        "name": task.name,
        "description": task.description,
        "dueDate": task.dueDate.millisecondsSinceEpoch,
      };
}
