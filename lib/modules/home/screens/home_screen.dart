import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/core/utils/fire_store_queries.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';
import 'package:montra_clone/core/utils/custom_snackbar.dart';
import 'package:montra_clone/modules/home/bloc/home_bloc.dart';
import 'package:montra_clone/modules/home/widgets/expense_tracker_card.dart';
import 'package:montra_clone/modules/home/widgets/income_expense_container.dart';
import 'package:montra_clone/modules/home/widgets/filter_row.dart';
import 'package:montra_clone/modules/home/widgets/view_all_data_raw.dart';

@RoutePage()
class HomeScreen extends StatefulWidget implements AutoRouteWrapper {
  const HomeScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()
        ..add(const FetchDataOfCurrentDay())
        ..add(const FetchAmountDetails()),
      child: this,
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const FetchAmountDetails());
    context.read<HomeBloc>().add(const FetchDataOfCurrentDay());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.status == HomeStateStatus.failure) {
          return showTheSnackBar(
            message: state.errorMessage,
            context: context,
            isBehaviourFloating: true,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              IncomeExpenseContainer(
                totalBudget: state.totalAccountBalance,
                income: state.totalIncome,
                expense: state.totalExpense,
              ),
              const FilterRow(),
              ViewAllDataRaw(
                onViewAppTap: () =>
                    context.router.push(const ViewAllDataRoute()),
              ),
              Expanded(
                child: state.status == HomeStateStatus.transactionDataLoading
                    ? const Center(child: CircularProgressIndicator())
                    : state.status == HomeStateStatus.success
                        ? state.transactionList.isEmpty
                            ? Center(
                                child: Text(switch (state.filterName) {
                                  'Today' =>
                                    'You have not added any transactions today',
                                  'Week' => 'No transactions in this week',
                                  'Month' => 'No transactions in this month',
                                  String() => 'No transactions in this Year',
                                }),
                              )
                            : ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                itemCount: state.transactionList.length,
                                itemBuilder: (context, index) {
                                  return ExpenseTrackerCard(
                                    category:
                                        state.transactionList[index].category,
                                    isExpense:
                                        state.transactionList[index].isExpense,
                                    amount: state.transactionList[index]
                                        .transactionAmount,
                                    description: state
                                        .transactionList[index].description,
                                    createdAt: FireStoreQueries.instance
                                        .getFormatedDate(state
                                            .transactionList[index].createdAt),
                                    onCardTap: () {
                                      context.router.push(
                                        ExpenseTrackerRoute(
                                          isExpense: state
                                              .transactionList[index].isExpense,
                                          transactionModel:
                                              state.transactionList[index],
                                        ),
                                      );
                                    },
                                  );
                                },
                              )
                        : const Text('Could not load transactions'),
              ),
            ],
          ),
        );
      },
    );
  }
}
