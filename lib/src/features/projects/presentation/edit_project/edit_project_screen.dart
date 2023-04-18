import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/src/common_widgets/confirm_dialog.dart';
import 'package:riverpod_todo/src/common_widgets/empty_content.dart';
import 'package:riverpod_todo/src/common_widgets/shimmer_effect.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/auth/domain/app_user.dart';
import 'package:riverpod_todo/src/features/projects/common_widgets/search_user_part.dart';
import 'package:riverpod_todo/src/features/projects/data/projects_repository.dart';
import 'package:riverpod_todo/src/features/projects/domain/project.dart';
import 'package:riverpod_todo/src/features/projects/presentation/edit_project/edit_project_screen_controller.dart';
import 'package:riverpod_todo/src/utils/async_value_ui.dart';

import 'package:riverpod_todo/src/utils/style.dart';

class EditProjectScreen extends HookConsumerWidget {
  final String projectId;
  const EditProjectScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      editProjectScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(editProjectScreenControllerProvider);
    final editProjectScreenControllerProviderRef =
        ref.watch(editProjectScreenControllerProvider.notifier);
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
      if (_members.value.length == 1) {
        Fluttertoast.showToast(msg: "メンバーは最低一人設定してください");
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

    Future<void> _submit(Project project) async {
      final success = await ref
          .read(editProjectScreenControllerProvider.notifier)
          .submit(
            title: editProjectScreenControllerProviderRef.titleController.text,
            description: editProjectScreenControllerProviderRef
                .descriptionController.text,
            project: project,
            members: _members.value,
          );
      if (success) {
        context.pop();
      }
    }

    Future<void> _delete(String projectId) async {
      final success = await ref
          .read(editProjectScreenControllerProvider.notifier)
          .delete(projectId: projectId);
      if (success) {
        context.pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("プロジェクトを編集"),
      ),
      body: ref.watch(projectStreamProvider(projectId)).when(
            data: (data) {
              final bool isReadOnly = ref
                  .read(editProjectScreenControllerProvider.notifier)
                  .isProjectFormReadOnly(data);
              print("readonly: $isReadOnly");
              //フォームの初期値
              if (editProjectScreenControllerProviderRef.titleController.text ==
                  "") {
                editProjectScreenControllerProviderRef.titleController.text =
                    data.projectTitle;
              }

              if (editProjectScreenControllerProviderRef
                      .descriptionController.text ==
                  "") {
                editProjectScreenControllerProviderRef
                    .descriptionController.text = data.projectTitle;
              }

              if (_members.value.isEmpty) {
                _members.value = data.members;
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    isReadOnly
                        ? const SizedBox.shrink()
                        : Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              tooltip: "プロジェクトを削除",
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                showConfirmDialog(
                                    context: context,
                                    title: "プロジェクトの削除",
                                    content: "プロジェクトを削除してもよろしいですか",
                                    onConfirmed: (isConfirmed) {
                                      if (isConfirmed) {
                                        _delete(data.projectId);
                                      }
                                    });
                              },
                            ),
                          ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  const Text('プロジェクトを編集'),
                                  hpaddingBoxL,
                                  TextFormField(
                                    readOnly: isReadOnly,
                                    decoration: const InputDecoration(
                                        labelText: 'タイトル'),
                                    keyboardAppearance: Brightness.light,
                                    controller:
                                        editProjectScreenControllerProviderRef
                                            .titleController,
                                    validator: (value) =>
                                        (value ?? '').isNotEmpty
                                            ? null
                                            : '必須入力項目です',
                                  ),
                                  hpaddingBoxL,
                                  TextFormField(
                                    readOnly: isReadOnly,
                                    maxLines: 10,
                                    decoration: const InputDecoration(
                                        labelText: '概要',
                                        alignLabelWithHint: true),
                                    keyboardAppearance: Brightness.light,
                                    controller:
                                        editProjectScreenControllerProviderRef
                                            .descriptionController,
                                    validator: (value) {
                                      return (value ?? '').isNotEmpty
                                          ? null
                                          : '必須入力項目です';
                                    },
                                    keyboardType: TextInputType.multiline,
                                  ),
                                  hpaddingBoxL,
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
                                              title: Text(
                                                  data?.userName ?? "ユーザー"),
                                              /* メンバーから省く */
                                              trailing: IconButton(
                                                icon: const Icon(Icons.remove),
                                                onPressed: () {
                                                  if (!isReadOnly) {
                                                    _removeMember(index, data!);
                                                  }
                                                },
                                              ),
                                            );
                                          },
                                          error: (error, stackTrace) {
                                            print(error);
                                            return const EmptyContent();
                                          },
                                          loading: () => SizedBox(
                                            width: 300,
                                            height: 100,
                                            child: ListView.separated(
                                                separatorBuilder: (context,
                                                        index) =>
                                                    const SizedBox(height: 10),
                                                itemCount: 2,
                                                itemBuilder: (context, index) {
                                                  return const ShimmerImage(
                                                      width: 300);
                                                }),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const Divider(),
                                  hpaddingBox,
                                  isReadOnly
                                      ? const SizedBox.shrink()
                                      : const Align(
                                          alignment: Alignment.topLeft,
                                          child: Text("メンバーを追加")),
                                  hpaddingBox,
                                  /* ユーザー検索 */
                                  isReadOnly
                                      ? const SizedBox.shrink()
                                      : SearchUserPart(
                                          searchController: searchController,
                                          foundUserIdController:
                                              foundUserIdController,
                                          foundUserNameController:
                                              foundUserNameController,
                                          addMember: () {
                                            _addMember();
                                          },
                                        ),
                                  /* 更新ボタン */
                                  hpaddingBoxL,
                                  isReadOnly
                                      ? const SizedBox.shrink()
                                      : SizedBox(
                                          width: 300,
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (_validateAndSaveForm()) {
                                                showConfirmDialog(
                                                    context: context,
                                                    title: "プロジェクト情報の更新",
                                                    content:
                                                        "プロジェクト情報を更新してもよろしいですか",
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
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
