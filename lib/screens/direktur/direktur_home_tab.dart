import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../theme/app_colors.dart';
import 'modals/konsolidasi_entitas_modal.dart';
import 'modals/kebijakan_broadcast_modal.dart';
import 'modals/persetujuan_strategis_modal.dart';
import 'modals/financial_health_audit_modal.dart';
import 'modals/project_governance_modal.dart';
import 'modals/ekspor_laporan_holding_modal.dart';

class DirekturHomeTab extends StatelessWidget {
  final UserModel user;
  final Function(int)? onNavigateTab;

  const DirekturHomeTab({
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
            // A. Header Identitas Direktur Utama
            _buildDirectorHeader(),
            const SizedBox(height: 18),

            // Top Cards: 4 Statistik Cepat Grup
            _buildTopStatsGrid(context),
            const SizedBox(height: 20),

            // Strategic Alert Card
            _buildStrategicAlertCard(context),
            const SizedBox(height: 20),

            // B. Grid Menu Utama (Middle Action Menu)
            const Text(
              'Tata Kelola & Kepemimpinan Holding',
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
              'Konsolidasi Metrik AMANI Tech Group',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),

            // Pie Chart: Komposisi Tenaga Kerja Grup
            _buildHeadcountDistributionPieCard(),
            const SizedBox(height: 16),

            // Bar Chart: Realisasi Anggaran Finansial per Entitas
            _buildFinancialRealizationBarCard(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDirectorHeader() {
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
              border: Border.all(color: Colors.amber.shade300, width: 2.5),
            ),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              child: const Text(
                'DP',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
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
                        'PRESIDENT DIRECTOR / CEO',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF78350F),
                          letterSpacing: 0.5,
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
                        'AMI-001',
                        style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  user.name.isNotEmpty ? user.name : 'Dimas Pasurangga',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Direktur Utama | PT Aman Media Interaktif (Holding)',
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
                title: 'Total SDM Grup',
                value: '54 Staf',
                subtitle: 'Holding & 2 Anak Usaha',
                icon: Icons.groups_rounded,
                iconColor: Colors.blue,
                onTap: () => _openModal(context, const KonsolidasiEntitasModal()),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                title: 'Entitas Bisnis',
                value: '3 Entitas',
                subtitle: 'AMI, GMT & HGT Aktif',
                icon: Icons.business_rounded,
                iconColor: Colors.indigo,
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
                title: 'Realisasi Budget Q1',
                value: 'Rp 480 jt',
                subtitle: '84% Penyerapan Sehat',
                icon: Icons.account_balance_wallet_rounded,
                iconColor: Colors.green,
                onTap: () => _openModal(context, const FinancialHealthAuditModal()),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                title: 'Otorisasi Pending',
                value: '4 Berkas',
                subtitle: 'Payroll & Capex Proyek',
                icon: Icons.verified_user_rounded,
                iconColor: Colors.orange,
                onTap: () => _openModal(context, const PersetujuanStrategisModal()),
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

  Widget _buildStrategicAlertCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Row(
        children: [
          const Icon(Icons.stars_rounded, color: Colors.orange, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Disposisi Rapat Dewan Direksi Q1',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF92400E)),
                ),
                SizedBox(height: 2),
                Text(
                  'BAST Tahap 2 KAI Gambir & Rollout Loyalty Commerce siap disahkan.',
                  style: TextStyle(fontSize: 11, color: Color(0xFFB45309)),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              if (onNavigateTab != null) onNavigateTab!(2);
            },
            child: const Text('Tinjau', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF92400E))),
          ),
        ],
      ),
    );
  }

  Widget _buildActionMenuGrid(BuildContext context) {
    final actions = [
      {
        'title': 'Konsolidasi\nEntitas',
        'subtitle': 'Holding & Sub.',
        'icon': Icons.apartment_rounded,
        'color': Colors.blue,
        'action': () => _openModal(context, const KonsolidasiEntitasModal()),
      },
      {
        'title': 'Mandat &\nBroadcast',
        'subtitle': 'Instruksi Direksi',
        'icon': Icons.campaign_rounded,
        'color': Colors.orange,
        'action': () => _openModal(context, const KebijakanBroadcastModal()),
      },
      {
        'title': 'Persetujuan\nStrategis',
        'subtitle': 'Payroll & Capex',
        'icon': Icons.verified_user_rounded,
        'color': Colors.amber,
        'action': () => _openModal(context, const PersetujuanStrategisModal()),
      },
      {
        'title': 'Financial &\nAudit SDM',
        'subtitle': 'Kas & Kepatuhan',
        'icon': Icons.account_balance_rounded,
        'color': Colors.green,
        'action': () => _openModal(context, const FinancialHealthAuditModal()),
      },
      {
        'title': 'Project\nGovernance',
        'subtitle': 'Tata Kelola 13 Proyek',
        'icon': Icons.hub_rounded,
        'color': Colors.indigo,
        'action': () => _openModal(context, const ProjectGovernanceModal()),
      },
      {
        'title': 'Ekspor Laporan\nKonsolidasi',
        'subtitle': 'PDF / Excel Grup',
        'icon': Icons.cloud_download_rounded,
        'color': Colors.teal,
        'action': () => _openModal(context, const EksporLaporanHoldingModal()),
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

  Widget _buildHeadcountDistributionPieCard() {
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
              Icon(Icons.pie_chart_rounded, color: Color(0xFF0F4C81), size: 20),
              SizedBox(width: 8),
              Text(
                'Komposisi Tenaga Kerja Grup (54 SDM)',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Distribusi staf & engineer antara Holding dan 2 Anak Usaha',
            style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 26,
              child: Row(
                children: [
                  Expanded(flex: 22, child: Container(color: Colors.blue, alignment: Alignment.center, child: const Text('22%', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
                  Expanded(flex: 44, child: Container(color: Colors.indigo, alignment: Alignment.center, child: const Text('44%', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
                  Expanded(flex: 34, child: Container(color: Colors.purple, alignment: Alignment.center, child: const Text('34%', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          _buildPieLegendItem('PT Aman Media Interaktif (Holding)', '22% (12 Staf)', Colors.blue),
          const SizedBox(height: 8),
          _buildPieLegendItem('PT Global Moviion Teknologi (Enterprise)', '44% (24 Engineer & Staf)', Colors.indigo),
          const SizedBox(height: 8),
          _buildPieLegendItem('PT Hanasta Global Teknologi (Commerce)', '34% (18 Engineer & CS)', Colors.purple),
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

  Widget _buildFinancialRealizationBarCard() {
    final financialData = [
      {'entity': 'Holding AMI', 'budget': 160, 'realization': 142},
      {'entity': 'PT GMT', 'budget': 200, 'realization': 185},
      {'entity': 'PT HGT', 'budget': 120, 'realization': 105},
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
              Icon(Icons.bar_chart_rounded, color: Colors.green, size: 20),
              SizedBox(width: 8),
              Text(
                'Realisasi Anggaran & Finansial per Entitas',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Plafon Budget vs Realisasi Pengeluaran Kas (dalam Juta Rupiah)',
            style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 18),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: financialData.map((data) {
              final double budgetHeight = ((data['budget'] as int) / 220) * 100;
              final double realizationHeight = ((data['realization'] as int) / 220) * 100;

              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 18,
                        height: budgetHeight,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 18,
                        height: realizationHeight,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF10B981), Color(0xFF047857)],
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
                    data['entity'] as String,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
                  ),
                  Text(
                    'Rp ${data['realization']} jt',
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
              const Text('Budget Plafon', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
              const SizedBox(width: 16),
              Container(width: 10, height: 10, decoration: BoxDecoration(color: const Color(0xFF047857), borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 4),
              const Text('Realisasi Kas', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }
}
