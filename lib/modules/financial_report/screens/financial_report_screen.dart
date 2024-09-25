import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/modules/financial_report/bloc/financial_analysis_bloc.dart';
import 'package:montra_clone/modules/financial_report/widgets/analysis_pageview_widget.dart';
import 'package:montra_clone/modules/financial_report/widgets/page_slide_container.dart';

@RoutePage()
class FinancialReportScreen extends StatelessWidget
    implements AutoRouteWrapper {
  const FinancialReportScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => FinancialAnalysisBloc(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinancialAnalysisBloc, FinancialAnalysisState>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          backgroundColor: state.currentIndex == 0
              ? AppColors.instance.red80
              : state.currentIndex == 1
                  ? AppColors.instance.green100
                  : AppColors.instance.primary,
          body: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    4,
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
                          .read<FinancialAnalysisBloc>()
                          .add(PageChangeEvent(index: value));
                    },
                    children: const [
                      AnalysisPageViewWidget(),
                      AnalysisPageViewWidget(),
                      AnalysisPageViewWidget(),
                      AnalysisPageViewWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
