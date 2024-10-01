import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class PageSlideContainer extends StatelessWidget {
  const PageSlideContainer({
    super.key,
    required this.isCurrentIndex,
  });

  final bool isCurrentIndex;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      height: 5,
      width: size.width * (0.33),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isCurrentIndex
            ? AppColors.instance.light100
            : AppColors.instance.light100.withOpacity(0.5),
      ),
    );
  }
}
