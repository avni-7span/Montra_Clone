import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class PageSlideIndicator extends StatelessWidget {
  const PageSlideIndicator({
    super.key,
    required this.isCurrentIndex,
  });

  final bool isCurrentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isCurrentIndex ? 15 : 10,
      width: isCurrentIndex ? 15 : 10,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: isCurrentIndex
              ? AppColors.instance.primary
              : AppColors.instance.violet20,
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
