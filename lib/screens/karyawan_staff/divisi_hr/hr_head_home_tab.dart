import 'package:flutter/material.dart';
import '../../../models/user_model.dart';
import '../../../theme/app_colors.dart';
import '../widgets/donut_chart_widget.dart';
import '../widgets/bar_chart_widget.dart';
import 'modals/persetujuan_cuti_modal.dart';
import 'modals/manajemen_aset_ga_modal.dart';
import 'modals/evaluasi_kpi_modal.dart';
import 'modals/manajemen_rekrutmen_modal.dart';
import 'modals/kebijakan_dokumen_modal.dart';

class HrHeadHomeTab extends StatefulWidget {
  final UserModel user;
  final Function(int targetTab)? onNavigateTab;

  const HrHeadHomeTab({
    super.key,
    required this.user,
    this.onNavigateTab,
  });

  @override
  State<HrHeadHomeTab> createState() => _HrHeadHomeTabState();
}

class _HrHeadHomeTabState extends State<HrHeadHomeTab> {
  // 1. Diagram Lingkaran (Pie Chart) - Distribusi Status Kepegawaian & Turn Over
  final List<AttendanceDataItem> _employeeStatusDistribution = const [
    AttendanceDataItem(
      label: 'Karyawan Tetap (PKWTT)',
      value: 85,
      percentage: 60,
      color: Color(0xFF0F4C81),
    ),
    AttendanceDataItem(
      label: 'Karyawan Kontrak (PKWT)',
      value: 42,
      percentage: 30,
      color: Color(0xFF0284C7),
    ),
    AttendanceDataItem(
      label: 'Intern / Magang',
      value: 15,
      percentage: 10,
      color: Color(0xFF7C3AED),
    ),
  ];

  // 2. Diagram Batang (Bar Chart) - Evaluasi KPI per Departemen & Time-to-Hire
  final List<WeeklyWorkLog> _kpiAndHiringMetrics = const [
    WeeklyWorkLog(weekLabel: 'PT AMI (Holding)', workHours: 92, overtimeHours: 14),
    WeeklyWorkLog(weekLabel: 'PT GMT (Enterprise)', workHours: 95, overtimeHours: 21),
    WeeklyWorkLog(weekLabel: 'PT HGT (Commerce)', workHours: 90, overtimeHours: 18),
  ];

  void _openModal(Widget modalWidget) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => modalWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // A. Header: Identitas Akun Head of HR & GA (Djoko Kiswantoro)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0A3156),
                  Color(0xFF0F4C81),
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'EXECUTIVE HR & GA PORTAL',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'AMANI TECH GROUP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.military_tech_rounded, size: 14, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            'Head of Division',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Card Profil Djoko Kiswantoro
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 28,
                        backgroundColor: Color(0xFFE0F2FE),
                        child: Text(
                          'D',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F4C81),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.user.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Head of HR & GA (Human Resources & General Affairs)',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF0F4C81),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Holding & Subsidiaries Oversight (PT AMI, GMT, HGT)',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // A. Approval Center & Alert Reminders
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Pusat Persetujuan (Approval Center)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (widget.onNavigateTab != null) {
                          widget.onNavigateTab!(2); // Navigasi ke Tab Approval
                        }
                      },
                      child: const Text(
                        'Lihat Semua',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF0F4C81),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Approval Center Highlights
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFBAE6FD)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.assignment_turned_in_rounded, color: Color(0xFF0F4C81)),
                              SizedBox(width: 8),
                              Text(
                                'Pending Approval Manajerial',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF3C7),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              '4 Menunggu',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFB45309),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Persetujuan cuti C-Level/Manager, usulan rekrutmen engineer baru PT GMT, dan permohonan inventaris GA.',
                        style: TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _openModal(const PersetujuanCutiModal()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0F4C81),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Buka Panel Approval'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Alert & Reminders Card (Probation & Audit)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFBEB),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFFDE68A)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.notifications_active_rounded, color: Color(0xFFD97706), size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Alert & Reminders HR & GA',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF92400E),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '• 2 Evaluasi Probation (Masa Percobaan) jatuh tempo minggu ini.\n• Jadwal Audit K3 & Inventaris Office Holding: Jumat, 28 Maret.',
                              style: TextStyle(fontSize: 11, color: Color(0xFFB45309), height: 1.3),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // B. Grid Menu Strategis & GA (5 Middle Action Menu)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Menu Strategis & GA Manajerial',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.96,
                  children: [
                    _buildActionCard(
                      title: 'Persetujuan Cuti/Izin',
                      subtitle: 'Approval final',
                      icon: Icons.gavel_rounded,
                      color: const Color(0xFF0F4C81),
                      onTap: () => _openModal(const PersetujuanCutiModal()),
                    ),
                    _buildActionCard(
                      title: 'Manajemen Aset & GA',
                      subtitle: 'Laptop, IoT & Mobil',
                      icon: Icons.inventory_2_rounded,
                      color: const Color(0xFF0284C7),
                      onTap: () => _openModal(const ManajemenAsetGaModal()),
                    ),
                    _buildActionCard(
                      title: 'Evaluasi Performa (KPI)',
                      subtitle: 'Monitoring skor divisi',
                      icon: Icons.insights_rounded,
                      color: const Color(0xFF059669),
                      onTap: () => _openModal(const EvaluasiKpiModal()),
                    ),
                    _buildActionCard(
                      title: 'Manajemen Rekrutmen',
                      subtitle: 'Pipeline talent group',
                      icon: Icons.person_search_rounded,
                      color: const Color(0xFF7C3AED),
                      onTap: () => _openModal(const ManajemenRekrutmenModal()),
                    ),
                    _buildActionCard(
                      title: 'Kebijakan & SOP',
                      subtitle: 'Regulasi & Kontrak',
                      icon: Icons.policy_rounded,
                      color: const Color(0xFFD97706),
                      onTap: () => _openModal(const KebijakanDokumenModal()),
                    ),
                    _buildActionCard(
                      title: 'Presensi Real-Time',
                      subtitle: 'Monitoring disiplin',
                      icon: Icons.my_location_rounded,
                      color: const Color(0xFF475569),
                      onTap: () {
                        if (widget.onNavigateTab != null) {
                          widget.onNavigateTab!(1); // Attendance Monitoring
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // C. Visualisasi Data & Grafik
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Visualisasi Strategis SDM Group',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),

                // 1. Diagram Lingkaran (Pie Chart) - Distribusi Status Kepegawaian & Turn Over
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.cardBorder),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.pie_chart_rounded, color: Color(0xFF0F4C81), size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Distribusi Status Kepegawaian (PKWTT / PKWT / Intern)',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      AttendanceDonutChartWidget(data: _employeeStatusDistribution),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 2. Diagram Batang (Bar Chart) - Evaluasi KPI per Departemen & Time-to-Hire
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.cardBorder),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.bar_chart_rounded, color: Color(0xFF0284C7), size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Pencapaian KPI & Durasi Time-to-Hire (Hari)',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      WorkOvertimeBarChartWidget(weeklyLogs: _kpiAndHiringMetrics),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 1),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 9,
                color: AppColors.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
