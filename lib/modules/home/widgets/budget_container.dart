import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/modules/home/widgets/price_card.dart';

class BudgetContainer extends StatelessWidget {
  const BudgetContainer({
    super.key,
    required this.totalBudget,
    required this.income,
    required this.expense,
  });

  final double totalBudget;
  final double income;
  final double expense;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * (0.35),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.instance.yellow20,
            AppColors.instance.yellow20.withOpacity(0.5),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      maxRadius: 30,
                      child: Icon(
                        Icons.image,
                        size: 30,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.notifications,
                    size: 40,
                    color: AppColors.instance.primary,
                  )
                ],
              ),
              Text(
                'Total Balance',
                style: TextStyle(
                  color: AppColors.instance.dark25,
                  fontSize: 15,
                  // fontFamily:
                ),
              ),
              Text(
                totalBudget > 0
                    ? '\$${totalBudget.toString()}'
                    : '- \$${totalBudget.abs().toString()}',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PriceCard(
                    icon: Icons.arrow_downward,
                    color: AppColors.instance.green100,
                    label: 'Income',
                    price: '\$${income.toString()}',
                  ),
                  PriceCard(
                    icon: Icons.arrow_upward,
                    color: AppColors.instance.red100,
                    label: 'Expenses',
                    price: '\$${expense.toString()}',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
