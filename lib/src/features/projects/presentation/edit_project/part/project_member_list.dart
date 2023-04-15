import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProjectMemberList extends HookConsumerWidget {
  final List<String> members;
  const ProjectMemberList({super.key, required this.members});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
