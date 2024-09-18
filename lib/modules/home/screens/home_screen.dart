import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/core/utils/custom_snackbar.dart';
import 'package:montra_clone/modules/home/bloc/home_bloc.dart';
import 'package:montra_clone/modules/home/widgets/budget_card.dart';
import 'package:montra_clone/modules/home/widgets/budget_container.dart';

@RoutePage()
class HomeScreen extends StatelessWidget implements AutoRouteWrapper {
  const HomeScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(const FetchTransactionList()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.status == HomeStateStatus.failure) {
          return showTheSnackBar(message: state.errorMessage, context: context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              const BudgetContainer(
                totalBudget: 0,
                income: 0,
                expense: 0,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: state.transactionList.length,
                  itemBuilder: (context, index) {
                    return BudgetCard(
                      category: state.transactionList[index].category,
                      isExpense: state.transactionList[index].isExpense,
                      amount: state.transactionList[index].transactionAmount,
                      description: state.transactionList[index].description,
                      createdAt: state.transactionList[index].createdAt,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
