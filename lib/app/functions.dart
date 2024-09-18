import 'package:intl/intl.dart';

String getCurrentDate() {
  final dateNow = DateTime.now();
  String formatter = DateFormat('yMd').format(dateNow);
  return formatter;
}
