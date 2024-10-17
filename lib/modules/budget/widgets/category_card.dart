import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/image_paths.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
  });

  final String category;

  @override
  Widget build(BuildContext context) {
    final (String, Color) dataRecord = getAssetData(category);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      // width: 160,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.instance.light80,
        border: Border.all(
          color: AppColors.instance.light20,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: dataRecord.$2,
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
            child: SvgPicture.asset(
              dataRecord.$1,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            category,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.instance.dark100,
            ),
          ),
        ],
      ),
    );
  }
}

(String, Color) getAssetData(String category) {
  switch (category) {
    case 'Shopping':
      return (shoppingIconPath, AppColors.instance.yellow20);
    case 'Subscription':
      return (subscriptionIconPath, AppColors.instance.violet20);
    case 'Transportation':
      return (carIconPath, AppColors.instance.blue20);
    default:
      return (foodIconPath, AppColors.instance.red20);
  }
}
