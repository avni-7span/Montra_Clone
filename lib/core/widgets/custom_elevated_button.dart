import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.buttonLabel,
    required this.isPurple,
    required this.onPressed,
  });

  final Widget buttonLabel;
  final bool isPurple;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: 343,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(isPurple
              ? AppColors.instance.primary
              : AppColors.instance.violet20),
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
