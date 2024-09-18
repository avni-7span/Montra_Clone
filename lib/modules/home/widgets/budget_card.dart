import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/image_paths.dart';

class BudgetCard extends StatelessWidget {
  const BudgetCard(
      {super.key,
      required this.category,
      required this.isExpense,
      required this.amount,
      required this.description,
      required this.createdAt});

  final String category;
  final bool isExpense;
  final String amount;
  final String description;
  final String createdAt;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    description.length <= 10
                        ? description
                        : description.substring(0, 10),
                    overflow:
                        description.length > 10 ? TextOverflow.ellipsis : null,
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
              const SizedBox(width: 30),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      isExpense ? '-\$$amount' : '+\$$amount',
                      style: TextStyle(
                        color: isExpense
                            ? AppColors.instance.red100
                            : AppColors.instance.green100,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      createdAt,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
