import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

BoxDecoration boxDecoration({required Color color, required double radius}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius),
  );
}

class TransactionButton extends StatelessWidget {
  const TransactionButton({
    super.key,
    required this.primaryColor,
    required this.secondaryColor,
    required this.icon,
    required this.onTap,
  });

  final Color primaryColor;
  final Color secondaryColor;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        height: 100,
        width: 120,
        decoration: boxDecoration(
          color: primaryColor,
          radius: 20,
        ),
        child: Container(
          height: 30,
          width: 30,
          decoration: boxDecoration(
            color: secondaryColor,
            radius: 50,
          ),
          child: Icon(
            icon,
            color: AppColors.instance.light100,
            size: 40,
          ),
        ),
      ),
    );
  }
}
