import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

@RoutePage()
class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Budget Screen, Under Construction !',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.instance.primary,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
