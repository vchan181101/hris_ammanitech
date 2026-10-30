import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../auth/data/models/user_model.dart';
import '../widgets/executive_summary_card.dart';
import '../widgets/attendance_pie_chart.dart';
import '../widgets/expense_bar_chart.dart';
import '../../../../screens/karyawan_staff/widgets/donut_chart_widget.dart';
import '../../../../screens/karyawan_staff/widgets/bar_chart_widget.dart';

class ExecutiveDashboardScreen extends StatelessWidget {
  final UserModel user;

  const ExecutiveDashboardScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    const groupAttendanceData = [
      AttendanceDataItem(label: 'Hadir Group', value: 45, percentage: 90, color: AppColors.success),
      AttendanceDataItem(label: 'Cuti / Dinas', value: 3, percentage: 6, color: Colors.blue),
      AttendanceDataItem(label: 'Terlambat', value: 2, percentage: 4, color: AppColors.warning),
    ];

    const groupExpenseData = [
      WeeklyWorkLog(weekLabel: 'PT AMI (Hold)', workHours: 40, overtimeHours: 8),
      WeeklyWorkLog(weekLabel: 'PT GMT (IoT)', workHours: 52, overtimeHours: 14),
      WeeklyWorkLog(weekLabel: 'PT HGT (Com)', workHours: 36, overtimeHours: 6),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Executive Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0369A1), AppColors.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white24,
                  child: Text(user.name[0], style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text('${user.position} • ${user.company}', style: const TextStyle(fontSize: 12, color: Colors.white70)),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)),
                        child: const Text('Executive Board View', style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Executive Summary KPI Cards
          const Row(
            children: [
              Expanded(
                child: ExecutiveSummaryCard(
                  title: 'Total SDM Group',
                  value: '50 Karyawan',
                  subtitle: 'PT AMI, GMT, HGT',
                  icon: Icons.corporate_fare_rounded,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ExecutiveSummaryCard(
                  title: 'Approval Direksi',
                  value: '2 Permohonan',
                  subtitle: 'Reimburse > 5 Jt',
                  icon: Icons.verified_user_rounded,
                  color: AppColors.warning,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          const Text('Kinerja SDM & Keuangan Holding', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 12),

          AttendancePieChart(data: groupAttendanceData),
          const SizedBox(height: 16),
          ExpenseBarChart(weeklyLogs: groupExpenseData),
        ],
      ),
    );
  }
}
