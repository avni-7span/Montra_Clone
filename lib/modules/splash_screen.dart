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

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    setAnimation();
    navigateToAppropriateRoute();
  }

  void setAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1.5,
    ).animate(animationController);
    animationController.forward();
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
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) => Transform.scale(
            scale: animation.value,
            child: Image.asset(
              appIcon,
              height: 100,
            ),
          ),
        ),
      ),
    );
  }
}
