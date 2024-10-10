import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({
    super.key,
    required this.onChanged,
    required this.value,
    required this.label,
  });

  final double value;
  final Function(double value) onChanged;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      onChanged: onChanged,
      max: 100,
      divisions: 5,
      label: label,
      thumbColor: AppColors.instance.violet40,
      overlayColor: WidgetStatePropertyAll(
        AppColors.instance.violet80,
      ),
    );
  }
}
