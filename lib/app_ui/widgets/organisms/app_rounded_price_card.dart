import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montra_clone/app_ui/widgets/atoms/border_radius.dart';

class AppRoundedPriceCard extends StatelessWidget {
  const AppRoundedPriceCard({
    super.key,
    required this.backgroundColor,
    required this.iconPath,
    required this.onTap,
  });

  final Color backgroundColor;
  final String iconPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        height: 91,
        width: 107,
        decoration: boxDecoration(
          color: backgroundColor,
          radius: AppBorderRadius.medium16,
        ),
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            height: 56,
            width: 56,
          ),
        ),
      ),
    );
  }
}

BoxDecoration boxDecoration({required Color color, required double radius}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius),
  );
}
