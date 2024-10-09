import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';
import 'package:montra_clone/core/widgets/button_title.dart';
import 'package:montra_clone/core/widgets/custom_elevated_button.dart';
import 'package:montra_clone/modules/financial_report/bloc/financial_report_bloc.dart';
import 'package:montra_clone/modules/financial_report/widgets/analysis_pageview_widget.dart';
import 'package:montra_clone/modules/financial_report/widgets/page_slide_container.dart';

@RoutePage()
class FinancialReportScreen extends StatelessWidget
    implements AutoRouteWrapper {
  const FinancialReportScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => FinancialReportBloc()
        ..add(const FetchThisMonthFinancialReportEvent()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinancialReportBloc, FinancialReportState>(
      builder: (context, state) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Scaffold(
            // extendBody: true,
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      3,
                      (index) {
                        return PageSlideContainer(
                          isCurrentIndex: state.currentIndex == index,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      onPageChanged: (value) {
                        context
                            .read<FinancialReportBloc>()
                            .add(PageChangeEvent(index: value));
                      },
                      children: [
                        AnalysisPageViewWidget(
                          isExpenseAnalysis: true,
                          totalAmount:
                              '\u{20B9}${double.parse(state.totalExpense).toStringAsFixed(2)}',
                          highestAmount: '\u{20B9}${state.highestExpense}',
                          category: state.expenseCategory,
                        ),
                        AnalysisPageViewWidget(
                          isExpenseAnalysis: false,
                          totalAmount:
                              '\u{20B9}${double.parse(state.totalIncome).toStringAsFixed(2)}',
                          highestAmount: '\u{20B9}${state.highestIncome}',
                          category: state.incomeCategory,
                        ),
                        LastPageView(
                          onTap: () {
                            context.replaceRoute(const AnalysisRoute());
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class LastPageView extends StatelessWidget {
  const LastPageView({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      height: size.height,
      width: size.width,
      color: AppColors.instance.primary,
      child: Column(
        children: [
          const SizedBox(height: 100),
          Text(
            '''“Financial freedom is freedom from fear.”''',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.instance.light100,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '-Robert Kiyosaki',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: AppColors.instance.light100,
            ),
          ),
          const Spacer(),
          CustomElevatedButton(
              buttonLabel: const ButtonTitle(
                isPurple: false,
                buttonLabel: 'See the full details',
              ),
              isPurple: false,
              onPressed: onTap),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
