import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app_ui/widgets/atoms/border_radius.dart';
import 'package:montra_clone/app_ui/widgets/atoms/padding.dart';

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
      margin: const EdgeInsets.only(right: Insets.small12),
      decoration: BoxDecoration(
        color: isCurrentIndex
            ? AppColors.instance.primary
            : AppColors.instance.violet20,
        borderRadius: BorderRadius.circular(
          AppBorderRadius.small8,
        ),
      ),
    );
  }
}
