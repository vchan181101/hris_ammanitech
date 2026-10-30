import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class SiteRiskIncidentModal extends StatelessWidget {
  const SiteRiskIncidentModal({super.key});

  final List<Map<String, dynamic>> _incidentLogs = const [
    {
      'title': 'Hujan Lebat & Genangan Jalur Peron',
      'site': 'Stasiun Cikini - Gondangdia',
      'severity': 'Low Risk',
      'actionTaken': 'Pemasangan pelindung box panel telemetry IP67 kedap air.',
      'reportedBy': 'Bagus Prasetya (Field Tech)',
      'time': 'Kemarin, 16:30 WIB',
      'color': Colors.blue,
    },
    {
      'title': 'Fluktuasi Tegangan Listrik Gardu Traksi',
      'site': 'Substation KCIC Halim',
      'severity': 'Medium Risk (Mitigated)',
      'actionTaken': 'Aktivasi sistem UPS redundant & auto-switch AVR stabil.',
      'reportedBy': 'Surya Darmawan (Power Lead)',
      'time': '26 Maret 2025',
      'color': Colors.amber,
    },
    {
      'title': 'Kabel Sinyal Lama Terkelupas (Aset Eksisting KAI)',
      'site': 'Emplasemen Manggarai km 09+800',
      'severity': 'Resolved',
      'actionTaken': 'Jointing & re-insulasi bersama tim Sintelis PT KAI Daop 1.',
      'reportedBy': 'Ir. Hendra Kusuma (SPM)',
      'time': '25 Maret 2025',
      'color': Colors.green,
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
                    color: Colors.orange.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Site Risk & Incident Log',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'Kendala teknis & mitigasi HSE tim lapangan proyek kereta',
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
                color: Colors.green.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: const [
                  Icon(Icons.health_and_safety_rounded, color: Colors.green, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'STATUS SAFETY: ZERO FATALITY (182 Hari Kerja Aman Tanpa Insiden Kerja Berat)',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF065F46)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            const Text('Log Laporan Mitigasi & Lapangan', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const SizedBox(height: 10),

            ..._incidentLogs.map((item) {
              final MaterialColor color = item['color'] as MaterialColor;
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
                          child: Text(item['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item['severity'] as String,
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color[800]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('Lokasi: ${item['site']}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Tindakan: ${item['actionTaken']}',
                        style: const TextStyle(fontSize: 11, color: AppColors.textPrimary, height: 1.3),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.person_pin_rounded, size: 12, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(item['reportedBy'] as String, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                        const Spacer(),
                        Text(item['time'] as String, style: const TextStyle(fontSize: 10, color: AppColors.textHint)),
                      ],
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
                child: const Text('Tutup Log Resiko', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
