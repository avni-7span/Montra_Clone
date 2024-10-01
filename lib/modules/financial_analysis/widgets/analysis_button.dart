import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/image_paths.dart';

class AnalysisButton extends StatelessWidget {
  const AnalysisButton({
    super.key,
    required this.onBudgetTypeTap,
    required this.onCategoryTypeTap,
    required this.isBudgetType,
  });

  final bool isBudgetType;
  final VoidCallback onBudgetTypeTap;
  final VoidCallback onCategoryTypeTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onBudgetTypeTap,
          child: Container(
            padding: const EdgeInsets.all(7),
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.instance.light20),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              color: isBudgetType
                  ? AppColors.instance.primary
                  : AppColors.instance.light100,
            ),
            child: SvgPicture.asset(
              isBudgetType ? budgetActiveIcon : budgetInactiveIcon,
            ),
          ),
        ),
        GestureDetector(
          onTap: onCategoryTypeTap,
          child: Container(
            padding: const EdgeInsets.all(7),
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.instance.light20),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              color: isBudgetType
                  ? AppColors.instance.light100
                  : AppColors.instance.primary,
            ),
            child: SvgPicture.asset(
              isBudgetType ? categoryInactiveIcon : categoryActiveIcon,
            ),
          ),
        )
      ],
    );
  }
}
