import 'package:flutter/material.dart';
import 'package:montra_clone/modules/financial_analysis/model/doughnut_chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DoughnutGraphContainer extends StatelessWidget {
  const DoughnutGraphContainer({
    super.key,
    required this.dataList,
    required this.totalAmount,
  });

  final List<DoughnutChartData> dataList;
  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 185,
      width: 372,
      child: Center(
        child: SfCircularChart(
          annotations: <CircularChartAnnotation>[
            CircularChartAnnotation(
              widget: Text(
                '\u{20B9}${totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
          series: <CircularSeries>[
            DoughnutSeries<DoughnutChartData, String>(
              dataSource: dataList,
              xValueMapper: (data, _) => data.category,
              yValueMapper: (data, _) => (data.value) * totalAmount,
              pointColorMapper: (data, _) => data.color,
              radius: '110%',
              innerRadius: '75%',
            )
          ],
        ),
      ),
    );
  }
}
