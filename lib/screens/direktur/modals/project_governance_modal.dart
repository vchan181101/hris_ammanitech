import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class ProjectGovernanceModal extends StatelessWidget {
  const ProjectGovernanceModal({super.key});

  final List<Map<String, dynamic>> _groupProjects = const [
    {
      'title': 'Signaling & Interlocking Telemetry KAI',
      'portfolio': 'Railways & Transportation (AMI/GMT)',
      'sponsor': 'Pirmadi Sukma & M. Rizky',
      'progress': 82,
      'budget': 'Rp 1.450.000.000',
      'health': 'On-Track (BAST Siap)',
      'healthColor': Colors.green,
    },
    {
      'title': 'Track Vision Obstacle Detection AI',
      'portfolio': 'Enterprise Solution (PT GMT)',
      'sponsor': 'M. Rizky Elrivany & M Erlan',
      'progress': 74,
      'budget': 'Rp 620.000.000',
      'health': 'QA Testing Phase',
      'healthColor': Colors.blue,
    },
    {
      'title': 'AmaniPay & QRIS Multi-Acquirer Gateway',
      'portfolio': 'Digital Commerce (PT HGT)',
      'sponsor': 'Wendy Swandoyo & Achmad Subekti',
      'progress': 92,
      'budget': 'Rp 850.000.000',
      'health': 'High Availability 99.99%',
      'healthColor': Colors.green,
    },
    {
      'title': 'Substation SCADA & Traction Remote Control',
      'portfolio': 'Railways & Transportation (KCIC Halim)',
      'sponsor': 'Pirmadi Sukma',
      'progress': 45,
      'budget': 'Rp 1.850.000.000',
      'health': 'Hardware Delivery',
      'healthColor': Colors.orange,
    },
  ];

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
                    color: Colors.blue.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.hub_rounded, color: Colors.blue, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Strategic Project Governance',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'Tata Kelola Proyek Strategis Lintas Entitas Grup',
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

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: Row(
                children: const [
                  Icon(Icons.shield_rounded, color: Color(0xFF0F4C81), size: 26),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Semua 13 proyek strategis anak usaha terpantau patuh SLA, tata kelola kontrak, dan standar K3 keselamatan.',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            const Text('Portofolio Strategis Utama Direksi', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const SizedBox(height: 10),

            ..._groupProjects.map((p) {
              final int progress = p['progress'] as int;
              final Color healthColor = p['healthColor'] as Color;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(p['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: healthColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            p['health'] as String,
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: healthColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(p['portfolio'] as String, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.person_pin_circle_rounded, size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text('Sponsor: ${p['sponsor']}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                        const Spacer(),
                        Text('${p['budget']}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.green)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress / 100,
                        minHeight: 6,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0F4C81)),
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Tutup Tata Kelola', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
