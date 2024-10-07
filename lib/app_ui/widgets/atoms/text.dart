// ignore_for_file: constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:montra_clone/app_ui/theme/theme.dart';

enum AppTextLevel {
  titleX64,
  title32,
  title24,
  title18,
  regular16,
  regular14,
  small13,
  tiny12,
}

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    this.text,
    this.color,
    this.fontSize,
    this.maxLines,
    this.level = AppTextLevel.regular14,
    this.isUnderLine,
    this.style,
    this.textAlign,
  });
  const AppText.titleX({
    super.key,
    this.text,
    this.color,
    this.fontSize,
    this.maxLines,
    this.isUnderLine,
    this.style,
    this.textAlign,
  }) : level = AppTextLevel.titleX64;

  const AppText.title32({
    super.key,
    this.text,
    this.color,
    this.fontSize,
    this.maxLines,
    this.isUnderLine,
    this.style,
    this.textAlign,
  }) : level = AppTextLevel.title32;

  const AppText.title24({
    super.key,
    this.text,
    this.color,
    this.fontSize,
    this.maxLines,
    this.isUnderLine,
    this.style,
    this.textAlign,
  }) : level = AppTextLevel.title24;

  const AppText.title18({
    super.key,
    this.text,
    this.color,
    this.fontSize,
    this.maxLines,
    this.isUnderLine,
    this.style,
    this.textAlign,
  }) : level = AppTextLevel.title18;

  const AppText.regular16({
    super.key,
    this.text,
    this.color,
    this.fontSize,
    this.maxLines,
    this.isUnderLine,
    this.style,
    this.textAlign,
  }) : level = AppTextLevel.regular16;

  const AppText.regular14({
    super.key,
    this.text,
    this.color,
    this.fontSize,
    this.maxLines,
    this.isUnderLine,
    this.style,
    this.textAlign,
  }) : level = AppTextLevel.regular14;

  const AppText.small13({
    super.key,
    this.text,
    this.color,
    this.fontSize,
    this.maxLines,
    this.isUnderLine,
    this.style,
    this.textAlign,
  }) : level = AppTextLevel.small13;

  // ignore: non_constant_identifier_names
  const AppText.tiny12({
    super.key,
    this.text,
    this.color,
    this.fontSize,
    this.maxLines,
    this.isUnderLine,
    this.style,
    this.textAlign,
  }) : level = AppTextLevel.tiny12;

  final String? text;
  final AppTextLevel level;
  final Color? color;
  final double? fontSize;
  final int? maxLines;
  final bool? isUnderLine;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.maybeOf(context);

    final style = () {
      switch (level) {
        case AppTextLevel.titleX64:
          return theme?.typography.titleX64;
        case AppTextLevel.title32:
          return theme?.typography.title32;
        case AppTextLevel.title24:
          return theme?.typography.title24;
        case AppTextLevel.title18:
          return theme?.typography.title18;
        case AppTextLevel.regular16:
          return theme?.typography.regular16;
        case AppTextLevel.regular14:
          return theme?.typography.regular14;
        case AppTextLevel.small13:
          return theme?.typography.small13;
        case AppTextLevel.tiny12:
          return theme?.typography.tiny12;
      }
    }();
    return Text(
      text ?? '',
      textAlign: textAlign,
      style: style
          ?.copyWith(
            color: color,
            fontSize: fontSize,
            decoration: isUnderLine ?? false ? TextDecoration.underline : null,
            decorationColor: color,
          )
          .merge(style),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
