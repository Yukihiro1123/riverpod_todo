import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/src/common_widgets/empty_content.dart';
import 'package:riverpod_todo/src/features/tasks/data/tasks_repository.dart';
import 'package:riverpod_todo/src/features/tasks/domain/task/task.dart';
import 'package:riverpod_todo/src/features/tasks/presentation/edit_task_screen/edit_task_screen_controller.dart';

import 'package:riverpod_todo/src/utils/async_value_ui.dart';

class EditTaskScreen extends HookConsumerWidget {
  final String taskId;

  const EditTaskScreen({super.key, required this.taskId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      editTaskScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(editTaskScreenControllerProvider);

    final _formKey = GlobalKey<FormState>();

    String? _title;
    String? _description;

    bool _validateAndSaveForm() {
      final form = _formKey.currentState!;
      if (form.validate()) {
        form.save();
        return true;
      }
      return false;
    }

    Future<void> _submit(Task task) async {
      if (_validateAndSaveForm()) {
        final success = await ref
            .read(editTaskScreenControllerProvider.notifier)
            .submit(title: _title!, description: _description!, task: task);
        if (success) {
          context.pop();
        }
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: ref.watch(taskStreamProvider(taskId)).when(
            data: (data) {
              _title = data.title;
              _description = data.description;
              return Form(
                key: _formKey,
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'タイトル'),
                        keyboardAppearance: Brightness.light,
                        initialValue: data.title,
                        validator: (value) =>
                            (value ?? '').isNotEmpty ? null : '必須入力項目です',
                        onSaved: (value) => _title = value,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: '概要'),
                        keyboardAppearance: Brightness.light,
                        initialValue: _description,
                        validator: (value) =>
                            (value ?? '').isNotEmpty ? null : '必須入力項目です',
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: false,
                          decimal: false,
                        ),
                        onSaved: (value) => _description = _description = value,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _submit(data);
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            error: (error, stackTrace) {
              print(error);
              return const EmptyContent();
            },
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
