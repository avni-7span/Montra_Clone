import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/modules/financial_analysis/widgets/analysis_button.dart';

class FilterRow extends StatelessWidget {
  const FilterRow({
    super.key,
    required this.isBudgetType,
    required this.onBudgetTypeTap,
    required this.onCategoryTypeTap,
    required this.onFilterTap,
  });

  final bool isBudgetType;
  final VoidCallback onBudgetTypeTap;
  final VoidCallback onCategoryTypeTap;
  final Function(String? value) onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FilterDropDown(
          onChanged: onFilterTap,
          selectedValue: 'Month',
        ),
        AnalysisButton(
          onBudgetTypeTap: onBudgetTypeTap,
          onCategoryTypeTap: onCategoryTypeTap,
          isBudgetType: isBudgetType,
        ),
      ],
    );
  }
}

class FilterDropDown extends StatelessWidget {
  const FilterDropDown({
    super.key,
    this.selectedValue = 'Month',
    required this.onChanged,
  });

  final String selectedValue;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 105,
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        value: selectedValue,
        decoration: InputDecoration(
          hintText: selectedValue,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        items: ['Week', 'Month', 'Year'].map((String option) {
          return DropdownMenuItem<String>(
            alignment: Alignment.center,
            value: option,
            child: Text(
              option,
              style: TextStyle(color: AppColors.instance.dark25),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
