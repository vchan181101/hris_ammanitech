import 'package:flutter/material.dart';
import '../../../../shared/charts/bar_chart_widget.dart';
import '../../../../screens/karyawan_staff/widgets/bar_chart_widget.dart';

class ExpenseBarChart extends StatelessWidget {
  final List<WeeklyWorkLog> weeklyLogs;

  const ExpenseBarChart({super.key, required this.weeklyLogs});

  @override
  Widget build(BuildContext context) {
    return SharedBarChartWidget(weeklyLogs: weeklyLogs);
  }
}
