import 'package:flutter/material.dart';
import '../../../models/user_model.dart';
import '../../../theme/app_colors.dart';
import '../widgets/donut_chart_widget.dart';
import '../widgets/bar_chart_widget.dart';
import 'modals/persetujuan_klaim_modal.dart';
import 'modals/persetujuan_payroll_modal.dart';
import 'modals/budget_control_modal.dart';
import 'modals/audit_keuangan_modal.dart';
import 'modals/ringkasan_pajak_bpjs_modal.dart';

class FinanceHeadHomeTab extends StatefulWidget {
  final UserModel user;
  final Function(int targetTab)? onNavigateTab;

  const FinanceHeadHomeTab({
    super.key,
    required this.user,
    this.onNavigateTab,
  });

  @override
  State<FinanceHeadHomeTab> createState() => _FinanceHeadHomeTabState();
}

class _FinanceHeadHomeTabState extends State<FinanceHeadHomeTab> {
  // 1. Diagram Lingkaran (Pie Chart) - Distribusi Beban Gaji & Operasional Entitas
  final List<AttendanceDataItem> _entityExpenseDistribution = const [
    AttendanceDataItem(
      label: 'PT Global Moviion Teknologi',
      value: 40,
      percentage: 40,
      color: Color(0xFF047857),
    ),
    AttendanceDataItem(
      label: 'PT Aman Media Interaktif (Holding)',
      value: 35,
      percentage: 35,
      color: Color(0xFF0284C7),
    ),
    AttendanceDataItem(
      label: 'PT Hanasta Global Teknologi',
      value: 25,
      percentage: 25,
      color: Color(0xFF7C3AED),
    ),
  ];

  // 2. Diagram Batang (Bar Chart) - Perbandingan Budget vs Realisasi Pengeluaran per Divisi
  final List<WeeklyWorkLog> _budgetVsActualData = const [
    WeeklyWorkLog(weekLabel: 'Div Finance', workHours: 40, overtimeHours: 32),
    WeeklyWorkLog(weekLabel: 'Div HR & GA', workHours: 45, overtimeHours: 41),
    WeeklyWorkLog(weekLabel: 'Enterprise GMT', workHours: 80, overtimeHours: 74),
    WeeklyWorkLog(weekLabel: 'Commerce HGT', workHours: 55, overtimeHours: 42),
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
          // A. Header: Identitas Akun Head of Finance (Bachtiar Siagian)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF064E3B), // Emerald 900
                  Color(0xFF047857), // Emerald 700
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
                          'STRATEGIC FINANCE & APPROVAL PORTAL',
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
                          Icon(Icons.shield_rounded, size: 14, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            'Head of Finance',
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

                // Card Profil Bachtiar Siagian
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
                        backgroundColor: Color(0xFFD1FAE5),
                        child: Text(
                          'B',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF047857),
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
                              'Head of Finance | Finance & Accounting Division',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF047857),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Budget Control & Cashflow Oversight (Holding & Subsidiaries)',
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
                      'Pusat Persetujuan Finance (Approval Center)',
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
                        'Lihat Antrean',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF047857),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Approval Center Box
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFA7F3D0)),
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
                              Icon(Icons.verified_rounded, color: Color(0xFF047857)),
                              SizedBox(width: 8),
                              Text(
                                'Pending Approval Pencairan Dana',
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
                              '3 Klaim Menunggu',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFB45309),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Verifikasi akhir klaim sensor IoT (M. Jumi\'at), cloud GPU AI (M Erlan), dan validasi pencairan payroll Maret 2025.',
                        style: TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => _openModal(const PersetujuanPayrollModal()),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFF047857)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              child: const Text('Payroll Grup', style: TextStyle(color: Color(0xFF047857), fontSize: 12)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => _openModal(const PersetujuanKlaimModal()),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF047857),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              child: const Text('Approve Klaim', style: TextStyle(fontSize: 12)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Alert & Reminders Card (Budget Over-limit & Tax/BPJS)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFBEB),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFFDE68A)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: Color(0xFFD97706), size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Alert & Reminders Finance',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF92400E),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '• Budget Alert: Anggaran PT Global Moviion telah terpakai 90% (Sisa Rp 60 Jt).\n• Pajak & BPJS: Batas akhir pelaporan PPh 21 jatuh tempo 10 April 2025.',
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

          // B. Grid Menu Strategis (5 Middle Action Menu)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Menu Strategis & Pengawasan Finance',
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
                      title: 'Persetujuan Klaim',
                      subtitle: 'Approve / reject klaim',
                      icon: Icons.gavel_rounded,
                      color: const Color(0xFF047857),
                      onTap: () => _openModal(const PersetujuanKlaimModal()),
                    ),
                    _buildActionCard(
                      title: 'Persetujuan Payroll',
                      subtitle: 'Validasi gaji grup',
                      icon: Icons.payments_rounded,
                      color: const Color(0xFF0284C7),
                      onTap: () => _openModal(const PersetujuanPayrollModal()),
                    ),
                    _buildActionCard(
                      title: 'Budget Control',
                      subtitle: 'Sisa anggaran entitas',
                      icon: Icons.pie_chart_outline_rounded,
                      color: const Color(0xFFD97706),
                      onTap: () => _openModal(const BudgetControlModal()),
                    ),
                    _buildActionCard(
                      title: 'Audit Keuangan HR',
                      subtitle: 'Histori transaksi grup',
                      icon: Icons.policy_rounded,
                      color: const Color(0xFF7C3AED),
                      onTap: () => _openModal(const AuditKeuanganModal()),
                    ),
                    _buildActionCard(
                      title: 'Pajak & BPJS',
                      subtitle: 'Kepatuhan PPh21/BPJS',
                      icon: Icons.account_balance_rounded,
                      color: const Color(0xFFDC2626),
                      onTap: () => _openModal(const RingkasanPajakBpjsModal()),
                    ),
                    _buildActionCard(
                      title: 'Claims Queue',
                      subtitle: 'Daftar nota masuk',
                      icon: Icons.receipt_long_rounded,
                      color: const Color(0xFF475569),
                      onTap: () {
                        if (widget.onNavigateTab != null) {
                          widget.onNavigateTab!(1); // Claims & Audit
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
                  'Visualisasi Keuangan & Alokasi Anggaran',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),

                // 1. Diagram Lingkaran - Distribusi Beban Gaji & Operasional Entitas
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
                          Icon(Icons.pie_chart_rounded, color: Color(0xFF047857), size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Distribusi Beban Gaji & Operasional Entitas',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      AttendanceDonutChartWidget(data: _entityExpenseDistribution),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 2. Diagram Batang - Perbandingan Budget vs Realisasi Pengeluaran per Divisi
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
                            'Budget (Biru) vs Realisasi Pengeluaran (Oranye) per Divisi (Juta Rp)',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      WorkOvertimeBarChartWidget(weeklyLogs: _budgetVsActualData),
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
