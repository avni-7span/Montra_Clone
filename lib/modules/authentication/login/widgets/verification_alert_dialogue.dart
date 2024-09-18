import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class VerificationAlertDialogue extends StatelessWidget {
  const VerificationAlertDialogue(
      {super.key,
      required this.onClosedTap,
      required this.onResendEmailVerificationTap});

  final VoidCallback onClosedTap;
  final VoidCallback onResendEmailVerificationTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text(
          'You have not verified your email yet,Please verify your email.'),
      actions: [
        TextButton(
          onPressed: () {
            onResendEmailVerificationTap();
            onClosedTap();
          },
          child: Text(
            'Resend email',
            style: TextStyle(color: AppColors.instance.primary),
          ),
        ),
        TextButton(
          onPressed: onClosedTap,
          child: Text(
            'Okay',
            style: TextStyle(color: AppColors.instance.primary),
          ),
        )
      ],
    );
  }
}
