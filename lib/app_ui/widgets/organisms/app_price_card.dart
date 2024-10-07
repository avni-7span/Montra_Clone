import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montra_clone/app_ui/theme/utils/extensions.dart';
import 'package:montra_clone/app_ui/widgets/atoms/border_radius.dart';
import 'package:montra_clone/app_ui/widgets/atoms/text.dart';

class AppPriceCard extends StatelessWidget {
  const AppPriceCard({
    super.key,
    required this.color,
    required this.label,
    required this.price,
    required this.iconPath,
  });

  final Color color;
  final String label;
  final String price;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5),
      height: 80,
      width: 164,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(AppBorderRadius.medium28),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 48,
            height: 48,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(
                text: label,
                level: AppTextLevel.regular14,
                color: context.colorScheme.light100,
              ),
              AppText(
                text: price,
                level: AppTextLevel.title24,
                color: context.colorScheme.light100,
              ),
            ],
          )
        ],
      ),
    );
  }
}
