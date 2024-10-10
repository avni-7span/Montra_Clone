import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app_ui/theme/utils/extensions.dart';
import 'package:montra_clone/app_ui/widgets/atoms/border_radius.dart';
import 'package:montra_clone/app_ui/widgets/atoms/padding.dart';

class CategoryDropDown extends StatelessWidget {
  const CategoryDropDown({
    super.key,
    required this.isExpense,
    this.selectedValue,
    required this.onChanged,
  });

  final bool isExpense;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    List<String> options = isExpense
        ? ['Food', 'Subscription', 'Shopping', 'Transportation']
        : ['Salary', 'Rental Income', 'Interest'];
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
        hintText: 'Choose Category',
        contentPadding: const EdgeInsets.all(Insets.medium16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.medium16),
          // borderSide: BorderSide(
          //   color: AppColors.instance.light20.withOpacity(0.5),
          // ),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: context.colorScheme.light100,
      ),
      items: options.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Center(
            child: Text(
              option,
              style: TextStyle(color: AppColors.instance.dark25),
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
