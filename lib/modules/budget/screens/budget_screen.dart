import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

@RoutePage()
class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      extendBody: true,
      body: Container(
        height: size.height * (0.25),
        width: double.infinity,
        color: AppColors.instance.primary,
      ),
    );
  }
}
