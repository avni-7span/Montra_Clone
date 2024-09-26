import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';
import 'package:montra_clone/modules/expense_tracking/widgets/bottom_sheet_container.dart';

class AddTransactionButton extends StatefulWidget {
  const AddTransactionButton({super.key});

  @override
  State<AddTransactionButton> createState() => _AddTransactionButtonState();
}

class _AddTransactionButtonState extends State<AddTransactionButton> {
  Future<void> _showBottomSheet({required BuildContext screenContext}) {
    return showModalBottomSheet(
      backgroundColor: AppColors.instance.light100,
      isScrollControlled: true,
      context: screenContext,
      builder: (context) {
        return BottomSheetContainer(
          onBackTap: () {
            Navigator.pop(screenContext);
          },
          onIncomeTap: () async {
            Navigator.pop(screenContext);
            await context.pushRoute(
              ExpenseTrackerRoute(
                isExpense: false,
              ),
            );
          },
          onExpenseTap: () async {
            Navigator.pop(screenContext);
            await context.pushRoute(
              ExpenseTrackerRoute(
                isExpense: true,
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBottomSheet(screenContext: context),
      child: Container(
        height: 60,
        width: 60,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.instance.primary,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          Icons.add,
          size: 40,
          color: AppColors.instance.light100,
        ),
      ),
    );
  }
}
