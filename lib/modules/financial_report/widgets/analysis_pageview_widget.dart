import 'package:flutter/cupertino.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/image_paths.dart';
import 'package:montra_clone/modules/financial_report/widgets/analysis_card.dart';

class AnalysisPageViewWidget extends StatelessWidget {
  const AnalysisPageViewWidget({
    super.key,
    required this.isExpenseAnalysis,
    required this.totalAmount,
    required this.highestAmount,
    required this.category,
  });

  final bool isExpenseAnalysis;
  final String totalAmount;
  final String highestAmount;
  final String category;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      height: size.height,
      width: size.width,
      color: isExpenseAnalysis
          ? AppColors.instance.red80
          : AppColors.instance.green100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'This Month',
            style: TextStyle(
              color: AppColors.instance.light100.withOpacity(0.8),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Column(
            children: [
              Image.asset(
                isExpenseAnalysis ? expense : moneyBag,
                height: 100,
                width: 100,
              ),
              Text(
                isExpenseAnalysis ? 'You Spent' : 'You Earned',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.instance.light100,
                ),
              ),
              Text(
                totalAmount,
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: AppColors.instance.light100,
                ),
              ),
            ],
          ),
          AnalysisCard(
            isExpenseAnalysis: isExpenseAnalysis,
            category: category,
            highestAmount: highestAmount,
          )
        ],
      ),
    );
  }
}
