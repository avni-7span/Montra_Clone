import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';
import 'package:montra_clone/core/utils/custom_snackbar.dart';
import 'package:montra_clone/core/widgets/button_title.dart';
import 'package:montra_clone/core/widgets/custom_elevated_button.dart';
import 'package:montra_clone/modules/budget/bloc/budget_bloc.dart';
import 'package:montra_clone/modules/budget/widgets/budget_card.dart';

@RoutePage()
class BudgetScreen extends StatefulWidget implements AutoRouteWrapper {
  const BudgetScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => BudgetBloc()
        ..add(LoadBudgetDataFromFireStoreEvent())
        ..add(LoadCategoryList()),
      child: this,
    );
  }

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BudgetBloc>().add(LoadBudgetDataFromFireStoreEvent());
  }

  final String createBudget =
      'You don\'t have any budgets yet,Let\'s create one so you can track your expense.';

  @override
  Widget build(BuildContext context) {
    return BlocListener<BudgetBloc, BudgetState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == BudgetStateStatus.failure) {
          showTheSnackBar(message: state.errorMessage, context: context);
        }
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.instance.primary,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Text(
                'This month',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: AppColors.instance.light100,
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<BudgetBloc, BudgetState>(
                builder: (context, state) {
                  return Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.instance.light40,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListView(
                          children: [
                            if (state.status == BudgetStateStatus.loading) ...[
                              const Spacer(),
                              const Center(child: CircularProgressIndicator()),
                              const Spacer()
                            ] else if (state.status ==
                                BudgetStateStatus.success) ...[
                              if (state.budgetDataModelList.isEmpty) ...[
                                const Spacer(),
                                Text(
                                  createBudget,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.instance.dark25,
                                    fontSize: 20,
                                  ),
                                ),
                                const Spacer(),
                              ] else
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.budgetDataModelList.length,
                                  itemBuilder: (context, index) => BudgetCard(
                                    category: state
                                        .budgetDataModelList[index].category,
                                    spentAmount: state.spentAmountMap[state
                                            .budgetDataModelList[index]
                                            .category] ??
                                        0.0,
                                    budgetAmount: state
                                        .budgetDataModelList[index]
                                        .budgetAmount,
                                  ),
                                )
                            ],
                            if (state.categoryList.isNotEmpty) ...[
                              const SizedBox(height: 20),
                              CustomElevatedButton(
                                buttonLabel: const ButtonTitle(
                                    isPurple: true,
                                    buttonLabel: 'Create Budget'),
                                isPurple: true,
                                onPressed: () async {
                                  await context
                                      .pushRoute(const CreateBudgetRoute());
                                },
                              )
                            ],
                            const SizedBox(height: 70),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
