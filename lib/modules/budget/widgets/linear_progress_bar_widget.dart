import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class LinearProgressBarWidget extends StatelessWidget {
  const LinearProgressBarWidget(
      {super.key,
      required this.color,
      required this.progressValue,
      this.minHeight});

  final Color color;
  final double progressValue;
  final double? minHeight;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: progressValue,
      color: color,
      backgroundColor: AppColors.instance.light20,
      minHeight: minHeight ?? 12,
      borderRadius: BorderRadius.circular(8),
    );
  }
}
