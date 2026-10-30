import 'package:flutter/material.dart';
import '../../../../shared/charts/pie_chart_widget.dart';
import '../../../../screens/karyawan_staff/widgets/donut_chart_widget.dart';

class AttendancePieChart extends StatelessWidget {
  final List<AttendanceDataItem> data;

  const AttendancePieChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SharedPieChartWidget(data: data);
  }
}
