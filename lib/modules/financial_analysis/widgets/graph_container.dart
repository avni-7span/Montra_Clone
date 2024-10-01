import 'package:flutter/material.dart';
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
    return Container(
      height: 185,
      width: 372,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.instance.light20,
        ),
      ),
      child: SfCartesianChart(
        series: [
          LineSeries<ChartDataModel, DateTime>(
            xValueMapper: (model, _) => model.dateTime,
            yValueMapper: (model, _) => model.amount,
            dataSource: dataList,
          )
        ],
      ),
    );
  }
}
