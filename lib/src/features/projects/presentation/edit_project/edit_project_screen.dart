import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/src/common_widgets/empty_content.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/auth/domain/app_user.dart';
import 'package:riverpod_todo/src/features/projects/data/projects_repository.dart';
import 'package:riverpod_todo/src/features/projects/domain/project.dart';
import 'package:riverpod_todo/src/features/projects/presentation/edit_project/edit_project_screen_controller.dart';
import 'package:riverpod_todo/src/features/projects/tasks/data/tasks_repository.dart';
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

    bool _validateAndSaveForm() {
      final form = _formKey.currentState!;
      if (form.validate()) {
        form.save();
        return true;
      }
      return false;
    }

    Future<void> _submit(Project project) async {
      if (_validateAndSaveForm()) {
        final success =
            await ref.read(editProjectScreenControllerProvider.notifier).submit(
                  title: _title!,
                  description: _description!,
                  project: project,
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
                          Text("メンバー ${data.members.length}"),
                          SizedBox(
                            width: 300,
                            height: 100,
                            child: ListView.builder(
                              itemCount: data.members.length,
                              itemBuilder: (context, index) {
                                final userNames = ref.watch(
                                    getAppUserByIdProvider(
                                        data.members[index]));
                                return userNames.when(
                                  data: (AppUser? data) {
                                    print("The data is $data");
                                    return ListTile(
                                        title: Text(data?.userName ?? "ユーザー"));
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
                          const Text("メンバーを追加"),
                          SizedBox(
                              width: 400,
                              child: TextFormField(
                                initialValue: _userId,
                                onSaved: (value) async {
                                  await Future.delayed(
                                    const Duration(seconds: 1),
                                  );
                                  _userId = value;
                                },
                              )),
                          hpaddingBoxL,
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
