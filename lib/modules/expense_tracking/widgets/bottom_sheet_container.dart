import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/image_paths.dart';
import 'package:montra_clone/core/widgets/decorated_line.dart';
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
        DecoratedLine(onTap: () {
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
                iconPath: incomeRoundedIcon,
                onTap: () {
                  onIncomeTap();
                },
              ),
              TransactionButton(
                primaryColor: AppColors.instance.red40,
                secondaryColor: AppColors.instance.red100,
                iconPath: expenseRoundedIcon,
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
