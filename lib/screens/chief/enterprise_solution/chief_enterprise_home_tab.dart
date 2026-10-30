import 'package:flutter/material.dart';
import '../../../../models/user_model.dart';
import '../../../../theme/app_colors.dart';
import 'modals/subsidiary_performance_modal.dart';
import 'modals/project_timesheet_modal.dart';
import 'modals/executive_approval_modal.dart';
import 'modals/resource_allocation_modal.dart';
import 'modals/reports_export_modal.dart';

class ChiefEnterpriseHomeTab extends StatelessWidget {
  final UserModel user;
  final Function(int)? onNavigateTab;

  const ChiefEnterpriseHomeTab({
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
            // A. Header Identitas Akun Eksekutif
            _buildExecutiveHeader(),
            const SizedBox(height: 18),

            // Top Cards: 4 Statistik Cepat
            _buildTopStatsGrid(context),
            const SizedBox(height: 20),

            // Quick Executive Alert
            _buildProjectAlertCard(context),
            const SizedBox(height: 20),

            // B. Grid Menu Utama (Middle Action Menu)
            const Text(
              'Menu Operasional & Kepemimpinan',
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
              'Eksekutif Analytics & Monitoring',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),

            // Pie Chart: Distribusi Alokasi Tim Teknis
            _buildTechnicalAllocationPieCard(),
            const SizedBox(height: 16),

            // Bar Chart: Progress & Jam Kerja Proyek Enterprise
            _buildProjectTimesheetBarCard(),
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
          colors: [Color(0xFF0F4C81), Color(0xFF1E3A8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F4C81).withValues(alpha: 0.25),
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
                'RE',
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
                        'GMT-001',
                        style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  user.name.isNotEmpty ? user.name : 'M. Rizky Elrivany',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Chief of Enterprise Solution / Direktur PT Global Moviion Teknologi',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFFE2E8F0),
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
                title: 'Total Karyawan GMT',
                value: '24 Staf',
                subtitle: 'Engineering & Account',
                icon: Icons.groups_rounded,
                iconColor: Colors.blue,
                onTap: () => _openModal(context, const SubsidiaryPerformanceModal()),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                title: 'Proyek Enterprise',
                value: '8 Aktif',
                subtitle: 'KAI, LRT, Logistics Hub',
                icon: Icons.rocket_launch_rounded,
                iconColor: Colors.purple,
                onTap: () {
                  if (onNavigateTab != null) onNavigateTab!(1);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                title: 'Presensi Tim Teknis',
                value: '96.2%',
                subtitle: '23 Hadir | 1 Dinas Luar',
                icon: Icons.verified_user_rounded,
                iconColor: Colors.green,
                onTap: () => _openModal(context, const ProjectTimesheetModal()),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                title: 'Pengajuan Pending',
                value: '5 Berkas',
                subtitle: 'Lembur & Klaim Lapangan',
                icon: Icons.pending_actions_rounded,
                iconColor: Colors.orange,
                onTap: () => _openModal(context, const ExecutiveApprovalModal()),
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

  Widget _buildProjectAlertCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: Row(
        children: [
          const Icon(Icons.bolt_rounded, color: Colors.blue, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Milestone Handover: Smart Metering KAI',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1E3A8A)),
                ),
                SizedBox(height: 2),
                Text(
                  'BAST Tahap 2 siap ditandatangani minggu ini bersama Rivano (Account Lead).',
                  style: TextStyle(fontSize: 11, color: Color(0xFF3B82F6)),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              if (onNavigateTab != null) onNavigateTab!(1);
            },
            child: const Text('Detail', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildActionMenuGrid(BuildContext context) {
    final actions = [
      {
        'title': 'Subsidiary\nPerformance',
        'subtitle': 'Kehadiran & Output',
        'icon': Icons.insights_rounded,
        'color': Colors.blue,
        'action': () => _openModal(context, const SubsidiaryPerformanceModal()),
      },
      {
        'title': 'Project\nTimesheet',
        'subtitle': 'Log Jam Engineer',
        'icon': Icons.timer_rounded,
        'color': Colors.indigo,
        'action': () => _openModal(context, const ProjectTimesheetModal()),
      },
      {
        'title': 'Executive\nApproval',
        'subtitle': 'Cuti & Klaim Head',
        'icon': Icons.fact_check_rounded,
        'color': Colors.amber,
        'action': () => _openModal(context, const ExecutiveApprovalModal()),
      },
      {
        'title': 'Resource\nAllocation',
        'subtitle': 'Beban Kerja Tim',
        'icon': Icons.hub_rounded,
        'color': Colors.teal,
        'action': () => _openModal(context, const ResourceAllocationModal()),
      },
      {
        'title': 'Reports\nExport',
        'subtitle': 'Unduh PDF / Excel',
        'icon': Icons.cloud_download_rounded,
        'color': Colors.deepPurple,
        'action': () => _openModal(
              context,
              const ReportsExportModal(
                entityName: 'PT Global Moviion Teknologi',
                chiefTitle: 'Chief of Enterprise Solution',
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
      },
    );
  }

  Widget _buildTechnicalAllocationPieCard() {
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
              Icon(Icons.pie_chart_rounded, color: Colors.blue, size: 20),
              SizedBox(width: 8),
              Text(
                'Distribusi Alokasi Tim Teknis GMT',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Beban kerja engineer teralokasi pada 8 kontrak enterprise aktif',
            style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),

          // Visual Custom Segment Bar representing Pie distribution
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 26,
              child: Row(
                children: [
                  Expanded(flex: 35, child: Container(color: Colors.blue, alignment: Alignment.center, child: const Text('35%', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
                  Expanded(flex: 30, child: Container(color: Colors.purple, alignment: Alignment.center, child: const Text('30%', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
                  Expanded(flex: 20, child: Container(color: Colors.orange, alignment: Alignment.center, child: const Text('20%', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
                  Expanded(flex: 15, child: Container(color: Colors.teal, alignment: Alignment.center, child: const Text('15%', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Legend
          _buildPieLegendItem('IoT Engine & Telemetri', '35% (8 Engineers)', Colors.blue),
          const SizedBox(height: 8),
          _buildPieLegendItem('AI & Data Intelligence', '30% (6 Engineers)', Colors.purple),
          const SizedBox(height: 8),
          _buildPieLegendItem('Civil Works & Tower Engineering', '20% (6 Engineers)', Colors.orange),
          const SizedBox(height: 8),
          _buildPieLegendItem('Account & Commercial Mgmt', '15% (4 Staf)', Colors.teal),
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

  Widget _buildProjectTimesheetBarCard() {
    final weeklyData = [
      {'week': 'Mg 1', 'timesheet': 780, 'target': 800},
      {'week': 'Mg 2', 'timesheet': 840, 'target': 800},
      {'week': 'Mg 3', 'timesheet': 890, 'target': 820},
      {'week': 'Mg 4', 'timesheet': 842, 'target': 800},
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
              Icon(Icons.bar_chart_rounded, color: Colors.indigo, size: 20),
              SizedBox(width: 8),
              Text(
                'Progress & Jam Kerja Proyek Enterprise',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Akumulasi jam kerja teknis (timesheet) vs target pengerjaan mingguan',
            style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 18),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: weeklyData.map((data) {
              final double timesheetHeight = ((data['timesheet'] as int) / 950) * 110;
              final double targetHeight = ((data['target'] as int) / 950) * 110;

              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Target Bar
                      Container(
                        width: 14,
                        height: targetHeight,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                        ),
                      ),
                      const SizedBox(width: 4),
                      // Actual Timesheet Bar
                      Container(
                        width: 18,
                        height: timesheetHeight,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
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
                    '${data['timesheet']} Jam',
                    style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 10, height: 10, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 4),
              const Text('Target Output (Jam)', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
              const SizedBox(width: 16),
              Container(width: 10, height: 10, decoration: BoxDecoration(color: const Color(0xFF1D4ED8), borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 4),
              const Text('Realisasi Timesheet', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }
}
