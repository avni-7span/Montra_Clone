import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

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
      title: Icon(
        Icons.task_alt,
        size: 50,
        color: AppColors.instance.primary,
      ),
      content: Text(successMessage),
      actions: [
        TextButton(
          onPressed: onOkTap,
          child: const Text('OK'),
        ),
      ],
    );
  }
}
