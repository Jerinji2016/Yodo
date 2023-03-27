library task_editor;

import 'package:flutter/material.dart';
import 'package:yodo/utils/themes.dart';

import '../../enums/task_edit_type.dart';
import '../../modals/task.dart';
import '../../utils/globals.dart';
import '../../widgets/primary_bottom_sheet.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_text_button.dart';
import 'task_editor_view_modal.dart';

part '_task_date_picker.dart';

class TaskEditorArgs {
  final Task? task;
  final TaskEditType editType;

  const TaskEditorArgs.create()
      : task = null,
        editType = TaskEditType.create;

  TaskEditorArgs.edit(
    Task this.task,
  ) : editType = TaskEditType.edit;

  TaskEditorArgs.duplicate(
    Task this.task,
  ) : editType = TaskEditType.duplicate;
}

class TaskEditor extends StatefulWidget {
  final TaskEditorArgs args;

  const TaskEditor({
    Key? key,
    TaskEditorArgs? args,
  })  : args = args ?? const TaskEditorArgs.create(),
        super(key: key);

  @override
  State<TaskEditor> createState() => _TaskEditorState();
}

class _TaskEditorState extends State<TaskEditor> {
  late final TaskEditorViewModal _viewModal;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();

    if (widget.args.editType == TaskEditType.create) {
      _viewModal = TaskEditorViewModal();
    } else {
      _viewModal = TaskEditorViewModal.fromTask(widget.args.task!);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _viewModal.dispose();
  }

  void _onSubmitTapped() async {
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() => _isProcessing = true);
    try {
      Task task = _viewModal.validate();
      if (widget.args.editType == TaskEditType.edit) {
        //  update task
        await _viewModal.updateTask(context, task);
      } else {
        await _viewModal.createTask(context, task);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
    setState(() => _isProcessing = false);
  }

  void _onDeleteTapped() async => await PrimaryBottomSheet.show(
        context: context,
        title: "Delete Task",
        description: "Are you sure you want to delete the task ${widget.args.task!.name}?",
        yesButton: const PrimaryBottomSheetButton(
          "Delete",
          TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        noButton: const PrimaryBottomSheetButton(
          "Cancel",
          TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ).then(
        (response) {
          if (!response) return;

          _viewModal.deleteTask();
          Navigator.pop(context);
        },
      );

  Future<bool> _onPopScope() async {
    debugPrint("_TaskEditorState._onPopScope: ");
    if (_viewModal.hasAllValuesEmpty) {
      return true;
    }

    //  check for task hash
    //  ask for confirm discard

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onPopScope,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create New Task"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _viewModal.nameController,
                decoration: const InputDecoration(
                  label: Text("Task name"),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _viewModal.descriptionController,
                minLines: 4,
                maxLines: 4,
                decoration: const InputDecoration(
                  label: Text("Task description"),
                ),
              ),
              const SizedBox(height: 16.0),
              _TaskDatePicker(
                onDateSelected: (selectedDate) => _viewModal.dueDate = selectedDate,
                initialDateTime: _viewModal.dueDate,
              ),
              const Expanded(
                child: SizedBox(),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _isProcessing
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PrimaryButton(
                            text: "Submit",
                            expandedWidth: true,
                            onTap: _onSubmitTapped,
                          ),
                          if (widget.args.editType == TaskEditType.edit) ...[
                            const SizedBox(height: 8.0),
                            PrimaryTextButton(
                              text: "Delete",
                              onTap: _onDeleteTapped,
                              textStyle: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
