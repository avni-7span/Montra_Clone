import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.label,
    required this.onTap,
    required this.isSelected,
  });

  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? Container(
            width: 90,
            height: 40,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.instance.yellow20,
              borderRadius: const BorderRadius.all(
                Radius.circular(18),
              ),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: AppColors.instance.yellow100,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: onTap,
            child: SizedBox(
              width: 90,
              height: 34,
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    color: AppColors.instance.dark25,
                  ),
                ),
              ),
            ),
          );
  }
}
