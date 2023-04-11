import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/src/features/tasks/presentation/add_task/add_task_screen_controller.dart';

import 'package:riverpod_todo/src/utils/async_value_ui.dart';

class AddTaskScreen extends HookConsumerWidget {
  final String? taskId;
  const AddTaskScreen({super.key, this.taskId});
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
        final success = await ref
            .read(addTaskScreenControllerProvider.notifier)
            .submit(title: _title!, description: _description!);
        if (success) {
          context.pop();
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton(
            onPressed: state.isLoading ? null : _submit,
            child: const Text(
              'Save',
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
              TextFormField(
                decoration: const InputDecoration(labelText: 'タイトル'),
                keyboardAppearance: Brightness.light,
                initialValue: _title,
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
            ],
          ),
        ),
      ),
    );
  }
}
