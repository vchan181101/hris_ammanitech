import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../theme/app_colors.dart';
import 'widgets/donut_chart_widget.dart';
import 'widgets/bar_chart_widget.dart';
import 'modals/clock_in_out_modal.dart';
import 'modals/cuti_izin_modal.dart';
import 'modals/reimbursement_modal.dart';
import 'modals/payslip_modal.dart';
import 'modals/log_aktivitas_modal.dart';
import 'modals/jadwal_shift_modal.dart';

class EssHomeTab extends StatefulWidget {
  final UserModel user;

  const EssHomeTab({super.key, required this.user});

  @override
  State<EssHomeTab> createState() => _EssHomeTabState();
}

class _EssHomeTabState extends State<EssHomeTab> {
  bool _isClockedIn = true;
  String _clockInTime = '08:30 WIB';
  String _clockOutTime = '--:-- WIB';

  // Sample data for Donut Chart (Rekap Kehadiran Saya)
  final List<AttendanceDataItem> _attendanceData = const [
    AttendanceDataItem(
      label: 'Tepat Waktu',
      value: 16,
      percentage: 80,
      color: AppColors.success,
    ),
    AttendanceDataItem(
      label: 'Terlambat',
      value: 2,
      percentage: 10,
      color: AppColors.warning,
    ),
    AttendanceDataItem(
      label: 'Cuti / Izin',
      value: 1,
      percentage: 5,
      color: Colors.blue,
    ),
    AttendanceDataItem(
      label: 'Alpa / Tanpa Ket.',
      value: 1,
      percentage: 5,
      color: AppColors.error,
    ),
  ];

  // Sample data for Bar Chart (Log Jam Kerja & Lembur Bulanan)
  final List<WeeklyWorkLog> _weeklyWorkLogs = const [
    WeeklyWorkLog(weekLabel: 'Minggu 1', workHours: 40, overtimeHours: 5),
    WeeklyWorkLog(weekLabel: 'Minggu 2', workHours: 42, overtimeHours: 8),
    WeeklyWorkLog(weekLabel: 'Minggu 3', workHours: 38, overtimeHours: 3),
    WeeklyWorkLog(weekLabel: 'Minggu 4', workHours: 40, overtimeHours: 6),
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
        children: [
          // 1A. Header & Informasi Karyawan
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primaryDark,
                  AppColors.primary,
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
                // Top Branding Bar & Status Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'EMPLOYEE SELF-SERVICE (ESS)',
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
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.greenAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.user.role,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Card Profil Ringkas Karyawan
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
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundColor: AppColors.accentLight,
                            child: Text(
                              widget.user.name.isNotEmpty
                                  ? widget.user.name[0]
                                  : 'E',
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: const BoxDecoration(
                                  color: AppColors.success,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ],
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
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${widget.user.position} | NIK: ${widget.user.nik}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 3),
                            Text(
                              widget.user.company,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
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

          const SizedBox(height: 16),

          // 1A. Kartu Status Presensi Harian (Interactive)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _isClockedIn
                      ? [const Color(0xFF0F4C81), const Color(0xFF0284C7)]
                      : [const Color(0xFF475569), const Color(0xFF334155)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _isClockedIn ? Icons.access_time_filled : Icons.access_time,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _isClockedIn
                                ? 'Status: Sudah Jam Kerja (Hadir)'
                                : 'Status: Belum Presensi Clock In',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _isClockedIn ? Colors.lightGreenAccent : Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _isClockedIn ? 'Hadir Tepat Waktu' : 'Belum Masuk',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white24, height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Jam Masuk',
                            style: TextStyle(color: Colors.white70, fontSize: 11),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _clockInTime,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 30,
                        width: 1,
                        color: Colors.white24,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Jam Keluar',
                            style: TextStyle(color: Colors.white70, fontSize: 11),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _clockOutTime,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          _openModal(
                            ClockInOutModal(
                              user: widget.user,
                              isClockedIn: _isClockedIn,
                              onStatusChanged: (newStatus) {
                                setState(() {
                                  _isClockedIn = newStatus;
                                  if (!newStatus) {
                                    _clockOutTime = '17:30 WIB';
                                  } else {
                                    _clockOutTime = '--:-- WIB';
                                  }
                                });
                              },
                            ),
                          );
                        },
                        icon: Icon(
                          _isClockedIn ? Icons.logout : Icons.login,
                          size: 16,
                        ),
                        label: Text(_isClockedIn ? 'Clock Out' : 'Clock In'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: _isClockedIn ? AppColors.error : AppColors.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Real-time GPS Geofence Badge
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.my_location_rounded,
                          color: Colors.greenAccent,
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Lokasi GPS: Cyber 2 Tower - Akurasi 5m (In Geofence Zone)',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // 1B. Grid Menu Cepat (Middle Action Menu)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Menu Akses Cepat ESS',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      '6 Layanan Utama',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 1.05,
                  children: [
                    _buildGridMenuItem(
                      title: 'Clock In / Out',
                      subtitle: 'Selfie & GPS',
                      icon: Icons.touch_app_rounded,
                      color: const Color(0xFF0F4C81),
                      onTap: () {
                        _openModal(
                          ClockInOutModal(
                            user: widget.user,
                            isClockedIn: _isClockedIn,
                            onStatusChanged: (newStatus) {
                              setState(() {
                                _isClockedIn = newStatus;
                                if (!newStatus) {
                                  _clockOutTime = '17:30 WIB';
                                } else {
                                  _clockOutTime = '--:-- WIB';
                                }
                              });
                            },
                          ),
                        );
                      },
                    ),
                    _buildGridMenuItem(
                      title: 'Pengajuan Cuti/Izin',
                      subtitle: 'Form Tahunan/Sakit',
                      icon: Icons.event_note_rounded,
                      color: const Color(0xFF0284C7),
                      onTap: () {
                        _openModal(const CutiIzinModal());
                      },
                    ),
                    _buildGridMenuItem(
                      title: 'Klaim Reimburse',
                      subtitle: 'Nota & Struk',
                      icon: Icons.receipt_long_rounded,
                      color: const Color(0xFF059669),
                      onTap: () {
                        _openModal(const ReimbursementModal());
                      },
                    ),
                    _buildGridMenuItem(
                      title: 'Slip Gaji (Payslip)',
                      subtitle: 'Secure PIN/Biometrik',
                      icon: Icons.account_balance_wallet_rounded,
                      color: const Color(0xFF7C3AED),
                      onTap: () {
                        _openModal(PayslipModal(user: widget.user));
                      },
                    ),
                    _buildGridMenuItem(
                      title: 'Log Aktivitas / Task',
                      subtitle: 'IoT/AI/CS/Civil',
                      icon: Icons.task_alt_rounded,
                      color: const Color(0xFFD97706),
                      onTap: () {
                        _openModal(LogAktivitasModal(user: widget.user));
                      },
                    ),
                    _buildGridMenuItem(
                      title: 'Jadwal & Shift',
                      subtitle: 'Kalender Kerja',
                      icon: Icons.calendar_month_rounded,
                      color: const Color(0xFFDC2626),
                      onTap: () {
                        _openModal(JadwalShiftModal(user: widget.user));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 2. Grafik & Visualisasi Data (ESS Dashboard)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dashboard Analitik ESS Saya',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 14),

                // 2A. Diagram Lingkaran (Donut Chart) - Rekap Kehadiran Saya
                AttendanceDonutChartWidget(data: _attendanceData),

                const SizedBox(height: 20),

                // 2B. Diagram Batang (Bar Chart) - Log Jam Kerja & Lembur Bulanan
                WorkOvertimeBarChartWidget(weeklyLogs: _weeklyWorkLogs),
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildGridMenuItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
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
            const SizedBox(height: 2),
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
