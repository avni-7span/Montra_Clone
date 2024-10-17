import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class CreateBudgetButton extends StatelessWidget {
  const CreateBudgetButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.instance.light40,
        ),
        child: Icon(
          Icons.create,
          color: AppColors.instance.primary,
          size: 25,
        ),
      ),
    );
  }
}
