import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/src/common_widgets/confirm_dialog.dart';
import 'package:riverpod_todo/src/common_widgets/empty_content.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/auth/domain/app_user.dart';
import 'package:riverpod_todo/src/features/projects/common_widgets/search_user_part.dart';
import 'package:riverpod_todo/src/features/projects/tasks/data/tasks_repository.dart';
import 'package:riverpod_todo/src/features/projects/tasks/domain/task/task.dart';
import 'package:riverpod_todo/src/features/projects/tasks/presentation/edit_task_screen/edit_task_screen_controller.dart';

import 'package:riverpod_todo/src/utils/async_value_ui.dart';
import 'package:riverpod_todo/src/utils/style.dart';

class EditTaskScreen extends HookConsumerWidget {
  final String projectId;
  final String taskId;

  const EditTaskScreen(
      {super.key, required this.projectId, required this.taskId});
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

    var _members = useState<List<String>>([]);
    var _newMembers = useState<List<String>>([]);

    final TextEditingController searchController = TextEditingController();
    final TextEditingController foundUserIdController = TextEditingController();
    final TextEditingController foundUserNameController =
        TextEditingController();

    void _addMember() {
      if (foundUserNameController.text != "" &&
          !_newMembers.value.contains(foundUserNameController.text) &&
          !_members.value.contains(foundUserIdController.text)) {
        _newMembers.value = [
          ..._newMembers.value,
          foundUserNameController.text
        ];
        _members.value = [..._members.value, foundUserIdController.text];

        print(" the member is ${_members.value}");
      }
      foundUserIdController.clear();
      foundUserNameController.clear();
      searchController.clear();
    }

    void _removeMember(int index, AppUser data) {
      if (_members.value.length == 1) {
        Fluttertoast.showToast(msg: "やめろ");
        return;
      }
      List<String> updatedList = List.from(_members.value);
      updatedList.removeAt(index);
      _members.value = updatedList;
      List<String> updatedNewMemberList = List.from(_newMembers.value);
      updatedNewMemberList.remove(data.userName);
      _newMembers.value = updatedNewMemberList;
      print(_newMembers.value);
    }

    bool _validateAndSaveForm() {
      final form = _formKey.currentState!;
      if (form.validate()) {
        form.save();
        return true;
      }
      return false;
    }

    Future<void> _submit(Task task) async {
      final success =
          await ref.read(editTaskScreenControllerProvider.notifier).submit(
                projectId: projectId,
                title: _title!,
                description: _description!,
                status: _status.value == false ? 1 : 2,
                members: _members.value,
                task: task,
              );
      if (success) {
        context.pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("タスクを編集"),
      ),
      body: ref.watch(taskStreamProvider(projectId, taskId)).when(
            data: (data) {
              //フォームの初期値
              _title = data.taskTitle;
              _description = data.taskDescription;
              _status = useState(data.status == 1 ? false : true);
              if (_members.value.isEmpty) {
                _members.value = data.members;
              }
              return Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Column(
                              children: [
                                const Text('完了済みフラグ'),
                                Switch(
                                  value: _status.value,
                                  onChanged: (value) {
                                    _status.value = value;

                                    print(_status.value);
                                  },
                                ),
                              ],
                            ),
                          ),
                          hpaddingBox,
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'タイトル'),
                            keyboardAppearance: Brightness.light,
                            initialValue: _title,
                            validator: (value) =>
                                (value ?? '').isNotEmpty ? null : '必須入力項目です',
                            onSaved: (value) => _title = value,
                          ),
                          hpaddingBoxM,
                          TextFormField(
                            maxLines: 10,
                            decoration: const InputDecoration(
                                labelText: '概要', alignLabelWithHint: true),
                            keyboardAppearance: Brightness.light,
                            initialValue: _description,
                            validator: (value) {
                              return (value ?? '').isNotEmpty
                                  ? null
                                  : '必須入力項目です';
                            },
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: false,
                              decimal: false,
                            ),
                            onSaved: (value) {
                              _description = _description = value;
                            },
                          ),
                          hpaddingBoxM,
                          Text("メンバー ${data.members.length}"),
                          /* 現在のメンバー */
                          SizedBox(
                            width: 300,
                            height: 100,
                            child: ListView.builder(
                              itemCount: _members.value.length,
                              itemBuilder: (context, index) {
                                final userNames = ref.watch(
                                    getAppUserByIdProvider(
                                        _members.value[index]));
                                return userNames.when(
                                  data: (AppUser? data) {
                                    return ListTile(
                                      title: Text(data?.userName ?? "ユーザー"),
                                      /* メンバーから省く */
                                      trailing: IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          _removeMember(index, data!);
                                        },
                                      ),
                                    );
                                  },
                                  error: (error, stackTrace) {
                                    print(error);
                                    return const EmptyContent();
                                  },
                                  loading: () => const Center(
                                      child: CupertinoActivityIndicator()),
                                );
                              },
                            ),
                          ),
                          const Divider(),
                          const Align(
                              alignment: Alignment.topLeft,
                              child: Text("メンバーを追加")),

                          /* ユーザー検索 */
                          SearchUserPart(
                            searchController: searchController,
                            foundUserIdController: foundUserIdController,
                            foundUserNameController: foundUserNameController,
                          ),
                          /* ユーザー追加 */
                          Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                                onPressed: () {
                                  _addMember();
                                },
                                icon: const Icon(Icons.add)),
                          ),
                          /* 更新ボタン */
                          hpaddingBoxL,
                          SizedBox(
                            width: 300,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_validateAndSaveForm()) {
                                  showConfirmDialog(
                                      context: context,
                                      title: "タスクの更新",
                                      content: "タスクを更新しても良いですか",
                                      onConfirmed: (isConfirmed) {
                                        if (isConfirmed) {
                                          _submit(data);
                                        }
                                      });
                                }
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
            loading: () => const Center(child: CupertinoActivityIndicator()),
          ),
    );
  }
}
