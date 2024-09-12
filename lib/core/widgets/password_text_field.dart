import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.hintText,
    required this.errorWidget,
    this.isVisible = true,
    required this.onChanged,
  });

  final String hintText;
  final Widget? errorWidget;
  final bool isVisible;
  final Function(String) onChanged;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool shouldShow = false;

  @override
  void initState() {
    super.initState();
    shouldShow = widget.isVisible;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: shouldShow,
      onChanged: (value) => widget.onChanged(value),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: AppColors.instance.dark25),
        error: widget.errorWidget,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              shouldShow = !shouldShow;
            });
          },
          icon: shouldShow
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off),
        ),
      ),
    );
  }
}
