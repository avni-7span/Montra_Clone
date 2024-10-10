import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

final textStyle = TextStyle(color: AppColors.instance.light80, fontSize: 64);

class AmountTextField extends StatelessWidget {
  const AmountTextField({
    super.key,
    required this.onChanged,
    required this.errorWidget,
    required this.initialValue,
  });

  final Function(String) onChanged;
  final Widget? errorWidget;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: TextFormField(
        initialValue: initialValue,
        style: textStyle,
        onChanged: (value) => onChanged(value),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '0',
          prefixIcon: Text('\u{20B9}', style: textStyle),
          hintStyle: textStyle,
          error: errorWidget,
        ),
      ),
    );
  }
}
