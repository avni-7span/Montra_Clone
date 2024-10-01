import 'package:cloud_firestore/cloud_firestore.dart';

class ChartDataModel {
  const ChartDataModel({
    required this.dateTime,
    required this.amount,
  });

  final double amount;
  final DateTime dateTime;
}
