import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/core/utils/custom_snackbar.dart';
import 'package:montra_clone/modules/home/bloc/home_bloc.dart';
import 'package:montra_clone/modules/home/widgets/budget_card.dart';
import 'package:montra_clone/modules/home/widgets/budget_container.dart';
import 'package:montra_clone/modules/home/widgets/filter_row.dart';

@RoutePage()
class HomeScreen extends StatefulWidget implements AutoRouteWrapper {
  const HomeScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()
        ..add(const FetchTransactionList())
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
    context.read<HomeBloc>().add(const FetchTransactionList());
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
              BudgetContainer(
                totalBudget: state.totalAccountBalance,
                income: state.totalIncome,
                expense: state.totalExpense,
              ),
              const FilterRow(),
              Expanded(
                child: state.status == HomeStateStatus.transactionDataLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount: state.transactionList.length,
                        itemBuilder: (context, index) {
                          return BudgetCard(
                            category: state.transactionList[index].category,
                            isExpense: state.transactionList[index].isExpense,
                            amount:
                                state.transactionList[index].transactionAmount,
                            description:
                                state.transactionList[index].description,
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
