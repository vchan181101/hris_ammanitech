import 'package:flutter/material.dart';
import '../../../../models/user_model.dart';
import '../../../../theme/app_colors.dart';
import 'modals/hgt_subsidiary_monitor_modal.dart';
import 'modals/cs_operations_sla_modal.dart';
import 'modals/commerce_executive_approval_modal.dart';
import 'modals/shift_on_call_schedule_modal.dart';
import 'modals/commerce_analytics_modal.dart';
import '../enterprise_solution/modals/reports_export_modal.dart';

class ChiefCommerceHomeTab extends StatelessWidget {
  final UserModel user;
  final Function(int)? onNavigateTab;

  const ChiefCommerceHomeTab({
    super.key,
    required this.user,
    this.onNavigateTab,
  });

  void _openModal(BuildContext context, Widget modal) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: modal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 600));
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // A. Header Identitas
            _buildExecutiveHeader(),
            const SizedBox(height: 18),

            // Top Cards (Statistik Cepat)
            _buildTopStatsGrid(context),
            const SizedBox(height: 20),

            // Banner Status SLA Platform
            _buildPlatformStatusBanner(context),
            const SizedBox(height: 20),

            // B. Grid Menu Utama (Middle Action Menu)
            const Text(
              'Menu Pengawasan Digital Commerce',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            _buildActionMenuGrid(context),
            const SizedBox(height: 24),

            // C. Visualisasi Data & Grafik
            const Text(
              'Metrik Tiket & Ketersediaan Sistem',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),

            // Pie Chart: Status Tiket Support & Penanganan CS
            _buildSupportTicketPieCard(),
            const SizedBox(height: 16),

            // Bar Chart: Tren Response Time & Uptime Infrastruktur
            _buildSlaResponseBarCard(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildExecutiveHeader() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF581C87), Color(0xFF7E22CE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF581C87).withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: CircleAvatar(
              radius: 26,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              child: const Text(
                'WS',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade400,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'C-LEVEL / DIREKTUR',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF78350F),
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'HGT-001',
                        style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  user.name.isNotEmpty ? user.name : 'Wendy Swandoyo',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Chief of Digital Commerce / Direktur PT Hanasta Global Teknologi',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFFF3E8FF),
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopStatsGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                title: 'Total Karyawan HGT',
                value: '18 Staf',
                subtitle: 'Product, PMO & CS',
                icon: Icons.groups_rounded,
                iconColor: Colors.purple,
                onTap: () => _openModal(context, const HgtSubsidiaryMonitorModal()),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                title: 'CS & Infra On-Duty',
                value: '12 Active',
                subtitle: 'Shift 1 & Standby Roster',
                icon: Icons.headset_mic_rounded,
                iconColor: Colors.teal,
                onTap: () => _openModal(context, const ShiftOnCallScheduleModal()),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                title: 'SLA Response Rate',
                value: '98.4%',
                subtitle: 'Rata-rata 2.8 Menit',
                icon: Icons.bolt_rounded,
                iconColor: Colors.amber,
                onTap: () => _openModal(context, const CsOperationsSlaModal()),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                title: 'Pengajuan Budget/Klaim',
                value: 'Rp 8.45 jt',
                subtitle: '3 Berkas Pending',
                icon: Icons.account_balance_wallet_rounded,
                iconColor: Colors.pink,
                onTap: () => _openModal(context, const CommerceExecutiveApprovalModal()),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
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
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 10,
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

  Widget _buildPlatformStatusBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF4FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF0ABFC)),
      ),
      child: Row(
        children: [
          const Icon(Icons.cloud_done_rounded, color: Colors.purple, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Commerce Cloud: 99.98% High Availability',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF701A75)),
                ),
                SizedBox(height: 2),
                Text(
                  'Semua gateway pembayaran & sistem QRIS merchant beroperasi optimal.',
                  style: TextStyle(fontSize: 11, color: Color(0xFF86198F)),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => _openModal(context, const CsOperationsSlaModal()),
            child: const Text('Cek SLA', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.purple)),
          ),
        ],
      ),
    );
  }

  Widget _buildActionMenuGrid(BuildContext context) {
    final actions = [
      {
        'title': 'HGT Subsidiary\nMonitor',
        'subtitle': 'Aktivitas Staf HGT',
        'icon': Icons.business_center_rounded,
        'color': Colors.purple,
        'action': () => _openModal(context, const HgtSubsidiaryMonitorModal()),
      },
      {
        'title': 'CS & Operations\nSLA',
        'subtitle': 'Respon & Uptime',
        'icon': Icons.speed_rounded,
        'color': Colors.teal,
        'action': () => _openModal(context, const CsOperationsSlaModal()),
      },
      {
        'title': 'Executive\nApproval',
        'subtitle': 'Persetujuan Head',
        'icon': Icons.approval_rounded,
        'color': Colors.amber,
        'action': () => _openModal(context, const CommerceExecutiveApprovalModal()),
      },
      {
        'title': 'Shift & On-Call\nSchedule',
        'subtitle': 'Kalender Piket CS',
        'icon': Icons.calendar_month_rounded,
        'color': Colors.indigo,
        'action': () => _openModal(context, const ShiftOnCallScheduleModal()),
      },
      {
        'title': 'Commerce\nAnalytics',
        'subtitle': 'Efisiensi Layanan',
        'icon': Icons.insights_rounded,
        'color': Colors.pink,
        'action': () => _openModal(context, const CommerceAnalyticsModal()),
      },
      {
        'title': 'Reports\nExport',
        'subtitle': 'PDF / Excel HGT',
        'icon': Icons.file_download_rounded,
        'color': Colors.blue,
        'action': () => _openModal(
              context,
              const ReportsExportModal(
                entityName: 'PT Hanasta Global Teknologi',
                chiefTitle: 'Chief of Digital Commerce',
              ),
            ),
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: actions.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (context, index) {
        final item = actions[index];
        final MaterialColor color = item['color'] as MaterialColor;
        return InkWell(
          onTap: item['action'] as VoidCallback,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.cardBorder),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(item['icon'] as IconData, color: color[800], size: 22),
                ),
                const SizedBox(height: 8),
                Text(
                  item['title'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item['subtitle'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 9, color: AppColors.textSecondary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSupportTicketPieCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.pie_chart_rounded, color: Colors.purple, size: 20),
              SizedBox(width: 8),
              Text(
                'Status Tiket Support & Penanganan CS',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Rasio penanganan kendala merchant & customer platform HGT bulan ini',
            style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),

          // Custom visual bar representing pie slices
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 26,
              child: Row(
                children: [
                  Expanded(flex: 72, child: Container(color: Colors.green, alignment: Alignment.center, child: const Text('72%', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
                  Expanded(flex: 21, child: Container(color: Colors.amber.shade700, alignment: Alignment.center, child: const Text('21%', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
                  Expanded(flex: 7, child: Container(color: Colors.red.shade600, alignment: Alignment.center, child: const Text('7%', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          _buildPieLegendItem('Resolved (Tuntas & Ditutup)', '72% (482 Kasus)', Colors.green),
          const SizedBox(height: 8),
          _buildPieLegendItem('In Progress (Sedang Ditangani CS)', '21% (141 Kasus)', Colors.amber.shade700),
          const SizedBox(height: 8),
          _buildPieLegendItem('Escalated (Eskalasi ke Infra/Dev)', '7% (47 Kasus)', Colors.red.shade600),
        ],
      ),
    );
  }

  Widget _buildPieLegendItem(String title, String val, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
          ),
        ),
        Text(
          val,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
      ],
    );
  }

  Widget _buildSlaResponseBarCard() {
    final weeklyData = [
      {'week': 'Mg 1', 'responseMin': 3.4, 'uptime': 99.96},
      {'week': 'Mg 2', 'responseMin': 3.1, 'uptime': 99.98},
      {'week': 'Mg 3', 'responseMin': 2.9, 'uptime': 99.99},
      {'week': 'Mg 4', 'responseMin': 2.8, 'uptime': 99.98},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.bar_chart_rounded, color: Colors.teal, size: 20),
              SizedBox(width: 8),
              Text(
                'Tren Response Time & Uptime Infrastruktur',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Kecepatan respon tim CS (Menit) & ketersediaan server (%) per minggu',
            style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 18),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: weeklyData.map((data) {
              final double respHeight = ((data['responseMin'] as double) / 5.0) * 90;
              final double uptimeHeight = 90; // fixed visual bar for near 100%

              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Response Time Bar
                      Container(
                        width: 16,
                        height: respHeight,
                        decoration: const BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                        ),
                      ),
                      const SizedBox(width: 6),
                      // Uptime Bar
                      Container(
                        width: 16,
                        height: uptimeHeight,
                        decoration: const BoxDecoration(
                          color: Color(0xFF7E22CE),
                          borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data['week'] as String,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
                  ),
                  Text(
                    '${data['responseMin']}m | ${data['uptime']}%',
                    style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                  ),
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 10, height: 10, decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 4),
              const Text('Waktu Respon CS (Min)', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
              const SizedBox(width: 16),
              Container(width: 10, height: 10, decoration: BoxDecoration(color: const Color(0xFF7E22CE), borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 4),
              const Text('Uptime Infra (99.98%)', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }
}
