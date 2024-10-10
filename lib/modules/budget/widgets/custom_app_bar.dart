import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.onBackTap});

  final VoidCallback onBackTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 64,
        color: AppColors.instance.primary,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: onBackTap,
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.instance.light100,
                ),
              ),
            ),
            Center(
              child: Text(
                'Create Budget',
                style: TextStyle(
                  color: AppColors.instance.light100,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
