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
import 'package:riverpod_todo/src/features/projects/data/projects_repository.dart';
import 'package:riverpod_todo/src/features/projects/domain/project.dart';
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
    final addTaskScreenControllerProviderRef =
        ref.watch(addTaskScreenControllerProvider.notifier);

    final _formKey = GlobalKey<FormState>();

    var _members = useState<List<String>>([]);
    var _newMembers = useState<List<String>>([]);
    final TextEditingController searchController = TextEditingController();
    final TextEditingController foundUserIdController = TextEditingController();
    final TextEditingController foundUserNameController =
        TextEditingController();

    bool _validateAndSaveForm() {
      if (_members.value.isEmpty) {
        Fluttertoast.showToast(msg: "メンバーを一人以上設定してください");
        return false;
      }
      final form = _formKey.currentState!;
      if (form.validate()) {
        form.save();
        return true;
      }
      return false;
    }

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
      List<String> updatedList = List.from(_members.value);
      updatedList.removeAt(index);
      _members.value = updatedList;
      List<String> updatedNewMemberList = List.from(_newMembers.value);
      updatedNewMemberList.remove(data.userName);
      _newMembers.value = updatedNewMemberList;
      print(_newMembers.value);
    }

    Future<void> _submit() async {
      //プロジェクトを取得
      final Project project = await ref
          .read(projectsRepositoryProvider)
          .fetchProject(projectId: projectId);
      //ユーザーがプロジェクトのメンバーかどうか
      final bool isCurrentUserMember = ref
          .read(addTaskScreenControllerProvider.notifier)
          .checkMemberBelongToProject(project);
      if (!isCurrentUserMember) {
        Fluttertoast.showToast(msg: "メンバーではないためタスクの追加はできません");
        return;
      }
      final success =
          await ref.read(addTaskScreenControllerProvider.notifier).submit(
                title: addTaskScreenControllerProviderRef.titleController.text,
                description: addTaskScreenControllerProviderRef
                    .descriptionController.text,
                projectId: projectId,
                members: _members.value,
              );
      if (success) {
        context.pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("タスクを作成"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (_validateAndSaveForm()) {
                showConfirmDialog(
                    context: context,
                    title: "タスクの作成",
                    content: "タスクを作成しても良いですか",
                    onConfirmed: (isConfirmed) {
                      if (isConfirmed) {
                        _submit();
                      }
                    });
              }
            },
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
                controller: addTaskScreenControllerProviderRef.titleController,
                validator: (value) =>
                    (value ?? '').isNotEmpty ? null : '必須入力項目です',
              ),
              hpaddingBoxM,
              TextFormField(
                maxLines: 10,
                decoration: const InputDecoration(
                    labelText: '概要', alignLabelWithHint: true),
                keyboardAppearance: Brightness.light,
                controller:
                    addTaskScreenControllerProviderRef.descriptionController,
                validator: (value) =>
                    (value ?? '').isNotEmpty ? null : '必須入力項目です',
                keyboardType: const TextInputType.numberWithOptions(
                  signed: false,
                  decimal: false,
                ),
              ),
              hpaddingBoxM,
              /* 現在のメンバー */
              Text("メンバー ${_members.value.length}"),
              SizedBox(
                width: 300,
                height: 100,
                child: _members.value.isEmpty
                    ? const Center(child: Text('メンバーがいません'))
                    : ListView.builder(
                        itemCount: _members.value.length,
                        itemBuilder: (context, index) {
                          final userNames = ref.watch(
                              getAppUserByIdProvider(_members.value[index]));
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
              hpaddingBox,
              const Align(alignment: Alignment.topLeft, child: Text("メンバーを追加")),
              hpaddingBox,
              /* ユーザー検索 */
              SearchUserPart(
                searchController: searchController,
                foundUserIdController: foundUserIdController,
                foundUserNameController: foundUserNameController,
                addMember: () {
                  _addMember();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
