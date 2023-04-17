import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/src/common_widgets/empty_content.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/auth/domain/app_user.dart';
import 'package:riverpod_todo/src/features/projects/common_widgets/search_user_part.dart';
import 'package:riverpod_todo/src/features/projects/data/projects_repository.dart';
import 'package:riverpod_todo/src/features/projects/domain/project.dart';
import 'package:riverpod_todo/src/features/projects/presentation/edit_project/edit_project_screen_controller.dart';

import 'package:riverpod_todo/src/utils/style.dart';

class EditProjectScreen extends HookConsumerWidget {
  final String projectId;
  const EditProjectScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();
    String? _title;
    String? _description;
    var _members = useState<List<String>>([]);
    var _newMembers = useState<List<String>>([]);

    final TextEditingController searchController = TextEditingController();
    final TextEditingController foundUserIdController = TextEditingController();
    final TextEditingController foundUserNameController =
        TextEditingController();

    bool _validateAndSaveForm() {
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

    Future<void> _submit(Project project) async {
      if (_validateAndSaveForm()) {
        final success =
            await ref.read(editProjectScreenControllerProvider.notifier).submit(
                  title: _title!,
                  description: _description!,
                  project: project,
                  members: _members.value,
                );
        if (success) {
          context.pop();
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("タスクを編集"),
      ),
      body: ref.watch(projectStreamProvider(projectId)).when(
            data: (data) {
              _title = data.projectTitle;
              _description = data.projectDescription;
              if (_members.value.isEmpty) {
                _members.value = data.members;
              }
              return Center(
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
                              decoration:
                                  const InputDecoration(labelText: 'タイトル'),
                              keyboardAppearance: Brightness.light,
                              initialValue: _title,
                              validator: (value) =>
                                  (value ?? '').isNotEmpty ? null : '必須入力項目です',
                              onSaved: (value) => _title = value,
                            ),
                            hpaddingBoxL,
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
                              keyboardType: TextInputType.multiline,
                              onSaved: (value) {
                                _description = _description = value;
                              },
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
                                        child: CircularProgressIndicator()),
                                  );
                                },
                              ),
                            ),
                            const Divider(),
                            hpaddingBox,
                            const Align(
                                alignment: Alignment.topLeft,
                                child: Text("メンバーを追加")),
                            hpaddingBox,
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
                                  print("original members ${data.members}");
                                  print(
                                      "The members are ${_members.value} type is ${_members.value.runtimeType}");
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
