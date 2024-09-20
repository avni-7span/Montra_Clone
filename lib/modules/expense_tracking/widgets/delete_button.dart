import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    super.key,
    required this.buttonLabel,
    required this.onPressed,
  });

  final Widget buttonLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 56,
      width: 343,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            AppColors.instance.red20,
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        child: buttonLabel,
      ),
    );
  }
}
