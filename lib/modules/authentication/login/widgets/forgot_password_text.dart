import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushRoute(const ForgotPasswordRoute()),
      child: Text(
        'Forgot Password ?',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.instance.primary,
          fontSize: 18,
        ),
      ),
    );
  }
}
