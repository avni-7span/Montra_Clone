import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';
import 'package:montra_clone/core/utils/fire_store_queries.dart';
import 'package:montra_clone/modules/home/widgets/budget_card.dart';
import 'package:montra_clone/modules/transaction/bloc/transaction_bloc.dart';
import 'package:montra_clone/modules/transaction/widgets/current_filter_container.dart';
import 'package:montra_clone/modules/transaction/widgets/report_container.dart';

@RoutePage()
class TransactionScreen extends StatefulWidget implements AutoRouteWrapper {
  const TransactionScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TransactionBloc(), //..add(const FetchDataByDayEvent()),
      child: this,
    );
  }

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(const FetchDataByDayEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<TransactionBloc>().add(const FetchDataByDayEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CurrentFilterContainer(),
        actions: [
          IconButton(
            onPressed: () {},
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
            BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.dataByDayMap.length,
                  itemBuilder: (context, index) {
                    final key = state.dataByDayMap.keys.elementAt(index);
                    final list = state.dataByDayMap[key];
                    return Column(
                      children: [
                        DateTitle(date: key),
                        const SizedBox(
                          height: 10,
                        ),
                        ...list!.map(
                          (e) => BudgetCard(
                            category: e.category,
                            isExpense: e.isExpense,
                            amount: e.transactionAmount,
                            description: e.transactionAmount,
                            createdAt: FireStoreQueries.instance
                                .getFormatedDate(e.createdAt),
                            onCardTap: () {},
                          ),
                        ),
                      ],
                    );
                  },
                );
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
      textAlign: TextAlign.start,
      style: TextStyle(
        fontSize: 20,
        color: AppColors.instance.dark100,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
