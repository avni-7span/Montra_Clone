import 'package:flutter/material.dart';
import 'package:montra_clone/app_ui/theme/utils/extensions.dart';
import 'package:montra_clone/app_ui/widgets/atoms/spacing.dart';
import 'package:montra_clone/app_ui/widgets/atoms/text.dart';

class ColorContainer extends StatelessWidget {
  const ColorContainer({
    super.key,
    required this.color,
    required this.colorName,
  });

  final Color color;
  final String colorName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 30,
          width: 30,
          color: color,
        ),
        Text(
          colorName,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

Map<String, Color> getColorMap(BuildContext context) {
  return {
    "primary": context.colorScheme.primary,
    "violet80": context.colorScheme.violet80,
    "violet60": context.colorScheme.violet60,
    "violet40": context.colorScheme.violet40,
    "violet20": context.colorScheme.violet20,
    "yellow100": context.colorScheme.yellow100,
    "yellow80": context.colorScheme.yellow80,
    "yellow60": context.colorScheme.yellow60,
    "yellow40": context.colorScheme.yellow40,
    "yellow20": context.colorScheme.yellow20,
    "blue100": context.colorScheme.blue100,
    "blue80": context.colorScheme.blue80,
    "blue60": context.colorScheme.blue60,
    "blue40": context.colorScheme.blue40,
    "blue20": context.colorScheme.blue20,
    "red100": context.colorScheme.red100,
    "red80": context.colorScheme.red80,
    "red60": context.colorScheme.red60,
    "red40": context.colorScheme.red40,
    "red20": context.colorScheme.red20,
    "green100": context.colorScheme.green100,
    "green80": context.colorScheme.green80,
    "green60": context.colorScheme.green60,
    "green40": context.colorScheme.green40,
    "green20": context.colorScheme.green20,
    "dark100": context.colorScheme.dark100,
    "dark75": context.colorScheme.dark75,
    "dark50": context.colorScheme.dark50,
    "dark25": context.colorScheme.dark25,
    "light100": context.colorScheme.light100,
    "light80": context.colorScheme.light80,
    "light60": context.colorScheme.light60,
    "light40": context.colorScheme.light40,
    "light20": context.colorScheme.light20,
  };
}

class GoogleButtonLabel extends StatelessWidget {
  const GoogleButtonLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/icons/google.png',
          height: 30,
          width: 30,
        ),
        HSpace.small12(),
        AppText.title18(
          text: 'Sign Up with Google',
          color: context.colorScheme.primary,
        ),
      ],
    );
  }
}
