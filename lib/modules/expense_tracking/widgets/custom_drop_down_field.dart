import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class CustomDropDownField extends StatelessWidget {
  const CustomDropDownField({
    super.key,
    required this.labelText,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  });

  final String labelText;
  final List<String> options;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
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
      ),
    );
  }
}
