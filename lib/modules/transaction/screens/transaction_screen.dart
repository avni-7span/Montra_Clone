import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';
import 'package:montra_clone/core/utils/fire_store_queries.dart';
import 'package:montra_clone/modules/home/widgets/expense_tracker_card.dart';
import 'package:montra_clone/modules/transaction/bloc/transaction_bloc.dart';
import 'package:montra_clone/modules/transaction/widgets/current_filter_container.dart';
import 'package:montra_clone/modules/transaction/widgets/filter_bottom_sheet.dart';
import 'package:montra_clone/modules/transaction/widgets/report_container.dart';

@RoutePage()
class TransactionScreen extends StatefulWidget implements AutoRouteWrapper {
  const TransactionScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionBloc()..add(const FetchDataByDayEvent()),
      child: this,
    );
  }

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<TransactionBloc>().add(const FetchDataByDayEvent());
  }

  Future<void> _showFilterBottomSheet({required BuildContext screenContext}) {
    return showModalBottomSheet(
      backgroundColor: AppColors.instance.light100,
      isScrollControlled: true,
      context: context,
      builder: (context) => BlocProvider.value(
        value: BlocProvider.of<TransactionBloc>(screenContext),
        child: FilterBottomSheet(
          onBackTap: () {
            Navigator.pop(screenContext);
          },
          onApplyTap: () {
            Navigator.pop(screenContext);
          },
        ),
      ),
    );
  }

  TextStyle textStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 25,
    color: AppColors.instance.primary,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            return CurrentFilterContainer(
              filterTitle: state.filterBy ?? 'All',
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showFilterBottomSheet(screenContext: context);
            },
            icon: const Icon(
              Icons.sort,
              size: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            ReportContainer(onTap: () {
              context.router.push(
                const FinancialReportRoute(),
              );
            }),
            const SizedBox(height: 10),
            BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                return state.status == TransactionStateStatus.loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : state.status == TransactionStateStatus.success
                        ? state.isDataInList
                            ? state.transactionList.isEmpty
                                ? Center(
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      'There is no transactions to show for this filter',
                                      style: textStyle,
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: state.transactionList.length,
                                      itemBuilder: (context, index) =>
                                          ExpenseTrackerCard(
                                        category: state
                                            .transactionList[index].category,
                                        isExpense: state
                                            .transactionList[index].isExpense,
                                        amount: state.transactionList[index]
                                            .transactionAmount,
                                        description: state
                                            .transactionList[index].description,
                                        createdAt: FireStoreQueries.instance
                                            .getFormattedTime(state
                                                .transactionList[index]
                                                .createdAt),
                                        onCardTap: () {},
                                      ),
                                    ),
                                  )
                            : state.transactionMap.isEmpty
                                ? Center(
                                    child: Text(
                                      'There is no transactions to show for this filter',
                                      style: textStyle,
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: state.transactionMap.length,
                                      itemBuilder: (context, index) {
                                        final key = state.transactionMap.keys
                                            .elementAt(index);
                                        final list =
                                            state.transactionMap[key] ?? [];
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                DateTitle(date: key),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            ...list.map(
                                              (e) => ExpenseTrackerCard(
                                                category: e.category,
                                                isExpense: e.isExpense,
                                                amount: e.transactionAmount,
                                                description: e.description,
                                                createdAt: FireStoreQueries
                                                    .instance
                                                    .getFormattedTime(
                                                        e.createdAt),
                                                onCardTap: () {},
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  )
                        : const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}

class DateTitle extends StatelessWidget {
  const DateTitle({
    super.key,
    required this.date,
  });

  final String date;

  @override
  Widget build(BuildContext context) {
    return Text(
      date,
      // textAlign: TextAlign.start,
      style: TextStyle(
        fontSize: 15,
        color: AppColors.instance.dark100,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
