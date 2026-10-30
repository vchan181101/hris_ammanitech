import 'package:flutter/material.dart';
import '../../../models/user_model.dart';
import '../../../theme/app_colors.dart';
import '../widgets/donut_chart_widget.dart';
import '../widgets/bar_chart_widget.dart';
import 'modals/kalkulasi_payroll_modal.dart';
import 'modals/kas_operasional_modal.dart';
import 'modals/riwayat_pembayaran_modal.dart';
import 'modals/laporan_keuangan_hr_modal.dart';

class FinanceHomeTab extends StatefulWidget {
  final UserModel user;
  final Function(int targetTab)? onNavigateTab;

  const FinanceHomeTab({
    super.key,
    required this.user,
    this.onNavigateTab,
  });

  @override
  State<FinanceHomeTab> createState() => _FinanceHomeTabState();
}

class _FinanceHomeTabState extends State<FinanceHomeTab> {
  // 1. Diagram Lingkaran (Pie Chart) - Komposisi Pengeluaran Klaim Bulan Ini
  final List<AttendanceDataItem> _claimCompositionData = const [
    AttendanceDataItem(
      label: 'Perjalanan Dinas',
      value: 45,
      percentage: 45,
      color: Color(0xFF059669),
    ),
    AttendanceDataItem(
      label: 'Operasional Site / Proyek',
      value: 25,
      percentage: 25,
      color: Color(0xFF0284C7),
    ),
    AttendanceDataItem(
      label: 'Kesehatan / Medis',
      value: 20,
      percentage: 20,
      color: Color(0xFF7C3AED),
    ),
    AttendanceDataItem(
      label: 'Lain-lain',
      value: 10,
      percentage: 10,
      color: Color(0xFFF59E0B),
    ),
  ];

  // 2. Diagram Batang (Bar Chart) - Realisasi Pengeluaran Klaim per Minggu (W1 - W4)
  final List<WeeklyWorkLog> _weeklyClaimExpenses = const [
    WeeklyWorkLog(weekLabel: 'W1 (1-7 Mar)', workHours: 3.2, overtimeHours: 1.0),
    WeeklyWorkLog(weekLabel: 'W2 (8-14 Mar)', workHours: 4.5, overtimeHours: 1.5),
    WeeklyWorkLog(weekLabel: 'W3 (15-21 Mar)', workHours: 5.1, overtimeHours: 2.0),
    WeeklyWorkLog(weekLabel: 'W4 (22-28 Mar)', workHours: 2.0, overtimeHours: 0.5),
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
          // A. Header: Identitas Akun Staff Finance (Anggun Silvia)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF065F46), // Emerald 800
                  Color(0xFF059669), // Emerald 600
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
                          'FINANCIAL OPERATIONS DASHBOARD',
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
                          Icon(Icons.account_balance_rounded, size: 14, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            'Finance Staff',
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

                // Card Profil Anggun Silvia
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
                        backgroundColor: Color(0xFFD1FAE5),
                        child: Text(
                          'A',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF059669),
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
                              'Staff Finance | Finance Division',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF059669),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Atasan: Bachtiar Siagian (Head of Finance)',
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
                  'Ringkasan Keuangan Operasional',
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
                        title: 'Pengajuan Klaim',
                        value: '6 Pengajuan',
                        subtitle: 'Pending Verifikasi',
                        icon: Icons.receipt_long_rounded,
                        color: const Color(0xFF059669),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildMetricCard(
                        title: 'Nominal Klaim Bulan Ini',
                        value: 'Rp 14.850.000',
                        subtitle: 'Total pengajuan',
                        icon: Icons.monetization_on_rounded,
                        color: const Color(0xFF0284C7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricCard(
                        title: 'Kesiapan Payroll',
                        value: '78% Selesai',
                        subtitle: 'Siap Validasi HR/Fin',
                        icon: Icons.checklist_rtl_rounded,
                        color: const Color(0xFF7C3AED),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildMetricCard(
                        title: 'Nota / Advance Cash',
                        value: '2 Nota Pending',
                        subtitle: 'Perlu SPJ Lapangan',
                        icon: Icons.pending_actions_rounded,
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
                  'Menu Operasional Finance',
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
                      title: 'Verifikasi Klaim',
                      subtitle: 'Cek nota & bukti struk',
                      icon: Icons.fact_check_rounded,
                      color: const Color(0xFF059669),
                      onTap: () {
                        if (widget.onNavigateTab != null) {
                          widget.onNavigateTab!(1); // Tab Claims
                        }
                      },
                    ),
                    _buildActionCard(
                      title: 'Kalkulasi Payroll',
                      subtitle: 'Pajak PPh21 & BPJS',
                      icon: Icons.calculate_rounded,
                      color: const Color(0xFF0284C7),
                      onTap: () => _openModal(const KalkulasiPayrollModal()),
                    ),
                    _buildActionCard(
                      title: 'Kas Operasional',
                      subtitle: 'Site & Civil Works',
                      icon: Icons.account_balance_wallet_rounded,
                      color: const Color(0xFFD97706),
                      onTap: () => _openModal(const KasOperasionalModal()),
                    ),
                    _buildActionCard(
                      title: 'Riwayat Transfer',
                      subtitle: 'Gaji & klaim disetujui',
                      icon: Icons.receipt_long_rounded,
                      color: const Color(0xFF7C3AED),
                      onTap: () => _openModal(const RiwayatPembayaranModal()),
                    ),
                    _buildActionCard(
                      title: 'Laporan Keuangan',
                      subtitle: 'Ekspor Excel / PDF',
                      icon: Icons.file_download_rounded,
                      color: const Color(0xFFDC2626),
                      onTap: () => _openModal(const LaporanKeuanganHrModal()),
                    ),
                    _buildActionCard(
                      title: 'Inbox & Notifikasi',
                      subtitle: 'Pengajuan baru',
                      icon: Icons.mail_outline_rounded,
                      color: const Color(0xFF475569),
                      onTap: () {
                        if (widget.onNavigateTab != null) {
                          widget.onNavigateTab!(3); // Tab Inbox
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
                  'Visualisasi & Analisis Biaya Operasional',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),

                // 1. Diagram Lingkaran - Komposisi Pengeluaran Klaim Bulan Ini
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
                          Icon(Icons.pie_chart_rounded, color: Color(0xFF059669), size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Komposisi Pengeluaran Klaim Bulan Ini',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      AttendanceDonutChartWidget(data: _claimCompositionData),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 2. Diagram Batang - Realisasi Pengeluaran Klaim per Minggu (W1 - W4)
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
                            'Realisasi Pengeluaran Klaim per Minggu (Juta Rp)',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      WorkOvertimeBarChartWidget(weeklyLogs: _weeklyClaimExpenses),
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
              fontSize: 15,
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
