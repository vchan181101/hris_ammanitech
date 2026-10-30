import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class HgtSubsidiaryMonitorModal extends StatelessWidget {
  const HgtSubsidiaryMonitorModal({super.key});

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
                    color: Colors.purple.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.storefront_rounded, color: Colors.purple, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'HGT Subsidiary Monitor',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'Aktivitas SDM & Operasional PT Hanasta Global Teknologi',
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
            const SizedBox(height: 18),

            // Overview
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6B21A8), Color(0xFF9333EA)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMetric('18', 'Total SDM HGT', Icons.badge_outlined),
                  Container(height: 36, width: 1, color: Colors.white.withValues(alpha: 0.3)),
                  _buildMetric('100%', 'Presensi Hari Ini', Icons.task_alt_rounded),
                  Container(height: 36, width: 1, color: Colors.white.withValues(alpha: 0.3)),
                  _buildMetric('99.98%', 'Core App Uptime', Icons.cloud_done_rounded),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Divisi & Kinerja Unit Kerja HGT',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 12),

            _buildUnitCard(
              title: 'Product & Technology Management',
              head: 'Achmad Subekti (Head of Product & Tech)',
              members: '6 Staf',
              focus: 'Loyalty Engine v2.0, Checkout Flow Optimization',
              status: 'Sprint On-Track (89%)',
              color: Colors.blue,
            ),
            const SizedBox(height: 10),
            _buildUnitCard(
              title: 'Project Management Office (PMO)',
              head: 'Nurandi Marsha (Project Manager)',
              members: '4 Staf',
              focus: 'B2B Merchant Onboarding & Payment Integrations',
              status: '3 Active Deliverables',
              color: Colors.indigo,
            ),
            const SizedBox(height: 10),
            _buildUnitCard(
              title: 'Cloud & Infrastructure Engineering',
              head: 'M. Dikdo (Infrastructure Engineer)',
              members: '4 Engineers',
              focus: 'Kubernetes Cluster Scaling, CDN Latency Optimization',
              status: '99.98% High Availability',
              color: Colors.purple,
            ),
            const SizedBox(height: 10),
            _buildUnitCard(
              title: 'Customer Experience & 24/7 Operations',
              head: 'Shift Supervisor (Tim CS HGT)',
              members: '4 Agents (Shift Active)',
              focus: 'Live Chat Support, Escalated Merchant Inquiries',
              status: 'Response Time: 2.8 Min',
              color: Colors.teal,
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B21A8),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Tutup Monitor HGT', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
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
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        Text(label, style: TextStyle(fontSize: 10, color: Colors.white.withValues(alpha: 0.8))),
      ],
    );
  }

  Widget _buildUnitCard({
    required String title,
    required String head,
    required String members,
    required String focus,
    required String status,
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
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color[800]),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  members,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color[800]),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(head, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Text('Fokus: $focus', style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.check_circle_outline_rounded, size: 12, color: Colors.green),
              const SizedBox(width: 4),
              Text(status, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.green)),
            ],
          ),
        ],
      ),
    );
  }
}
