import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

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
      decoration: const InputDecoration(
        hintText: 'Choose Category',
        border: InputBorder.none,
      ),
      items: options.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(
            option,
            style: TextStyle(color: AppColors.instance.dark25),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
