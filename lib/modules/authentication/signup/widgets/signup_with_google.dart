import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class SignUpWithGoogle extends StatelessWidget {
  const SignUpWithGoogle(
      {super.key, required this.onPressed, required this.buttonLabel});

  final VoidCallback onPressed;
  final Widget buttonLabel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 56,
        width: 343,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.instance.dark25),
        ),
        child: buttonLabel,
      ),
    );
  }
}

class GoogleButtonLabel extends StatelessWidget {
  const GoogleButtonLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 30,
          width: 30,
          child: Image.asset('assets/icons/google.png'),
        ),
        const Text(
          'Sign Up with Google',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ],
    );
  }
}
