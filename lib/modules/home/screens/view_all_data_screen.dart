import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';
import 'package:montra_clone/core/utils/fire_store_queries.dart';
import 'package:montra_clone/modules/home/bloc/home_bloc.dart';
import 'package:montra_clone/modules/home/widgets/expense_tracker_card.dart';

@RoutePage()
class ViewAllDataScreen extends StatelessWidget implements AutoRouteWrapper {
  const ViewAllDataScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(const FetchAllTransactionData()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColors.instance.light100,
            appBar: AppBar(
              centerTitle: true,
              title: const Text('All Transactions'),
              backgroundColor: AppColors.instance.light100,
            ),
            body: state.status == HomeStateStatus.failure
                ? const Center(
                    child: Text(
                      'Could Not load data !',
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                : state.status == HomeStateStatus.transactionDataLoading
                    ? const Center(child: CircularProgressIndicator())
                    : state.status == HomeStateStatus.success
                        ? state.transactionList.isEmpty
                            ? const Center(
                                child: Text(
                                    'You have not made any transactions yet'),
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
                        : const SizedBox());
      },
    );
  }
}
