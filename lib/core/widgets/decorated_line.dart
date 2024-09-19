import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class DecoratedLine extends StatelessWidget {
  const DecoratedLine({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        height: 8,
        width: 60,
        color: AppColors.instance.violet40,
      ),
    );
  }
}
