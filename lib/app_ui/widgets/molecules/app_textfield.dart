import 'package:flutter/material.dart';
import 'package:montra_clone/app_ui/theme/utils/extensions.dart';
import 'package:montra_clone/app_ui/widgets/atoms/padding.dart';
import 'package:montra_clone/app_ui/widgets/atoms/spacing.dart';
import 'package:montra_clone/app_ui/widgets/atoms/text.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    required this.label,
    super.key,
    this.textInputAction = TextInputAction.next,
    this.isObscureText = false,
    this.showLabel = true,
    this.hintText,
    this.keyboardType,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.focusNode,
    this.minLines,
    this.errorText,
    this.backgroundColor,
    this.contentPadding,
    this.autofillHints,
    this.hintTextBelowTextField,
  }) : isPasswordField = false;

  const AppTextField.password({
    required this.label,
    super.key,
    this.textInputAction = TextInputAction.next,
    this.isObscureText = true,
    this.showLabel = true,
    this.hintText,
    this.keyboardType,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.errorText,
    this.backgroundColor,
    this.minLines,
    this.focusNode,
    this.autofillHints,
    this.hintTextBelowTextField,
    this.contentPadding,
  }) : isPasswordField = true;

  final String label;
  final String? initialValue;
  final String? hintText;
  final String? errorText;
  final String? hintTextBelowTextField;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String text)? onChanged;
  final Color? backgroundColor;
  final bool isObscureText;
  final bool isPasswordField;
  final bool showLabel;
  final List<String>? autofillHints;
  final FocusNode? focusNode;
  final int? minLines;
  final EdgeInsetsGeometry? contentPadding;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool isObscureText = false;

  @override
  void initState() {
    super.initState();
    isObscureText = widget.isObscureText;
  }

  void toggleObscureText() {
    setState(() {
      isObscureText = !isObscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel) ...[
          AppText.regular16(text: widget.label),
          VSpace.xsmall8(),
        ],
        TextFormField(
          initialValue: widget.initialValue,
          cursorColor: context.colorScheme.dark100,
          style: context.textTheme?.regular16
              .copyWith(color: context.colorScheme.dark100),
          textInputAction: widget.textInputAction,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          obscureText: isObscureText,
          onChanged: widget.onChanged,
          autofillHints: widget.autofillHints,
          focusNode: widget.focusNode,
          decoration: InputDecoration(
            filled: true,
            fillColor: widget.backgroundColor ?? context.colorScheme.light100,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: context.colorScheme.dark25),
            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(
                  horizontal: Insets.medium20,
                  vertical: Insets.medium18,
                ),
            errorMaxLines: 2,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Insets.medium16),
              borderSide: BorderSide(color: context.colorScheme.light20),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Insets.medium16),
              borderSide: BorderSide.none,
            ),
            errorText: widget.errorText,
            suffixIcon: widget.isPasswordField
                ? IconButton(
                    splashColor: context.colorScheme.violet40,
                    onPressed: toggleObscureText,
                    icon: Icon(
                      isObscureText ? Icons.visibility_off : Icons.visibility,
                      color: context.colorScheme.light20,
                    ),
                  )
                : null,
          ),
          minLines: widget.minLines,
          maxLines: widget.minLines ?? 0 + 1,
        ),
        if (widget.hintTextBelowTextField != null) ...[
          VSpace.xsmall8(),
          AppText.tiny12(text: widget.hintTextBelowTextField),
        ],
      ],
    );
  }
}
