import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montra_clone/app/image_paths.dart';
import 'package:montra_clone/app_ui/theme/utils/extensions.dart';
import 'package:montra_clone/app_ui/widgets/atoms/border_radius.dart';
import 'package:montra_clone/app_ui/widgets/atoms/padding.dart';
import 'package:montra_clone/app_ui/widgets/atoms/spacing.dart';
import 'package:montra_clone/app_ui/widgets/atoms/text.dart';

class AppBudgetCard extends StatelessWidget {
  const AppBudgetCard({
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
        padding: const EdgeInsets.all(Insets.small12),
        margin: const EdgeInsets.all(Insets.xsmall8),
        width: double.infinity,
        height: 89,
        decoration: BoxDecoration(
          color: context.colorScheme.light40,
          borderRadius: const BorderRadius.all(
            Radius.circular(AppBorderRadius.medium24),
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: 70,
              width: 70,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: !isExpense
                    ? context.colorScheme.green20
                    : category == 'Food'
                        ? context.colorScheme.red20
                        : category == 'Shopping'
                            ? context.colorScheme.yellow20
                            : category == 'Transportation'
                                ? context.colorScheme.blue20
                                : context.colorScheme.violet20,
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppBorderRadius.medium20),
                ),
              ),
              child: SvgPicture.asset(
                !isExpense
                    ? salaryIconPath
                    : category == 'Food'
                        ? foodIconPath
                        : category == 'Shopping'
                            ? shoppingIconPath
                            : category == 'Transportation'
                                ? carIconPath
                                : subscriptionIconPath,
                height: 50,
                width: 50,
              ),
            ),
            const HSpace(10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: category,
                    level: AppTextLevel.regular16,
                    maxLines: 1,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  AppText(
                    text: description,
                    level: AppTextLevel.regular16,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: Insets.small10, left: Insets.medium16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppText(
                    text: isExpense ? '-\u{20B9}$amount' : '+\u{20B9}$amount',
                    level: AppTextLevel.regular16,
                    color: isExpense
                        ? context.colorScheme.red100
                        : context.colorScheme.green100,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppText.tiny12(text: createdAt),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
