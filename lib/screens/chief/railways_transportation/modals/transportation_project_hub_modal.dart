import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class TransportationProjectHubModal extends StatelessWidget {
  const TransportationProjectHubModal({super.key});

  final List<Map<String, dynamic>> _railProjects = const [
    {
      'title': 'Signaling & Track Circuit Telemetry',
      'site': 'Depo Manggarai & Lintas Gambir',
      'lead': 'Ir. Hendra Kusuma',
      'progress': 82,
      'status': 'Testing Phase',
      'crew': '12 Field Engineers',
      'color': Colors.blue,
    },
    {
      'title': 'Automatic Fare Collection (AFC) Gate Sync',
      'site': '14 Stasiun Commuter Line Jabodetabek',
      'lead': 'Fajar Prasetyo',
      'progress': 94,
      'status': 'Final Handover Prep',
      'crew': '8 Technicians',
      'color': Colors.green,
    },
    {
      'title': 'Overhead Catenary Vibration IoT Monitoring',
      'site': 'LRT Jabodebek (Cawang - Harjamukti)',
      'lead': 'M. Jumi\'at Mochtar',
      'progress': 68,
      'status': 'Implementation Phase',
      'crew': '6 IoT Engineers',
      'color': Colors.purple,
    },
    {
      'title': 'Substation SCADA & Traction Power Telecontrol',
      'site': 'KCIC Workshop Tegalluar & Halim',
      'lead': 'Surya Darmawan',
      'progress': 45,
      'status': 'Hardware Installation',
      'crew': '6 Power Engineers',
      'color': Colors.orange,
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
                    color: Colors.blue.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.train_rounded, color: Colors.blue, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Transportation Project Hub',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'Milestone & status proyek strategis Kereta Api',
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
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMetric('5 Proyek', 'Sektor Aktif', Icons.track_changes_rounded),
                  Container(height: 36, width: 1, color: Colors.white.withValues(alpha: 0.3)),
                  _buildMetric('32 Staf', 'Bertugas On-Site', Icons.engineering_rounded),
                  Container(height: 36, width: 1, color: Colors.white.withValues(alpha: 0.3)),
                  _buildMetric('0 Insiden', 'Zero Accident', Icons.health_and_safety_rounded),
                ],
              ),
            ),
            const SizedBox(height: 18),

            const Text('Daftar Proyek & Status Milestone', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const SizedBox(height: 10),

            ..._railProjects.map((p) {
              final MaterialColor color = p['color'] as MaterialColor;
              final int progress = p['progress'] as int;
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
                            color: color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            p['status'] as String,
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color[800]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('Lokasi: ${p['site']}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.person_pin_circle_rounded, size: 14, color: color[800]),
                        const SizedBox(width: 4),
                        Text('Lead: ${p['lead']}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                        const Spacer(),
                        Text(p['crew'] as String, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress / 100,
                        minHeight: 6,
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
                child: const Text('Tutup Project Hub', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetric(String val, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(height: 4),
        Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.white70)),
      ],
    );
  }
}
