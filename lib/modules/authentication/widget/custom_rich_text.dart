import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        softWrap: true,
        text: TextSpan(
          text: title,
          style: TextStyle(
            color: AppColors.instance.dark25,
            fontSize: 20,
          ),
          children: <TextSpan>[
            TextSpan(
              recognizer: TapGestureRecognizer()..onTap = onTap,
              text: subtitle,
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: AppColors.instance.primary,
                  fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
