import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

@RoutePage()
class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Transaction Screen, Under Construction !',
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
