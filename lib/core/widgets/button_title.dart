import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class ButtonTitle extends StatelessWidget {
  const ButtonTitle({
    super.key,
    required this.isPurple,
    required this.buttonLabel,
  });

  final bool isPurple;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    return Text(
      buttonLabel,
      style: TextStyle(
        fontSize: 18,
        color: isPurple ? Colors.white : AppColors.instance.primary,
      ),
    );
  }
}
