import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/core/widgets/decorated_line.dart';

class LogoutAlertMessage extends StatelessWidget {
  const LogoutAlertMessage({
    super.key,
    required this.onDecoratedLineTap,
    required this.onYesTap,
    required this.onNoTap,
  });

  final VoidCallback onDecoratedLineTap;
  final VoidCallback onYesTap;
  final VoidCallback onNoTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 4),
        DecoratedLine(
          onTap: onDecoratedLineTap,
        ),
        const SizedBox(height: 20),
        const Text(
          'Logout?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Are you sure you want to logout?',
          style: TextStyle(
            color: AppColors.instance.dark25,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _BottomSheetButton(
              isLogoutButton: false,
              onTap: onNoTap,
            ),
            _BottomSheetButton(
              isLogoutButton: true,
              onTap: onYesTap,
            )
          ],
        )
      ],
    );
  }
}

class _BottomSheetButton extends StatelessWidget {
  const _BottomSheetButton({
    super.key,
    required this.isLogoutButton,
    required this.onTap,
  });

  final bool isLogoutButton;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        width: 164,
        decoration: BoxDecoration(
          color: isLogoutButton
              ? AppColors.instance.primary
              : AppColors.instance.violet20,
          borderRadius: BorderRadius.circular(
            16,
          ),
        ),
        child: Center(
          child: Text(
            isLogoutButton ? 'Yes' : 'No',
            style: TextStyle(
              color: isLogoutButton
                  ? AppColors.instance.light100
                  : AppColors.instance.primary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
