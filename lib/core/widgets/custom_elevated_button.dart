import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.buttonLabel,
    required this.isPurple,
    required this.onPressed,
  });

  final String buttonLabel;
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
              ? AppColors.instance.violet100
              : AppColors.instance.violet20),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        child: Text(
          buttonLabel,
          style: TextStyle(
            fontSize: 18,
            color: isPurple ? Colors.white : AppColors.instance.violet100,
          ),
        ),
      ),
    );
  }
}
