import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/modules/financial_analysis/model/chart_data_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphContainer extends StatelessWidget {
  const GraphContainer({
    super.key,
    required this.dataList,
  });

  final List<ChartDataModel> dataList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: 372,
      child: SfCartesianChart(
        margin: const EdgeInsets.all(0),
        primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat.Md(),
          intervalType: DateTimeIntervalType.auto,
          interval: 10,
          // isVisible: false,
          borderColor: Colors.transparent,
          borderWidth: 0,
        ),
        primaryYAxis: const NumericAxis(
          // title: AxisTitle(text: 'Amount'),
          // isVisible: false,
          borderWidth: 0,
          borderColor: Colors.transparent,
        ),
        series: [
          SplineAreaSeries<ChartDataModel, DateTime>(
            xValueMapper: (model, _) => model.dateTime,
            yValueMapper: (model, _) => model.amount,
            dataSource: dataList,
            gradient: LinearGradient(
              colors: [
                AppColors.instance.violet40,
                AppColors.instance.violet20,
                AppColors.instance.light100,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderColor: AppColors.instance.primary,
            borderWidth: 5,
          )
        ],
      ),
    );
  }
}
