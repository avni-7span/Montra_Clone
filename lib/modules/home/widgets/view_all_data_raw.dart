import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class ViewAllDataRaw extends StatelessWidget {
  const ViewAllDataRaw({
    super.key,
    required this.onViewAppTap,
  });

  final VoidCallback onViewAppTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Recent Transactions',
            style: TextStyle(
              color: AppColors.instance.dark100,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: AppColors.instance.violet20,
              borderRadius: const BorderRadius.all(
                Radius.circular(18),
              ),
            ),
            child: GestureDetector(
              onTap: onViewAppTap,
              child: Center(
                child: Text(
                  'See All',
                  style: TextStyle(
                    color: AppColors.instance.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
