import 'package:flutter/material.dart';

class DoughnutChartData {
  const DoughnutChartData({
    required this.category,
    required this.color,
    required this.value,
  });

  final String category;
  final Color color;
  final double value;
}
