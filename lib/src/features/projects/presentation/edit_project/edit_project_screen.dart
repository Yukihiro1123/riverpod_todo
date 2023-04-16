import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/src/common_widgets/empty_content.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/auth/domain/app_user.dart';
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
    String? _userId;
    String? _title;
    String? _description;
    var _members = useState<List<String>>([]);
    var _newMembers = useState<List<String>>([]);
    final TextEditingController searchController = TextEditingController();
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

    Future<void> _searchUser(String userId) async {
      AppUser? foundUser =
          await ref.read(authRepositoryProvider).searchUser(userId: userId);
      if (foundUser == null) {
        Fluttertoast.showToast(msg: "user not found");
        return;
      }
      foundUserNameController.text = foundUser.userName!;
      print(foundUserNameController.text);
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
              //_status = useState(data.status == 1 ? false : true);
              return Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text('タスクを編集'),
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
                            decoration: const InputDecoration(labelText: '概要'),
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
                                    print("The data is $data");
                                    return ListTile(
                                      title: Text(data?.userName ?? "ユーザー"),
                                      /* メンバーから省く */
                                      trailing: IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          if (_members.value.length == 1) {
                                            Fluttertoast.showToast(msg: "やめろ");
                                            return;
                                          }
                                          List<String> updatedList =
                                              List.from(_members.value);
                                          updatedList.removeAt(index);
                                          _members.value = updatedList;
                                          List<String> updatedNewMemberList =
                                              List.from(_newMembers.value);
                                          updatedNewMemberList
                                              .remove(data!.userName);
                                          _newMembers.value =
                                              updatedNewMemberList;
                                          print(_newMembers.value);
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
                          _newMembers.value.isEmpty
                              ? Container()
                              : SizedBox(
                                  width: 800,
                                  height: 100,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _newMembers.value.length,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        width: 100,
                                        child: ListTile(
                                            title:
                                                Text(_newMembers.value[index])),
                                      );
                                    },
                                  ),
                                ),
                          const Text("メンバーを追加"),
                          /* ユーザー検索 */
                          TextFormField(
                            controller: searchController,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                _searchUser(searchController.text);
                              },
                            )),
                            onSaved: (value) {
                              _userId = value;
                            },
                          ),
                          hpaddingBox,
                          /* 検索結果 */
                          TextFormField(
                            readOnly: true,
                            controller: foundUserNameController,
                          ),
                          hpaddingBox,
                          /* 追加ボタン*/
                          Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                                onPressed: () {
                                  if (foundUserNameController.text != "" &&
                                      !_newMembers.value.contains(
                                          foundUserNameController.text)) {
                                    _newMembers.value = [
                                      ..._newMembers.value,
                                      foundUserNameController.text
                                    ];
                                    _members.value = [
                                      ..._members.value,
                                      searchController.text
                                    ];
                                    print(" the member is ${_members.value}");
                                  }
                                  foundUserNameController.clear();
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
