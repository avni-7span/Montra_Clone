import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/image_paths.dart';

class AnalysisCard extends StatelessWidget {
  const AnalysisCard({
    super.key,
    required this.isExpenseAnalysis,
    required this.highestAmount,
    required this.category,
  });

  final bool isExpenseAnalysis;
  final String highestAmount;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 231,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: AppColors.instance.light100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isExpenseAnalysis
                ? 'Your biggest spent is '
                : 'Your biggest income is from',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          CategoryContainer(
            category: category,
            isExpenseAnalysis: isExpenseAnalysis,
          ),
          Text(
            highestAmount,
            style: const TextStyle(fontSize: 36),
          ),
        ],
      ),
    );
  }
}

class CategoryContainer extends StatelessWidget {
  const CategoryContainer({
    super.key,
    required this.category,
    required this.isExpenseAnalysis,
  });

  final String category;
  final bool isExpenseAnalysis;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.instance.dark25),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
              isExpenseAnalysis ? subscriptionIconPath : salaryIconPath),
          const SizedBox(width: 8),
          Text(
            category,
            style: const TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }
}
