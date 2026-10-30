import 'package:flutter/material.dart';
import '../../../models/user_model.dart';
import '../../../theme/app_colors.dart';
import '../widgets/donut_chart_widget.dart';
import '../widgets/bar_chart_widget.dart';
import 'modals/validasi_kehadiran_modal.dart';
import 'modals/database_karyawan_modal.dart';
import 'modals/rekapitulasi_absensi_modal.dart';
import 'modals/pengumuman_broadcast_modal.dart';
import 'modals/verifikasi_cuti_modal.dart';

class HrHomeTab extends StatefulWidget {
  final UserModel user;
  final Function(int targetTab)? onNavigateTab;

  const HrHomeTab({
    super.key,
    required this.user,
    this.onNavigateTab,
  });

  @override
  State<HrHomeTab> createState() => _HrHomeTabState();
}

class _HrHomeTabState extends State<HrHomeTab> {
  // 1. Diagram Lingkaran (Pie Chart) - Persentase Kehadiran Harian Seluruh Karyawan
  final List<AttendanceDataItem> _dailyAttendanceStatus = const [
    AttendanceDataItem(
      label: 'Hadir Tepat Waktu',
      value: 121,
      percentage: 85,
      color: AppColors.success,
    ),
    AttendanceDataItem(
      label: 'Terlambat Hadir',
      value: 11,
      percentage: 8,
      color: AppColors.warning,
    ),
    AttendanceDataItem(
      label: 'Cuti / Izin Resmi',
      value: 7,
      percentage: 5,
      color: Color(0xFF0284C7),
    ),
    AttendanceDataItem(
      label: 'Alpa / Tanpa Ket.',
      value: 3,
      percentage: 2,
      color: AppColors.error,
    ),
  ];

  // 2. Diagram Batang (Bar Chart) - Tren Keterlambatan per Divisi & Anak Perusahaan
  final List<WeeklyWorkLog> _tardinessTrendPerDivision = const [
    WeeklyWorkLog(weekLabel: 'PT AMI (Hold)', workHours: 2, overtimeHours: 0),
    WeeklyWorkLog(weekLabel: 'PT GMT (IoT)', workHours: 5, overtimeHours: 1),
    WeeklyWorkLog(weekLabel: 'PT HGT (Com)', workHours: 3, overtimeHours: 1),
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
          // A. Header: Identitas Akun Staff HR (Mia Aulia)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF5B21B6), // Purple 800
                  Color(0xFF7C3AED), // Purple 600
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
                          'OPERATIONAL HR & GA DASHBOARD',
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
                          Icon(Icons.verified_user_rounded, size: 14, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            'Operational HR',
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

                // Card Profil Mia Aulia
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 28,
                        backgroundColor: Color(0xFFEDE9FE),
                        child: Text(
                          'M',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6D28D9),
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
                              'Staff Administrasi Umum | HR & GA Division',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF6D28D9),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Atasan: Djoko Kiswantoro (Head of HR & GA)',
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

          // A. Statistik Cepat (4 Top Cards)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ringkasan Operasional Hari Ini',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricCard(
                        title: 'Total Karyawan Aktif',
                        value: '142',
                        subtitle: 'Holding & Subsidiaries',
                        icon: Icons.groups_rounded,
                        color: const Color(0xFF7C3AED),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildMetricCard(
                        title: 'Pengajuan Cuti/Izin',
                        value: '8 Pending',
                        subtitle: 'Butuh Verifikasi',
                        icon: Icons.pending_actions_rounded,
                        color: AppColors.warning,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricCard(
                        title: 'Terlambat / Absen',
                        value: '5 T / 2 A',
                        subtitle: 'Hari ini di seluruh grup',
                        icon: Icons.alarm_off_rounded,
                        color: AppColors.error,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildMetricCard(
                        title: 'Kontrak Hampir Habis',
                        value: '3 Kontrak',
                        subtitle: 'Expiry Alert (<30 Hari)',
                        icon: Icons.hourglass_bottom_rounded,
                        color: const Color(0xFFD97706),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // B. Grid Menu Operasional (5 Middle Action Menu)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Menu Operasional HR & GA',
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
                      title: 'Validasi Kehadiran',
                      subtitle: 'GPS error & clock-out',
                      icon: Icons.verified_user_rounded,
                      color: const Color(0xFF7C3AED),
                      onTap: () => _openModal(const ValidasiKehadiranModal()),
                    ),
                    _buildActionCard(
                      title: 'Verifikasi Cuti & Izin',
                      subtitle: 'Cek kelengkapan berkas',
                      icon: Icons.event_note_rounded,
                      color: const Color(0xFF0284C7),
                      onTap: () {
                        if (widget.onNavigateTab != null) {
                          widget.onNavigateTab!(2); // Tab verifikasi cuti
                        } else {
                          _openModal(
                            const VerifikasiCutiModal(
                              leaveData: {
                                'employee': 'M. Jumi\'at Mochtar',
                                'nik': 'GMT-003',
                                'position': 'IoT Engineer',
                                'company': 'PT Global Moviion Teknologi',
                                'type': 'Cuti Tahunan',
                                'dates': '12 Mar 2025 - 14 Mar 2025',
                                'duration': '3',
                                'remainingLeave': '10 Hari',
                                'reason': 'Keperluan keluarga di luar kota dan perbaikan perangkat rumah.',
                                'status': 'Pending Staff Review',
                              },
                            ),
                          );
                        }
                      },
                    ),
                    _buildActionCard(
                      title: 'Database Karyawan',
                      subtitle: 'Data master group',
                      icon: Icons.badge_rounded,
                      color: const Color(0xFF059669),
                      onTap: () => _openModal(const DatabaseKaryawanModal()),
                    ),
                    _buildActionCard(
                      title: 'Rekapitulasi Absensi',
                      subtitle: 'Ekspor Excel / PDF',
                      icon: Icons.assessment_rounded,
                      color: const Color(0xFFD97706),
                      onTap: () => _openModal(const RekapitulasiAbsensiModal()),
                    ),
                    _buildActionCard(
                      title: 'Pengumuman (Broadcast)',
                      subtitle: 'Kirim info ke staf',
                      icon: Icons.campaign_rounded,
                      color: const Color(0xFFDC2626),
                      onTap: () => _openModal(const PengumumanBroadcastModal()),
                    ),
                    _buildActionCard(
                      title: 'Peta Presensi',
                      subtitle: 'Live GPS monitor',
                      icon: Icons.location_on_rounded,
                      color: const Color(0xFF475569),
                      onTap: () {
                        if (widget.onNavigateTab != null) {
                          widget.onNavigateTab!(1); // Tab Attendance Monitoring
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
                  'Visualisasi & Analisis Kedisiplinan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),

                // 1. Diagram Lingkaran - Persentase Kehadiran Harian Seluruh Karyawan
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
                          Icon(Icons.pie_chart_rounded, color: Color(0xFF7C3AED), size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Persentase Kehadiran Real-Time Group',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      AttendanceDonutChartWidget(data: _dailyAttendanceStatus),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 2. Diagram Batang - Tren Keterlambatan per Divisi (Holding, GMT, HGT)
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
                          Icon(Icons.bar_chart_rounded, color: Color(0xFFD97706), size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Tren Keterlambatan per Entitas / Divisi',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      WorkOvertimeBarChartWidget(weeklyLogs: _tardinessTrendPerDivision),
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

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(icon, color: color, size: 20),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
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
