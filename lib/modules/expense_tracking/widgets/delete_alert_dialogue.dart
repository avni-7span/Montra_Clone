import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class DeleteAlertDialogue extends StatelessWidget {
  const DeleteAlertDialogue({
    super.key,
    required this.onNoTap,
    required this.onDeleteTap,
  });

  final VoidCallback onNoTap;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Icon(
        Icons.warning_amber,
        size: 45,
        color: AppColors.instance.primary,
      ),
      content: const Text(
        textAlign: TextAlign.center,
        'Are you sure you want to delete this transaction?',
        style: TextStyle(fontSize: 18),
      ),
      actions: [
        TextButton(
          onPressed: onNoTap,
          child: Text(
            'No',
            style: TextStyle(
              color: AppColors.instance.violet80,
              fontSize: 15,
            ),
          ),
        ),
        TextButton(
          onPressed: onDeleteTap,
          child: Text(
            'Delete',
            style: TextStyle(
              color: AppColors.instance.red80,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
