import 'package:flutter/material.dart';
import 'package:montra_clone/app_ui/theme/utils/extensions.dart';
import 'package:montra_clone/app_ui/widgets/atoms/border_radius.dart';
import 'package:montra_clone/app_ui/widgets/atoms/loading_indicator.dart';
import 'package:montra_clone/app_ui/widgets/atoms/padding.dart';
import 'package:montra_clone/app_ui/widgets/atoms/text.dart';

/// This class is used for implementing the Buttons throughout the App
/// This button contains most of the parameters weather a user wants to
/// show a button with icons inside it or just text type.
///
/// To change the look of Button, use the [ButtonType] argument in the
/// constructor.
class AppButton extends StatelessWidget {
  const AppButton({
    required this.onPressed,
    this.text,
    this.isLoading = false,
    this.isRounded = true,
    this.isExpanded = false,
    this.buttonType = ButtonType.filled,
    this.buttonStyle,
    this.textStyle,
    this.padding,
    this.contentPadding,
    this.icon,
    this.iconPadding,
    this.textColor,
    super.key,
    this.textWidget,
    this.backgroundColor,
  }) : assert(
          text != null || textWidget != null,
          'Please provider either String Text or Text Widget',
        );

  final String? text;
  final bool isLoading;
  final bool isRounded;
  final bool isExpanded;
  final ButtonType buttonType;
  final VoidCallback? onPressed;
  final ButtonStyle? buttonStyle;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final EdgeInsets? contentPadding;
  final Widget? icon;
  final Widget? textWidget;
  final EdgeInsets? iconPadding;
  final Color? textColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      key: Key(text ?? 'Text'),
      enabled: isLoading,
      button: true,
      label: text,
      child: Container(
        width: isExpanded ? Insets.infinity : null,
        height: 56,
        padding: padding ?? EdgeInsets.zero,
        child: _ButtonType(
          text: text,
          buttonType: buttonType,
          icon: icon,
          isLoading: isLoading,
          isRounded: isRounded,
          onPressed: onPressed,
          buttonStyle: buttonStyle,
          iconPadding: iconPadding,
          contentPadding: contentPadding,
          textStyle: textStyle,
          textColor: textColor,
          textWidget: textWidget,
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }
}

class _ButtonType extends StatelessWidget {
  const _ButtonType({
    required this.buttonType,
    required this.icon,
    required this.isRounded,
    this.isLoading = false,
    this.text,
    this.onPressed,
    this.buttonStyle,
    this.iconPadding,
    this.contentPadding,
    this.textStyle,
    this.textColor,
    this.textWidget,
    this.backgroundColor,
  });

  final bool isRounded;
  final bool isLoading;
  final VoidCallback? onPressed;
  final ButtonStyle? buttonStyle;
  final EdgeInsets? iconPadding;
  final EdgeInsets? contentPadding;
  final String? text;
  final TextStyle? textStyle;
  final ButtonType buttonType;
  final Widget? icon;
  final Widget? textWidget;
  final Color? textColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final finalIcon = SizedBox(child: icon);
    final primaryColor = context.colorScheme.primary;
    final btnTextColor = textColor ?? context.colorScheme.light100;
    final defaultButtonStyle = ButtonStyle(
      splashFactory: InkSparkle.splashFactory,
      backgroundColor: WidgetStateProperty.all(backgroundColor ?? primaryColor),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: isRounded
              ? BorderRadius.circular(AppBorderRadius.medium16)
              : BorderRadius.circular(AppBorderRadius.xsmall4),
        ),
      ),
      minimumSize: WidgetStateProperty.all(const Size(100, 50)),
    );

    return switch (buttonType) {
      ButtonType.filled when icon != null => FilledButton.icon(
          onPressed: isLoading ? () {} : onPressed,
          style:
              buttonStyle?.copyWith(splashFactory: InkSparkle.splashFactory) ??
                  defaultButtonStyle,
          icon: isLoading ? const SizedBox.shrink() : finalIcon,
          label: _ButtonContent(
            isLoading: isLoading,
            text: text,
            textWidget: textWidget,
            defaultTextColor: btnTextColor,
          ),
        ),
      ButtonType.filled => FilledButton(
          onPressed: isLoading ? () {} : onPressed,
          style:
              buttonStyle?.copyWith(splashFactory: InkSparkle.splashFactory) ??
                  defaultButtonStyle,
          child: _ButtonContent(
            textWidget: textWidget,
            isLoading: isLoading,
            text: text,
            defaultTextColor: btnTextColor,
          ),
        ),
      ButtonType.outlined when icon != null => OutlinedButton.icon(
          onPressed: isLoading ? () {} : onPressed,
          style: buttonStyle?.copyWith(
            splashFactory: InkSparkle.splashFactory,
          ),
          icon: finalIcon,
          label: _ButtonContent(
            isLoading: isLoading,
            text: text,
            textWidget: textWidget,
            defaultTextColor: btnTextColor,
          ),
        ),
      ButtonType.outlined => OutlinedButton(
          onPressed: isLoading ? () {} : onPressed,
          style: buttonStyle != null
              ? buttonStyle?.copyWith(
                  splashFactory: InkSparkle.splashFactory,
                  backgroundColor: WidgetStatePropertyAll(
                    backgroundColor ?? context.colorScheme.light100,
                  ),
                  side: WidgetStateProperty.all(
                    BorderSide(color: context.colorScheme.dark25),
                  ),
                )
              : defaultButtonStyle.copyWith(
                  splashFactory: InkSparkle.splashFactory,
                  backgroundColor: WidgetStatePropertyAll(
                    backgroundColor ?? context.colorScheme.green100,
                  ),
                  side: WidgetStateProperty.all(
                    BorderSide(color: context.colorScheme.light20),
                  ),
                ),
          child: _ButtonContent(
            isLoading: isLoading,
            text: text,
            textWidget: textWidget,
            defaultTextColor: btnTextColor,
          ),
        ),
      ButtonType.text when icon != null => TextButton.icon(
          onPressed: isLoading ? () {} : onPressed,
          style: buttonStyle?.copyWith(splashFactory: InkSparkle.splashFactory),
          icon: finalIcon,
          label: _ButtonContent(
            isLoading: isLoading,
            text: text,
            textWidget: textWidget,
            defaultTextColor: btnTextColor,
          ),
        ),
      ButtonType.text => TextButton(
          onPressed: isLoading ? () {} : onPressed,
          style: buttonStyle?.copyWith(splashFactory: InkSparkle.splashFactory),
          child: _ButtonContent(
            isLoading: isLoading,
            text: text,
            defaultTextColor: btnTextColor,
            textWidget: textWidget,
          ),
        ),
    };
  }
}

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.isLoading,
    required this.defaultTextColor,
    this.text,
    this.textWidget,
  });

  final bool isLoading;
  final Color defaultTextColor;
  final String? text;
  final Widget? textWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: isLoading
          ? const Center(child: AppLoadingIndicator())
          : Center(
              child: textWidget ??
                  AppText.title18(
                    text: text,
                    color: defaultTextColor,
                  ),
            ),
    );
  }
}

enum ButtonType {
  filled,
  outlined,
  text,
}
