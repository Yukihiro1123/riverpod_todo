import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/src/common_widgets/empty_content.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/auth/domain/app_user.dart';

import 'package:riverpod_todo/src/utils/style.dart';

class SearchUserPart extends HookConsumerWidget {
  final TextEditingController searchController;
  final TextEditingController foundUserNameController;
  final TextEditingController foundUserIdController;

  const SearchUserPart({
    super.key,
    required this.searchController,
    required this.foundUserIdController,
    required this.foundUserNameController,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? _userId;

    Future<void> _searchUser(String userId) async {
      AppUser? foundUser =
          await ref.read(authRepositoryProvider).searchUser(userId: userId);
      if (foundUser == null) {
        Fluttertoast.showToast(msg: "user not found");
        return;
      }
      foundUserNameController.text = foundUser.userName!;
      foundUserIdController.text = userId;
      print(foundUserNameController.text);
    }

    return Column(
      children: [
        TextFormField(
          controller: searchController,
          decoration: InputDecoration(
              label: const Text("ユーザーIDで検索"),
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
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          readOnly: true,
          controller: foundUserNameController,
        ),
        hpaddingBox,
      ],
    );
  }
}
