import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../auth/data/models/user_model.dart';
import '../widgets/executive_summary_card.dart';
import '../widgets/attendance_pie_chart.dart';
import '../../../../screens/karyawan_staff/widgets/donut_chart_widget.dart';

class ManagerDashboardScreen extends StatelessWidget {
  final UserModel user;

  const ManagerDashboardScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    const deptAttendanceData = [
      AttendanceDataItem(label: 'Hadir Departemen', value: 12, percentage: 92, color: AppColors.success),
      AttendanceDataItem(label: 'Izin Sakit', value: 1, percentage: 8, color: Colors.blue),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Manager Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primaryDark, AppColors.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.accentLight,
                  child: Text(user.name[0], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text('${user.position} • ${user.department}', style: const TextStyle(fontSize: 12, color: Colors.white70)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: ExecutiveSummaryCard(
                  title: 'Anggota Tim',
                  value: '13 Anggota',
                  subtitle: user.department,
                  icon: Icons.groups_rounded,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: ExecutiveSummaryCard(
                  title: 'Approval Departemen',
                  value: '3 Permohonan',
                  subtitle: 'Cuti & Reimburse',
                  icon: Icons.assignment_turned_in_rounded,
                  color: AppColors.warning,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          const Text('Kinerja Kehadiran Departemen', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 12),
          AttendancePieChart(data: deptAttendanceData),
        ],
      ),
    );
  }
}
