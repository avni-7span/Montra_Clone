import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

BoxDecoration boxDecoration({required Color color, required double radius}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius),
  );
}

class TransactionButton extends StatelessWidget {
  const TransactionButton({
    super.key,
    required this.primaryColor,
    required this.secondaryColor,
    required this.iconPath,
    required this.onTap,
  });

  final Color primaryColor;
  final Color secondaryColor;
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
          color: primaryColor,
          radius: 20,
        ),
        child: Container(
          height: 30,
          width: 30,
          decoration: boxDecoration(
            color: secondaryColor,
            radius: 50,
          ),
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
