import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/modules/financial_analysis/widgets/analysis_button.dart';

class FilterRow extends StatelessWidget {
  const FilterRow({
    super.key,
    required this.isBudgetType,
    required this.onBudgetTypeTap,
    required this.onCategoryTypeTap,
  });

  final bool isBudgetType;
  final VoidCallback onBudgetTypeTap;
  final VoidCallback onCategoryTypeTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const FilterContainer(),
        AnalysisButton(
          onBudgetTypeTap: onBudgetTypeTap,
          onCategoryTypeTap: onCategoryTypeTap,
          isBudgetType: isBudgetType,
        ),
      ],
    );
  }
}

class FilterContainer extends StatelessWidget {
  const FilterContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 96,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: AppColors.instance.dark25,
        ),
      ),
      child: Center(
        child: Text(
          'Month',
          style: TextStyle(color: AppColors.instance.primary, fontSize: 18),
        ),
      ),
    );
  }
}
