import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';
import 'package:montra_clone/core/utils/custom_snackbar.dart';
import 'package:montra_clone/modules/budget/bloc/budget_bloc.dart';
import 'package:montra_clone/modules/budget/widgets/budget_card.dart';
import 'package:montra_clone/modules/budget/widgets/create_budget_button.dart';

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
          showTheSnackBar(
              message: state.errorMessage,
              context: context,
              isBehaviourFloating: true);
        }
      },
      child: Container(
        color: AppColors.instance.primary,
        child: Column(
          children: [
            const SizedBox(height: 100),
            const _AppBarWidget(),
            const SizedBox(height: 10),
            BlocBuilder<BudgetBloc, BudgetState>(
              builder: (context, state) {
                return Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.instance.light40,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shrinkWrap: true,
                      children: [
                        if (state.status == BudgetStateStatus.loading) ...[
                          const Spacer(),
                          const Center(child: CircularProgressIndicator()),
                          const Spacer()
                        ] else if (state.status ==
                            BudgetStateStatus.success) ...[
                          if (state.budgetDataModelList.isEmpty) ...[
                            const Spacer(),
                            Center(
                              child: Text(
                                createBudget,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.instance.dark25,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const Spacer(),
                          ] else
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: state.budgetDataModelList.length,
                              itemBuilder: (context, index) => BudgetCard(
                                category:
                                    state.budgetDataModelList[index].category,
                                spentAmount: state.spentAmountMap[state
                                        .budgetDataModelList[index].category] ??
                                    0.0,
                                budgetAmount: state
                                    .budgetDataModelList[index].budgetAmount,
                                alertLimit:
                                    state.budgetDataModelList[index].alertLimit,
                                onCardTap: () {
                                  context.pushRoute(
                                    DetailBudgetRoute(
                                      budgetModel:
                                          state.budgetDataModelList[index],
                                      spentAmount: state.spentAmountMap[state
                                              .budgetDataModelList[index]
                                              .category] ??
                                          0.0,
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBarWidget extends StatelessWidget {
  const _AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetBloc, BudgetState>(
      builder: (context, state) {
        return state.categoryList.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'This month',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: AppColors.instance.light100,
                      ),
                    ),
                    CreateBudgetButton(
                      onTap: () async {
                        await context.pushRoute(CreateBudgetRoute());
                      },
                    )
                  ],
                ),
              )
            : Text(
                'This month',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: AppColors.instance.light100,
                ),
              );
      },
    );
  }
}
