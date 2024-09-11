import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/core/routes/router.gr.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigation();
  }

  Future<void> navigation() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      context.router.replace(const OnboardingRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.instance.violet100,
      body: const Center(
        child: Text(
          'Montra',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }
}
