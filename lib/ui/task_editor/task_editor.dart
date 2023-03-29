library task_editor;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yodo/utils/themes.dart';

import '../../enums/task_edit_type.dart';
import '../../modals/task.dart';
import '../../providers/theme_provider.dart';
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
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    Color borderColor = themeProvider.isDarkTheme ? Colors.grey[800]! : Colors.grey[200]!;

    return WillPopScope(
      onWillPop: _onPopScope,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: accentColor,
          ),
          title: Text(
            widget.args.editType == TaskEditType.edit ? "Edit Task" : "Create New Task",
            style: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 60.0, top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(36.0),
                        ),
                        border: Border.all(
                          color: Colors.grey[500]!,
                        ),
                      ),
                      child: const SizedBox.square(
                        dimension: 72.0,
                        child: Icon(
                          Icons.task_alt_outlined,
                          color: accentColor,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ),
                TextField(
                  controller: _viewModal.nameController,
                  style: Theme.of(context).textTheme.headlineSmall,
                  decoration: const InputDecoration(
                    label: Text("Task name"),
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _viewModal.descriptionController,
                  minLines: 1,
                  maxLines: 4,
                  style: Theme.of(context).textTheme.headlineSmall,
                  decoration: const InputDecoration(
                    label: Text("Task description"),
                  ),
                ),
                const SizedBox(height: 8.0),
                _TaskDatePicker(
                  viewModal: _viewModal,
                  onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                ),
                const SizedBox(
                  height: 24.0,
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
                              borderRadius: 4.0,
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
      ),
    );
  }
}
