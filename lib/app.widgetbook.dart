import 'package:flutter/material.dart';
import 'package:montra_clone/core/widgets/button_title.dart';
import 'package:montra_clone/core/widgets/custom_elevated_button.dart';
import 'package:montra_clone/modules/budget/widgets/budget_card.dart';
import 'package:montra_clone/modules/home/widgets/expense_tracker_card.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const HotReload());
}

class HotReload extends StatelessWidget {
  const HotReload({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: const [],
      directories: [
        WidgetbookCategory(
          name: 'Widgets',
          children: [
            WidgetbookComponent(
              name: 'Button',
              useCases: [
                WidgetbookUseCase(
                  name: 'primary button',
                  builder: (context) => Center(
                    child: CustomElevatedButton(
                      buttonLabel: const ButtonTitle(
                        isPurple: true,
                        buttonLabel: 'Primary button',
                      ),
                      isPurple: context.knobs
                          .boolean(label: 'isPurple', initialValue: true),
                      onPressed: () {},
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Secondary button',
                  builder: (context) => Center(
                    child: CustomElevatedButton(
                      buttonLabel: const ButtonTitle(
                          isPurple: false, buttonLabel: 'Secondary button'),
                      isPurple: false,
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        WidgetbookCategory(name: 'Card', children: [
          WidgetbookComponent(
            name: 'Card widgets',
            useCases: [
              WidgetbookUseCase(
                name: 'Budget card',
                builder: (context) => BudgetCard(
                  category: context.knobs.list(label: 'categories', options: [
                    'Shopping',
                    'Food',
                    'Transportation',
                    'Subscription',
                    'Salary',
                    'Rental Income',
                    'Interest',
                  ]),
                  spentAmount: context.knobs.double.slider(
                    label: 'spent amount',
                    initialValue: 200,
                    min: 0,
                    max: 6000,
                  ),
                  budgetAmount: 5000,
                  onCardTap: () {},
                  alertLimit: 80,
                ),
              ),
              WidgetbookUseCase(
                name: 'Expense tracker card',
                builder: (context) => ExpenseTrackerCard(
                  category: context.knobs.list(label: 'categories', options: [
                    'Shopping',
                    'Food',
                    'Transportation',
                    'Subscription'
                  ]),
                  isExpense: context.knobs
                      .list(label: 'isExpense', options: [true, false]),
                  amount: context.knobs.double
                      .slider(
                        label: 'amount',
                        max: 500,
                        min: 0,
                        initialValue: 250,
                      )
                      .toStringAsFixed(2),
                  description: context.knobs
                      .string(label: 'description', initialValue: 'Grocerry'),
                  createdAt: '27/7/2025',
                  onCardTap: () {},
                ),
              ),
            ],
          ),
        ])
      ],
    );
  }
}
