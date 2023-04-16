// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:riverpod_todo/src/common_widgets/empty_content.dart';
// import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';

// class SearchUser extends SearchDelegate {
//   final WidgetRef ref;

//   SearchUser(this.ref);
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           query = "";
//         },
//         icon: const Icon(Icons.close),
//       )
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return null;
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return const SizedBox();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return ref.watch(getAppUserByIdProvider(query)).when(
//       data: (data) {
//         return ListTile(
//           title: Text(data.userName ?? ""),
//           onTap: () {
//             context.pop();
//           },
//         );
//       },
//       error: (error, stackTrace) {
//         return const EmptyContent();
//       },
//       loading: () {
//         return const Center(child: CircularProgressIndicator());
//       },
//     );
//   }
// }
