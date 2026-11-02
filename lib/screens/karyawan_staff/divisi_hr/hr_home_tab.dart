import 'package:flutter/material.dart';
import '../../../models/user_model.dart';
import '../../../theme/app_colors.dart';
import '../widgets/donut_chart_widget.dart';
import '../widgets/payroll_bpjs_overview_widget.dart';
import '../widgets/employee_demographics_pie_widget.dart';
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
  // 1. Diagram Lingkaran (Pie/Donut Chart) - Visualisasi Kehadiran Real-Time Group (Hadir, Sakit, Izin, Terlambat, Cuti)
  final List<AttendanceDataItem> _dailyAttendanceStatus = const [
    AttendanceDataItem(
      label: 'Hadir',
      value: 275,
      percentage: 85,
      color: Color(0xFF10B981), // Emerald Green
    ),
    AttendanceDataItem(
      label: 'Sakit',
      value: 10,
      percentage: 3,
      color: Color(0xFFEF4444), // Red
    ),
    AttendanceDataItem(
      label: 'Izin',
      value: 12,
      percentage: 4,
      color: Color(0xFF0EA5E9), // Sky Blue
    ),
    AttendanceDataItem(
      label: 'Terlambat',
      value: 18,
      percentage: 6,
      color: Color(0xFFF59E0B), // Amber / Yellow
    ),
    AttendanceDataItem(
      label: 'Cuti',
      value: 10,
      percentage: 3,
      color: Color(0xFF8B5CF6), // Purple
    ),
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

          // A. Ringkasan Operasional Hari Ini (5 Kolom dengan Desain Gambar 2 + Icon Logo)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Ringkasan Operasional Hari Ini',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7C3AED).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.swipe_left_rounded, size: 13, color: Color(0xFF7C3AED)),
                      SizedBox(width: 4),
                      Text(
                        'Geser',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF7C3AED),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= 1050) {
                // Wide Desktop: 5 Kolom sejajar proporsional
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildOperationalCard(
                          title: 'Karyawan',
                          value: '325',
                          subtitle: 'Holding & Subsidiaries',
                          iconName: 'karyawan',
                          accentColor: const Color(0xFF2563EB),
                          onTap: () => _openModal(const DatabaseKaryawanModal()),
                          isResponsive: true,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildOperationalCard(
                          title: 'Departemen',
                          value: '12 Dept',
                          subtitle: '6 Divisi Grup',
                          iconName: 'departemen',
                          accentColor: const Color(0xFF0EA5E9),
                          onTap: () => _showDepartemenModal(context),
                          isResponsive: true,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildOperationalCard(
                          title: 'Total Payroll',
                          value: 'Rp 2,45 M',
                          subtitle: 'Gaji Bulan Berjalan',
                          iconName: 'payroll',
                          accentColor: const Color(0xFF10B981),
                          onTap: () => _showPayrollModal(context),
                          isResponsive: true,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildOperationalCard(
                          title: 'BPJS',
                          value: 'Rp 187,35 Jt',
                          subtitle: 'Kesehatan & Naker',
                          iconName: 'bpjs',
                          accentColor: const Color(0xFFF59E0B),
                          onTap: () => _showBpjsModal(context),
                          isResponsive: true,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildOperationalCard(
                          title: 'Total PPH 21',
                          value: 'Rp 245,18 Jt',
                          subtitle: 'Pajak Penghasilan',
                          iconName: 'pajak',
                          accentColor: const Color(0xFFDB2777),
                          onTap: () => _showPph21Modal(context),
                          isResponsive: true,
                        ),
                      ),
                    ],
                  ),
                );
              }

              // Mobile / Standard Window: Horizontal Scrollable Row (Sesuai Gambar 2)
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _buildOperationalCard(
                      title: 'Karyawan',
                      value: '325',
                      subtitle: 'Holding & Subsidiaries',
                      iconName: 'karyawan',
                      accentColor: const Color(0xFF2563EB),
                      onTap: () => _openModal(const DatabaseKaryawanModal()),
                    ),
                    const SizedBox(width: 12),
                    _buildOperationalCard(
                      title: 'Departemen',
                      value: '12 Dept',
                      subtitle: '6 Divisi Grup',
                      iconName: 'departemen',
                      accentColor: const Color(0xFF0EA5E9),
                      onTap: () => _showDepartemenModal(context),
                    ),
                    const SizedBox(width: 12),
                    _buildOperationalCard(
                      title: 'Total Payroll',
                      value: 'Rp 2,45 M',
                      subtitle: 'Gaji Bulan Berjalan',
                      iconName: 'payroll',
                      accentColor: const Color(0xFF10B981),
                      onTap: () => _showPayrollModal(context),
                    ),
                    const SizedBox(width: 12),
                    _buildOperationalCard(
                      title: 'BPJS',
                      value: 'Rp 187,35 Jt',
                      subtitle: 'Kesehatan & Naker',
                      iconName: 'bpjs',
                      accentColor: const Color(0xFFF59E0B),
                      onTap: () => _showBpjsModal(context),
                    ),
                    const SizedBox(width: 12),
                    _buildOperationalCard(
                      title: 'Total PPH 21',
                      value: 'Rp 245,18 Jt',
                      subtitle: 'Pajak Penghasilan',
                      iconName: 'pajak',
                      accentColor: const Color(0xFFDB2777),
                      onTap: () => _showPph21Modal(context),
                    ),
                  ],
                ),
              );
            },
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

                // 1. Diagram Lingkaran - Visualisasi Kehadiran Real-Time Group (Hadir, Sakit, Izin, Terlambat, Cuti)
                AttendanceDonutChartWidget(
                  title: 'Visualisasi Kehadiran Real-Time Group',
                  subtitle: 'Monitoring Kehadiran Seluruh Karyawan Group',
                  centerValue: '325',
                  centerUnit: 'Karyawan',
                  rateBadge: 'Rate: 85%',
                  headerIcon: Icons.groups_rounded,
                  headerColor: const Color(0xFF7C3AED),
                  data: _dailyAttendanceStatus,
                ),
                const SizedBox(height: 20),

                // 2. Overview Payroll & BPJS (Gambar 2: Payroll Bar Chart + BPJS Donut Chart)
                const PayrollBpjsOverviewWidget(),
                const SizedBox(height: 20),

                // 3. Demografi Karyawan (Gambar 3: Gender, Age Group, Education, Type Status dari Live Database)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Demografi & Komposisi Karyawan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2563EB).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.sync_rounded, size: 12, color: Color(0xFF2563EB)),
                          SizedBox(width: 4),
                          Text(
                            'Live Database',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2563EB),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const EmployeeDemographicsPieWidget(),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildOperationalCard({
    required String title,
    required String value,
    required String subtitle,
    required String iconName,
    required Color accentColor,
    VoidCallback? onTap,
    bool isResponsive = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: isResponsive ? null : 210,
          height: 86,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Left vertical indicator bar (matching Gambar 2)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                ),
              ),
              // Content inside card
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF64748B),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            value,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                              color: accentColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    // Icon Logo (lib/icons / asset/icons)
                    Container(
                      width: 36,
                      height: 36,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _buildCardIcon(iconName, accentColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardIcon(String iconName, Color color) {
    return Image.asset(
      'asset/icons/icon_$iconName.png',
      width: 26,
      height: 26,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'asset/icons/$iconName.png',
          width: 26,
          height: 26,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'lib/icons/$iconName.png',
              width: 26,
              height: 26,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.circle, color: color, size: 22);
              },
            );
          },
        );
      },
    );
  }

  void _showDepartemenModal(BuildContext context) {
    final depts = [
      {'name': 'Human Resources & GA', 'comp': 'PT AMI (Holding)', 'count': '18 Karyawan', 'color': const Color(0xFF7C3AED)},
      {'name': 'Finance & Accounting', 'comp': 'PT AMI (Holding)', 'count': '14 Karyawan', 'color': const Color(0xFF059669)},
      {'name': 'Executive Board & Legal', 'comp': 'PT AMI (Holding)', 'count': '6 Karyawan', 'color': const Color(0xFF0F4C81)},
      {'name': 'IoT & Hardware Engineering', 'comp': 'PT GMT', 'count': '42 Karyawan', 'color': const Color(0xFF0284C7)},
      {'name': 'AI & Data Solutions', 'comp': 'PT GMT', 'count': '38 Karyawan', 'color': const Color(0xFF2563EB)},
      {'name': 'Civil Works & Field Ops', 'comp': 'PT GMT', 'count': '65 Karyawan', 'color': const Color(0xFFD97706)},
      {'name': 'Enterprise Customer Account', 'comp': 'PT GMT', 'count': '22 Karyawan', 'color': const Color(0xFF4F46E5)},
      {'name': 'Digital Marketing & Ads', 'comp': 'PT HGT', 'count': '35 Karyawan', 'color': const Color(0xFFEC4899)},
      {'name': 'Media & Production', 'comp': 'PT HGT', 'count': '28 Karyawan', 'color': const Color(0xFF8B5CF6)},
      {'name': 'Content Talents & Creator', 'comp': 'PT HGT', 'count': '32 Karyawan', 'color': const Color(0xFFF43F5E)},
      {'name': 'Software Development', 'comp': 'PT HGT', 'count': '15 Karyawan', 'color': const Color(0xFF10B981)},
      {'name': 'Logistics & Support', 'comp': 'Holding & Sub', 'count': '10 Karyawan', 'color': const Color(0xFF64748B)},
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0EA5E9).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _buildCardIcon('departemen', const Color(0xFF0EA5E9)),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '12 Departemen & Divisi',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                      Text(
                        'Struktur Organisasi AMANI Tech Group',
                        style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: depts.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, idx) {
                  final d = depts[idx];
                  final c = d['color'] as Color;
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: c.withValues(alpha: 0.15),
                          child: Text(
                            '${idx + 1}',
                            style: TextStyle(color: c, fontWeight: FontWeight.bold, fontSize: 11),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                d['name'] as String,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              Text(
                                d['comp'] as String,
                                style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: c.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            d['count'] as String,
                            style: TextStyle(color: c, fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPayrollModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _buildCardIcon('payroll', const Color(0xFF10B981)),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ringkasan Total Payroll',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                      Text(
                        'Periode Berjalan AMANI Tech Group',
                        style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFBBF7D0)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Pengeluaran Gaji:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  Text('Rp 2.450.000.000', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF059669))),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _buildDetailRow('Gaji Pokok & Tunjangan Tetap', 'Rp 1.850.000.000'),
            _buildDetailRow('Tunjangan Lembur & Operasional', 'Rp 260.000.000'),
            _buildDetailRow('Insentif & Bonus Kinerja', 'Rp 340.000.000'),
            _buildDetailRow('Total Karyawan Terbayar', '325 Karyawan'),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showBpjsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _buildCardIcon('bpjs', const Color(0xFFF59E0B)),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ringkasan Iuran BPJS',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                      Text(
                        'BPJS Ketenagakerjaan & Kesehatan',
                        style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBEB),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFFDE68A)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Iuran BPJS:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  Text('Rp 187.350.000', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFFD97706))),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _buildDetailRow('BPJS Ketenagakerjaan (JKK, JKM, JHT, JP)', 'Rp 112.500.000'),
            _buildDetailRow('BPJS Kesehatan (4% Perusahaan, 1% Karyawan)', 'Rp 74.850.000'),
            _buildDetailRow('Total Tenaga Kerja Terdaftar', '325 Peserta Aktif'),
            _buildDetailRow('Status Sinkronisasi SIPP & Edabu', 'Tervalidasi 100%'),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showPph21Modal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDB2777).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _buildCardIcon('pajak', const Color(0xFFDB2777)),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ringkasan Total PPH 21',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                      Text(
                        'Pajak Penghasilan Karyawan Group',
                        style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFDF2F8),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFFBCFE8)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Setoran PPh 21:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  Text('Rp 245.180.000', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFFBE185D))),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _buildDetailRow('PPh 21 Karyawan Tetap (PKWTT)', 'Rp 185.600.000'),
            _buildDetailRow('PPh 21 Karyawan Kontrak & PKWT', 'Rp 42.180.000'),
            _buildDetailRow('PPh 21 Tenaga Ahli / Konsultan', 'Rp 17.400.000'),
            _buildDetailRow('Status e-Billing DJP', 'Kode Billing Diterbitkan'),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  static Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
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
