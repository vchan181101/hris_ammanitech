import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class WeeklyWorkLog {
  final String weekLabel; // e.g., 'W1', 'W2', 'W3', 'W4'
  final double workHours; // e.g., 40.0
  final double overtimeHours; // e.g., 6.0

  const WeeklyWorkLog({
    required this.weekLabel,
    required this.workHours,
    required this.overtimeHours,
  });
}

class WorkOvertimeBarChartWidget extends StatelessWidget {
  final List<WeeklyWorkLog> weeklyLogs;

  const WorkOvertimeBarChartWidget({
    super.key,
    required this.weeklyLogs,
  });

  @override
  Widget build(BuildContext context) {
    // Cari nilai maksimum untuk penskalaan tinggi grafik
    double maxHours = 50.0;
    for (var log in weeklyLogs) {
      if (log.workHours > maxHours) maxHours = log.workHours;
      if (log.overtimeHours > maxHours) maxHours = log.overtimeHours;
    }

    final double totalWork = weeklyLogs.fold(0, (sum, item) => sum + item.workHours);
    final double totalOT = weeklyLogs.fold(0, (sum, item) => sum + item.overtimeHours);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.bar_chart_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jam Kerja & Lembur',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'Pencapaian Mingguan Bulan Ini',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${totalWork.toInt()} Jam Total',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    '+${totalOT.toInt()} Jam OT',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.warning,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Custom Legend Header
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildLegendIndicator(
                color: AppColors.primary,
                label: 'Jam Kerja Efektif',
              ),
              const SizedBox(width: 16),
              _buildLegendIndicator(
                color: AppColors.accent,
                label: 'Jam Lembur (OT)',
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Graphic Bars Display Container
          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: weeklyLogs.map((log) {
                final workBarHeight = (log.workHours / maxHours) * 110;
                final otBarHeight = (log.overtimeHours / maxHours) * 110;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Visual text value preview above bars
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${log.workHours.toInt()}h',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        if (log.overtimeHours > 0) ...[
                          const SizedBox(width: 4),
                          Text(
                            '+${log.overtimeHours.toInt()}h',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColors.accent,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Grouped Bars
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Work Hours Bar
                        Container(
                          width: 16,
                          height: workBarHeight,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(6),
                            ),
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.primary,
                                AppColors.primaryLight,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        // Overtime Hours Bar
                        Container(
                          width: 16,
                          height: otBarHeight > 4 ? otBarHeight : 4,
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(6),
                            ),
                            gradient: LinearGradient(
                              colors: [
                                AppColors.accent,
                                AppColors.accent.withValues(alpha: 0.6),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Week Label
                    Text(
                      log.weekLabel,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.inputBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 15,
                  color: AppColors.textSecondary,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Catatan: Target jam kerja standar teknis adalah 40 jam / minggu.',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendIndicator({required Color color, required String label}) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
