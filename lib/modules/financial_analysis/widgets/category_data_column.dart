import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/core/widgets/category_chip.dart';

class CategoryDataColumn extends StatelessWidget {
  const CategoryDataColumn({
    super.key,
    required this.isExpense,
    required this.categoryValueMap,
    required this.totalAmount,
  });

  final bool isExpense;
  final Map<String, double> categoryValueMap;
  final double totalAmount;

  double getAmount(String categoryName) {
    return double.parse(
      ((categoryValueMap[categoryName]!) * totalAmount).toStringAsFixed(2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isExpense) ...[
          CategoryProgressBar(
            progressValue: categoryValueMap['Subscription']!,
            color: AppColors.instance.primary,
            label: 'Subscription',
            isExpense: isExpense,
            amount: getAmount('Subscription'),
          ),
          const SizedBox(height: 15),
          CategoryProgressBar(
            progressValue: categoryValueMap['Shopping']!,
            color: AppColors.instance.yellow100,
            label: 'Shopping',
            isExpense: isExpense,
            amount: getAmount('Shopping'),
          ),
          const SizedBox(height: 15),
          CategoryProgressBar(
            progressValue: categoryValueMap['Transportation']!,
            color: AppColors.instance.blue100,
            label: 'Transportation',
            isExpense: isExpense,
            amount: getAmount('Transportation'),
          ),
          const SizedBox(height: 15),
          CategoryProgressBar(
            progressValue: categoryValueMap['Food']!,
            color: AppColors.instance.red100,
            label: 'Food',
            isExpense: isExpense,
            amount: getAmount('Food'),
          ),
        ] else ...[
          CategoryProgressBar(
            progressValue: categoryValueMap['Salary']!,
            color: AppColors.instance.green100,
            label: 'Salary',
            isExpense: isExpense,
            amount: getAmount('Salary'),
          ),
          const SizedBox(height: 15),
          CategoryProgressBar(
            progressValue: categoryValueMap['Rental Income']!,
            color: AppColors.instance.yellow100,
            label: 'Rental Income',
            isExpense: isExpense,
            amount: getAmount('Rental Income'),
          ),
          const SizedBox(height: 15),
          CategoryProgressBar(
            progressValue: categoryValueMap['Interest']!,
            color: AppColors.instance.blue100,
            label: 'Interest',
            isExpense: isExpense,
            amount: getAmount('Interest'),
          )
        ]
      ],
    );
  }
}

class CategoryProgressBar extends StatelessWidget {
  const CategoryProgressBar({
    super.key,
    required this.progressValue,
    required this.label,
    required this.color,
    required this.isExpense,
    required this.amount,
  });

  final double progressValue;
  final Color color;
  final String label;
  final bool isExpense;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CategoryChip(
              color: color,
              label: label,
            ),
            Text(
              isExpense ? '-\u{20B9}$amount' : '\u{20B9}$amount',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: isExpense
                    ? AppColors.instance.red100
                    : AppColors.instance.green100,
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          value: progressValue,
          color: color,
          backgroundColor: AppColors.instance.light20,
          minHeight: 10,
          borderRadius: BorderRadius.circular(8),
        )
      ],
    );
  }
}
