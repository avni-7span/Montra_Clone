import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montra_clone/app/app_colors.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({
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
    final size = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        right: 10,
        left: 10,
      ),
      padding: const EdgeInsets.all(2),
      height: 80,
      width: size.width / 2.4,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
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
              Text(
                label,
                style: TextStyle(
                  color: AppColors.instance.light100,
                  fontSize: 14,
                ),
              ),
              Text(
                price,
                style: TextStyle(
                  color: AppColors.instance.light100,
                  fontSize: 22,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
