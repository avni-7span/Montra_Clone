import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';
import 'package:montra_clone/core/utils/fire_store_queries.dart';
import 'package:montra_clone/modules/financial_analysis/bloc/financial_analysis_bloc.dart';
import 'package:montra_clone/modules/financial_analysis/widgets/category_data_column.dart';
import 'package:montra_clone/modules/financial_analysis/widgets/donught_graph_container.dart';
import 'package:montra_clone/modules/financial_analysis/widgets/filter_row.dart';
import 'package:montra_clone/modules/financial_analysis/widgets/graph_container.dart';
import 'package:montra_clone/modules/financial_analysis/widgets/income_expense_filter.dart';
import 'package:montra_clone/modules/home/widgets/expense_tracker_card.dart';

@RoutePage()
class AnalysisScreen extends StatefulWidget implements AutoRouteWrapper {
  const AnalysisScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FinancialAnalysisBloc()..add(const FetchDataListEvent()),
      child: this,
    );
  }

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.instance.light100,
      appBar: AppBar(
        backgroundColor: AppColors.instance.light100,
        centerTitle: true,
        title: const Text('Financial Report'),
        leading: IconButton(
          onPressed: () async {
            await context.router.replaceAll(
              [const TransactionRoute()],
              updateExistingRoutes: false,
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocBuilder<FinancialAnalysisBloc, FinancialAnalysisState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilterRow(
                  onFilterTap: (filterValue) {
                    context.read<FinancialAnalysisBloc>().add(
                          SetFilterTypeEvent(filterName: filterValue),
                        );
                    context.read<FinancialAnalysisBloc>().add(
                          const FetchDataListEvent(),
                        );
                  },
                  isBudgetType: state.isAnalysisBudgetType,
                  onBudgetTypeTap: () =>
                      context.read<FinancialAnalysisBloc>().add(
                            const AnalysisTypeChangeEvent(
                                isAnalysisBudgetType: true),
                          ),
                  onCategoryTypeTap: () =>
                      context.read<FinancialAnalysisBloc>().add(
                            const AnalysisTypeChangeEvent(
                                isAnalysisBudgetType: false),
                          ),
                ),
                const SizedBox(height: 20),
                if (state.isAnalysisBudgetType) ...[
                  _TotalBudget(totalBudget: '\u{20B9}${state.totalAmount}'),
                  const SizedBox(height: 20),
                  GraphContainer(
                    dataList: state.chartDataList,
                  )
                ] else ...[
                  const Text('Report based on category',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                  const SizedBox(height: 20),
                  DoughnutGraphContainer(
                    dataList: state.analysisFilterType == AnalysisFilter.expense
                        ? state.expenseChartList
                        : state.incomeChartList,
                    totalAmount: state.totalAmount,
                  )
                ],
                const SizedBox(height: 15),
                IncomeExpenseFilter(
                  filterType: state.analysisFilterType,
                  onIncomeTap: () {
                    context.read<FinancialAnalysisBloc>().add(
                        const AnalysisFilterChangeEvent(
                            analysisFilter: AnalysisFilter.income));
                    context
                        .read<FinancialAnalysisBloc>()
                        .add(const FetchDataListEvent());
                  },
                  onExpenseTap: () {
                    context.read<FinancialAnalysisBloc>().add(
                        const AnalysisFilterChangeEvent(
                            analysisFilter: AnalysisFilter.expense));
                    context
                        .read<FinancialAnalysisBloc>()
                        .add(const FetchDataListEvent());
                  },
                ),
                const SizedBox(height: 20),
                state.isAnalysisBudgetType
                    ? const _TransactionList()
                    : const _CategoryDataList()
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TotalBudget extends StatelessWidget {
  const _TotalBudget({
    super.key,
    required this.totalBudget,
  });

  final String totalBudget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            totalBudget,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}

class _TransactionList extends StatelessWidget {
  const _TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinancialAnalysisBloc, FinancialAnalysisState>(
      builder: (context, state) {
        final list = state.transactionList;
        return Expanded(
          child: state.status == FinancialAnalysisStateStatus.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state.status == FinancialAnalysisStateStatus.success
                  ? list.isEmpty
                      ? const Center(
                          child: Text('No Transactions'),
                        )
                      : ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) => ExpenseTrackerCard(
                            category: list[index].category,
                            isExpense: list[index].isExpense,
                            amount: list[index].transactionAmount,
                            description: list[index].description,
                            createdAt: FireStoreQueries.instance
                                .getFormatedDate(list[index].createdAt),
                            onCardTap: () {},
                          ),
                        )
                  : const Center(
                      child: Text('No data'),
                    ),
        );
      },
    );
  }
}

class _CategoryDataList extends StatelessWidget {
  const _CategoryDataList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinancialAnalysisBloc, FinancialAnalysisState>(
      buildWhen: (previous, current) =>
          previous.categoryRateMap != current.categoryRateMap ||
          previous.analysisFilterType != current.analysisFilterType,
      builder: (context, state) {
        return CategoryDataColumn(
          isExpense: state.analysisFilterType == AnalysisFilter.expense,
          categoryValueMap: state.categoryRateMap,
          totalAmount: state.totalAmount,
        );
      },
    );
  }
}
