import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/modules/expense_tracking/widgets/trasaction_button.dart';

class BottomSheetContainer extends StatelessWidget {
  const BottomSheetContainer({
    super.key,
    required this.onBackTap,
    required this.onIncomeTap,
    required this.onExpenseTap,
  });

  final VoidCallback onBackTap;
  final VoidCallback onIncomeTap;
  final VoidCallback onExpenseTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _DecoratedLine(onTap: () {
          onBackTap();
        }),
        SizedBox(
          height: 186,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TransactionButton(
                primaryColor: AppColors.instance.green40,
                secondaryColor: AppColors.instance.green100,
                icon: Icons.arrow_downward,
                onTap: () {
                  onIncomeTap();
                },
              ),
              TransactionButton(
                primaryColor: AppColors.instance.red40,
                secondaryColor: AppColors.instance.red100,
                icon: Icons.arrow_upward,
                onTap: () {
                  onExpenseTap();
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _DecoratedLine extends StatelessWidget {
  const _DecoratedLine({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        height: 8,
        width: 60,
        color: AppColors.instance.violet40,
      ),
    );
  }
}
