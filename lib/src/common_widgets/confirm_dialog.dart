import 'package:flutter/material.dart';
import 'package:riverpod_todo/src/utils/colors.dart';
import 'package:riverpod_todo/src/utils/style.dart';

showConfirmDialog({
  required BuildContext context,
  required String title,
  required String content,
  required ValueChanged<bool> onConfirmed,
  String? yes,
  String? no,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return ConfirmDialog(
        title: title,
        content: content,
        onConfirmed: onConfirmed,
        yes: yes,
        no: no,
      );
    },
  );
}

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.onConfirmed,
    this.yes,
    this.no,
  }) : super(key: key);

  final String title;
  final String content;
  final String? yes;
  final String? no;
  final ValueChanged<bool> onConfirmed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          title,
        ),
      ),
      content: Text(
        content,
      ),
      actions: [
        Column(
          children: [
            const SizedBox(width: double.infinity, child: Divider()),
            //verticaldividerこれがないと表示されない
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      fixedSize: const Size(60, 50),
                    ),
                    child: Text(
                      no ?? "いいえ",
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      onConfirmed(false);
                    },
                  ),
                  const SizedBox(
                    height: 50,
                    child: VerticalDivider(),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      fixedSize: const Size(60, 50),
                    ),
                    child: Text(
                      yes ?? "はい",
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      onConfirmed(true);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
