import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/core/widgets/decorated_line.dart';

class AlertMessageContainer extends StatelessWidget {
  const AlertMessageContainer({
    super.key,
    required this.onDecoratedLineTap,
    required this.onYesTap,
    required this.onNoTap,
    required this.title,
    required this.subTitle,
  });

  final VoidCallback onDecoratedLineTap;
  final VoidCallback onYesTap;
  final VoidCallback onNoTap;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 4),
          DecoratedLine(
            onTap: onDecoratedLineTap,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            subTitle,
            textAlign: TextAlign.center,
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
                isContinueButton: false,
                onTap: onNoTap,
              ),
              _BottomSheetButton(
                isContinueButton: true,
                onTap: onYesTap,
              )
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

class _BottomSheetButton extends StatelessWidget {
  const _BottomSheetButton({
    super.key,
    required this.isContinueButton,
    required this.onTap,
  });

  final bool isContinueButton;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        width: 164,
        decoration: BoxDecoration(
          color: isContinueButton
              ? AppColors.instance.primary
              : AppColors.instance.violet20,
          borderRadius: BorderRadius.circular(
            16,
          ),
        ),
        child: Center(
          child: Text(
            isContinueButton ? 'Yes' : 'No',
            style: TextStyle(
              color: isContinueButton
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
