import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/image_paths.dart';

class ReportContainer extends StatelessWidget {
  const ReportContainer({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        margin: const EdgeInsets.only(top: 8, bottom: 8),
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: AppColors.instance.violet20,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'See your financial report',
              style: TextStyle(color: AppColors.instance.primary, fontSize: 16),
            ),
            SvgPicture.asset(
              routeIconPath,
              height: 20,
              width: 20,
            )
          ],
        ),
      ),
    );
  }
}
