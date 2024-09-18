import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';

@RoutePage()
class VerificationInfoScreen extends StatefulWidget {
  const VerificationInfoScreen({super.key});

  @override
  State<VerificationInfoScreen> createState() => _VerificationInfoScreenState();
}

class _VerificationInfoScreenState extends State<VerificationInfoScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  Future<void> navigate() async {
    await Future.delayed(const Duration(seconds: 5));
    if (mounted) {
      context.router.replace(const LoginRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.instance.light100,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/image_4.png',
                height: 320,
                width: 320,
              ),
              const Text(
                'Verification email is on the way',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'We have sent you an email for verification. Please check the inbox to verify',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 20, color: AppColors.instance.dark25),
              )
            ],
          ),
        ),
      ),
    );
  }
}
