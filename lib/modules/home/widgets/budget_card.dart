import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/image_paths.dart';

class BudgetCard extends StatelessWidget {
  const BudgetCard({
    super.key,
    required this.category,
    required this.isExpense,
    required this.amount,
    required this.description,
    required this.createdAt,
    required this.onCardTap,
  });

  final String category;
  final bool isExpense;
  final String amount;
  final String description;
  final String createdAt;
  final VoidCallback onCardTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(8),
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.instance.light40,
          borderRadius: const BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: category == 'Food'
                    ? AppColors.instance.red20
                    : category == 'Shopping'
                        ? AppColors.instance.yellow20
                        : AppColors.instance.violet20,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Image.asset(
                category == 'Food'
                    ? foodIconPath
                    : category == 'Shopping'
                        ? shoppingIconPath
                        : subscriptionIconPath,
                height: 50,
                width: 50,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    isExpense ? '-\u{20B9}$amount' : '+\u{20B9}$amount',
                    style: TextStyle(
                      color: isExpense
                          ? AppColors.instance.red100
                          : AppColors.instance.green100,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    createdAt,
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
