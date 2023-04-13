import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/src/features/projects/tasks/presentation/add_task/add_task_screen_controller.dart';

import 'package:riverpod_todo/src/utils/async_value_ui.dart';
import 'package:riverpod_todo/src/utils/style.dart';

class AddTaskScreen extends HookConsumerWidget {
  final String projectId;
  const AddTaskScreen({super.key, required this.projectId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      addTaskScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(addTaskScreenControllerProvider);

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

    Future<void> _submit() async {
      if (_validateAndSaveForm()) {
        print("projectID: $projectId");
        final success =
            await ref.read(addTaskScreenControllerProvider.notifier).submit(
                  title: _title!,
                  description: _description!,
                  projectId: projectId,
                );
        if (success) {
          context.pop();
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("タスクを作成"),
        actions: <Widget>[
          TextButton(
            onPressed: state.isLoading ? null : _submit,
            child: const Text(
              '作成',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              hpaddingBox,
              TextFormField(
                decoration: const InputDecoration(labelText: 'タイトル'),
                keyboardAppearance: Brightness.light,
                initialValue: _title,
                validator: (value) =>
                    (value ?? '').isNotEmpty ? null : '必須入力項目です',
                onSaved: (value) => _title = value,
              ),
              hpaddingBoxL,
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
            ],
          ),
        ),
      ),
    );
  }
}
