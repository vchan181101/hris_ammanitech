import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class ShiftOnCallScheduleModal extends StatelessWidget {
  const ShiftOnCallScheduleModal({super.key});

  final List<Map<String, dynamic>> _schedules = const [
    {
      'date': 'Hari Ini (Rabu, 28 Maret)',
      'shift': 'Shift 1 (Pagi: 07:00 - 15:30)',
      'csAgents': 'Siti Rahma & Kevin Pratama',
      'infraOnCall': 'M. Dikdo (Primary)',
      'status': 'Active Now',
      'color': Colors.green,
    },
    {
      'date': 'Hari Ini (Rabu, 28 Maret)',
      'shift': 'Shift 2 (Siang: 15:00 - 23:30)',
      'csAgents': 'Dian Sastro & Fajar Nugraha',
      'infraOnCall': 'M. Dikdo (Standby Tier 2)',
      'status': 'Upcoming',
      'color': Colors.blue,
    },
    {
      'date': 'Besok (Kamis, 29 Maret)',
      'shift': 'Shift 1 (Pagi: 07:00 - 15:30)',
      'csAgents': 'Kevin Pratama & Rian Hidayat',
      'infraOnCall': 'Aditya (Infra Backup)',
      'status': 'Scheduled',
      'color': Colors.purple,
    },
    {
      'date': 'Sabtu & Minggu (Weekend Standby)',
      'shift': 'Weekend On-Call Emergency SLA',
      'csAgents': 'Dian Sastro (Standby Emergency)',
      'infraOnCall': 'M. Dikdo (Emergency Escalation)',
      'status': 'Standby Ready',
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
                    color: Colors.indigo.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.schedule_rounded, color: Colors.indigo, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Shift & On-Call Schedule',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'Jadwal piket CS & Infrastructure Engineer HGT',
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
                children: [
                  const Icon(Icons.support_agent_rounded, color: Colors.green, size: 28),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Status CS Live Support: AKTIF', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.green)),
                        Text('2 Agen sedang bertugas online, 1 Standby On-Call.', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            const Text('Daftar Roster Shift & On-Call', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const SizedBox(height: 10),

            ..._schedules.map((item) {
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
                        Text(item['date'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item['status'] as String,
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color[800]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(item['shift'] as String, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color[800])),
                    const Divider(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.headset_mic_rounded, size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text('Agen CS: ${item['csAgents']}', style: const TextStyle(fontSize: 11, color: AppColors.textPrimary)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.cloud_sync_rounded, size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text('Infra On-Call: ${item['infraOnCall']}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
                        ),
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
                child: const Text('Tutup Roster', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
