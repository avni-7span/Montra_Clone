import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app_ui/widgets/atoms/atoms.dart';

class PageViewCard extends StatelessWidget {
  const PageViewCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.imagePath,
  });

  final String title;
  final String subTitle;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 312,
            width: 312,
          ),
          VSpace.small12(),
          AppText(
            level: AppTextLevel.XL,
            text: title,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          VSpace.small12(),
          AppText(
            level: AppTextLevel.L,
            textAlign: TextAlign.center,
            text: subTitle,
            color: AppColors.instance.dark25,
            maxLines: 2,
          ),
          VSpace.small12(),
        ],
      ),
    );
  }
}
