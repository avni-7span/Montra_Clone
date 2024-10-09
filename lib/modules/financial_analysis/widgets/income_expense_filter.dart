import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/modules/financial_analysis/bloc/financial_analysis_bloc.dart';

class IncomeExpenseFilter extends StatelessWidget {
  const IncomeExpenseFilter({
    super.key,
    required this.filterType,
    required this.onIncomeTap,
    required this.onExpenseTap,
  });

  final AnalysisFilter filterType;
  final VoidCallback onIncomeTap;
  final VoidCallback onExpenseTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      height: 56,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.instance.light20.withOpacity(0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SubButton(
            buttonLabel: 'Expense',
            buttonColor: filterType == AnalysisFilter.expense
                ? AppColors.instance.primary
                : Colors.transparent,
            textColor: filterType == AnalysisFilter.expense
                ? AppColors.instance.light100
                : AppColors.instance.dark100,
            onButtonTap: onExpenseTap,
          ),
          SubButton(
            buttonLabel: 'Income',
            buttonColor: filterType == AnalysisFilter.income
                ? AppColors.instance.primary
                : Colors.transparent,
            textColor: filterType == AnalysisFilter.income
                ? AppColors.instance.light100
                : AppColors.instance.dark100,
            onButtonTap: onIncomeTap,
          ),
        ],
      ),
    );
  }
}

class SubButton extends StatelessWidget {
  const SubButton({
    super.key,
    required this.buttonLabel,
    required this.buttonColor,
    required this.onButtonTap,
    required this.textColor,
  });

  final String buttonLabel;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onButtonTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 56,
        width: size.width / 2.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: buttonColor,
        ),
        child: Center(
          child: Text(
            buttonLabel,
            style: TextStyle(
              fontSize: 20,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
