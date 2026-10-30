import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class SubsidiaryPerformanceModal extends StatelessWidget {
  const SubsidiaryPerformanceModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 48,
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
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.analytics_rounded, color: AppColors.primary, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Subsidiary Performance',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'PT Global Moviion Teknologi (GMT)',
                        style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Kpi Summary Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMetric('96.2%', 'Presensi Hari Ini', Icons.people_alt_rounded),
                  Container(height: 36, width: 1, color: Colors.white.withValues(alpha: 0.3)),
                  _buildMetric('94.8%', 'Target Output Q1', Icons.trending_up_rounded),
                  Container(height: 36, width: 1, color: Colors.white.withValues(alpha: 0.3)),
                  _buildMetric('0.4%', 'Tingkat Attrisi', Icons.verified_user_rounded),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Distribusi Tim & Produktivitas Unit',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),

            _buildDivisionCard(
              title: 'IoT & Embedded Engineering',
              head: 'M. Jumi\'at Mochtar',
              count: '8 Staf',
              attendance: '100% Hadir (8/8)',
              productivity: 98,
              activeTasks: 'Smart Sensor Deployment & Telemetri Kereta',
              color: Colors.blue,
            ),
            const SizedBox(height: 10),
            _buildDivisionCard(
              title: 'AI & Data Intelligence',
              head: 'M Erlan',
              count: '6 Staf',
              attendance: '100% Hadir (6/6)',
              productivity: 95,
              activeTasks: 'Object Detection CCTV & Predictive Maintenance Engine',
              color: Colors.purple,
            ),
            const SizedBox(height: 10),
            _buildDivisionCard(
              title: 'Civil Works & Tower Engineering',
              head: 'Abdul Rajab',
              count: '6 Staf',
              attendance: '83% Hadir (5 On-Site, 1 Izin Lapangan)',
              productivity: 92,
              activeTasks: 'Instalasi Pondasi Tiang Sensor Manggarai',
              color: Colors.orange,
            ),
            const SizedBox(height: 10),
            _buildDivisionCard(
              title: 'Account & Customer Relationship',
              head: 'Rivano',
              count: '4 Staf',
              attendance: '100% Hadir (4/4)',
              productivity: 96,
              activeTasks: 'Client Engagement PT KAI & Rekap BAST',
              color: Colors.teal,
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.check_rounded, color: Colors.white),
                label: const Text('Tutup Pemantauan', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildMetric(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.9), size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 10, color: Colors.white.withValues(alpha: 0.8)),
        ),
      ],
    );
  }

  Widget _buildDivisionCard({
    required String title,
    required String head,
    required String count,
    required String attendance,
    required int productivity,
    required String activeTasks,
    required MaterialColor color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color[800]),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  count,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color[800]),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.person_pin_rounded, size: 13, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(
                'Lead: $head',
                style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Text(
                attendance,
                style: const TextStyle(fontSize: 11, color: AppColors.textPrimary, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: productivity / 100,
              minHeight: 5,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.task_alt_rounded, size: 12, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Fokus: $activeTasks',
                  style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '$productivity% Prod',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color[800]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
