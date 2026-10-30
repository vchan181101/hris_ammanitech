import 'package:flutter/material.dart';
import '../../screens/karyawan_staff/widgets/donut_chart_widget.dart';

class SharedPieChartWidget extends StatelessWidget {
  final List<AttendanceDataItem> data;

  const SharedPieChartWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return AttendanceDonutChartWidget(data: data);
  }
}
