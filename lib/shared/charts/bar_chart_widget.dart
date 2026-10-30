import 'package:flutter/material.dart';
import '../../screens/karyawan_staff/widgets/bar_chart_widget.dart';

class SharedBarChartWidget extends StatelessWidget {
  final List<WeeklyWorkLog> weeklyLogs;

  const SharedBarChartWidget({super.key, required this.weeklyLogs});

  @override
  Widget build(BuildContext context) {
    return WorkOvertimeBarChartWidget(weeklyLogs: weeklyLogs);
  }
}
