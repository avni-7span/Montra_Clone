import 'package:flutter/material.dart';

class SuccessDialogue extends StatelessWidget {
  const SuccessDialogue({
    super.key,
    required this.successMessage,
    required this.onOkTap,
  });

  final String successMessage;
  final VoidCallback onOkTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Image.asset(
        'assets/icons/done.png',
        height: 60,
        width: 60,
      ),
      content: Text(successMessage),
      actions: [TextButton(onPressed: onOkTap, child: const Text('OK'))],
    );
  }
}
