import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({
    super.key,
    required this.color,
    required this.label,
    required this.price,
    required this.icon,
  });

  final Color color;
  final String label;
  final String price;
  final IconData icon;

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
          Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            color: AppColors.instance.light100,
            size: 30,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: AppColors.instance.light100,
                  fontSize: 15,
                ),
              ),
              Text(
                price,
                style: TextStyle(
                  color: AppColors.instance.light100,
                  fontSize: 23,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
