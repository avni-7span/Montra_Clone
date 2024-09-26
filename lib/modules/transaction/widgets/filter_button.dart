import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: isSelected
                ? AppColors.instance.light100
                : AppColors.instance.dark25,
          ),
          color: isSelected
              ? AppColors.instance.violet20
              : AppColors.instance.light100,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? AppColors.instance.primary
                  : AppColors.instance.dark100,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
