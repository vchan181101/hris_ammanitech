import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class ResourceAllocationModal extends StatelessWidget {
  const ResourceAllocationModal({super.key});

  final List<Map<String, dynamic>> _projects = const [
    {
      'title': 'Smart Depo Energy Metering v2',
      'client': 'PT Kereta Api Indonesia (Persero)',
      'allocation': '8 Engineers',
      'lead': 'M. Jumi\'at Mochtar',
      'load': 85,
      'status': 'Deployment Phase',
      'color': Colors.blue,
    },
    {
      'title': 'AI Track Obstacle Vision System',
      'client': 'LRT Jabodebek Operation',
      'allocation': '6 Engineers',
      'lead': 'M Erlan',
      'load': 92,
      'status': 'Model Validation',
      'color': Colors.purple,
    },
    {
      'title': 'Gantry Sensor Tower Civil Works',
      'client': 'Balai Perkeretaapian Jakarta',
      'allocation': '5 Field Engineers',
      'lead': 'Abdul Rajab',
      'load': 78,
      'status': 'Foundation Casting',
      'color': Colors.orange,
    },
    {
      'title': 'Enterprise Fleet IoT Telematics',
      'client': 'Logistics Hub Tanjung Priok',
      'allocation': '4 Engineers',
      'lead': 'Budi Santoso',
      'load': 65,
      'status': 'Hardware Testing',
      'color': Colors.teal,
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
                    color: Colors.teal.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.hub_rounded, color: Colors.teal, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Resource Allocation Map',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'Pemetaan kapasitas & beban kerja engineer GMT',
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

            // Workload distribution overview
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Rata-rata Utilisasi Engineer',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                      Text(
                        '80% (Optimal)',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: const LinearProgressIndicator(
                      value: 0.80,
                      minHeight: 8,
                      backgroundColor: Colors.black12,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '23 dari 24 engineer teralokasi penuh pada 8 kontrak enterprise aktif.',
                    style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            const Text(
              'Alokasi per Proyek Enterprise',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 10),

            ..._projects.map((proj) {
              final MaterialColor color = proj['color'] as MaterialColor;
              final int load = proj['load'] as int;
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
                          child: Text(
                            proj['title'] as String,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            proj['allocation'] as String,
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color[800]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Klien: ${proj['client']}',
                      style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.person_pin_circle_rounded, size: 14, color: color[800]),
                        const SizedBox(width: 4),
                        Text(
                          'Lead: ${proj['lead']}',
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        Text(
                          'Kapasitas: $load%',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color[800]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: load / 100,
                        minHeight: 5,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(color),
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
                child: const Text('Tutup Alokasi', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
