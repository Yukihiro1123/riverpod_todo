import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/src/common_widgets/empty_content.dart';
import 'package:riverpod_todo/src/features/tasks/data/tasks_repository.dart';
import 'package:riverpod_todo/src/features/tasks/domain/task/task.dart';
import 'package:riverpod_todo/src/features/tasks/presentation/edit_task_screen/edit_task_screen_controller.dart';

import 'package:riverpod_todo/src/utils/async_value_ui.dart';
import 'package:riverpod_todo/src/utils/style.dart';

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
    var _status;

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
            .submit(
                title: _title!,
                description: _description!,
                status: _status == false ? 1 : 2,
                task: task);
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
              _status = useState(data.status == 1 ? false : true);
              return Center(
                child: Form(
                  key: _formKey,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text('タスクを編集'),
                          hpaddingBoxL,
                          SizedBox(
                            width: 400,
                            child: TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'タイトル'),
                              keyboardAppearance: Brightness.light,
                              initialValue: _title,
                              validator: (value) =>
                                  (value ?? '').isNotEmpty ? null : '必須入力項目です',
                              onSaved: (value) => _title = value,
                            ),
                          ),
                          hpaddingBoxL,
                          SizedBox(
                            width: 400,
                            child: TextFormField(
                              decoration:
                                  const InputDecoration(labelText: '概要'),
                              keyboardAppearance: Brightness.light,
                              initialValue: _description,
                              validator: (value) {
                                return (value ?? '').isNotEmpty
                                    ? null
                                    : '必須入力項目です';
                              },
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                signed: false,
                                decimal: false,
                              ),
                              onSaved: (value) {
                                _description = _description = value;
                              },
                            ),
                          ),
                          hpaddingBoxL,
                          Text('完了済みフラグ'),
                          Switch(
                            value: _status.value,
                            onChanged: (value) {
                              _status.value = value;

                              print(_status.value);
                            },
                          ),
                          SizedBox(
                            width: 300,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                _submit(data);
                              },
                              child: const Text(
                                '更新',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
