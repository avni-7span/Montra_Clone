import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/image_paths.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    navigateToAppropriateRoute();
  }

  Future<void> navigateToAppropriateRoute() async {
    await Future.delayed(const Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    bool isOpenedFirstTime = prefs.getBool('isOpenedFirstTime') ?? true;
    if (isOpenedFirstTime) {
      prefs.setBool('isOpenedFirstTime', false);
      if (mounted) {
        context.router.replace(const OnboardingRoute());
      }
    } else {
      if (mounted) {
        context.router.replace(const BottomNavigationBarRoute());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.instance.violet80,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * (0.3),
            ),
            Image.asset(
              appIcon,
              height: 150,
              width: 150,
            ),
            const Spacer(),
            const Text(
              'Montra',
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
