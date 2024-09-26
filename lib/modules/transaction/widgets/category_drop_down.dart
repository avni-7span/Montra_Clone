import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class CategoryDropDown extends StatelessWidget {
  const CategoryDropDown({
    super.key,
    required this.labelText,
    required this.options,
    this.selectedValue,
    required this.onChanged,
  });

  final String labelText;
  final List<String> options;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration:
          InputDecoration(hintText: labelText, border: InputBorder.none),
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
