import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/image_paths.dart';

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
        border: InputBorder.none,
        suffixIcon: SvgPicture.asset(arrowDown),
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
