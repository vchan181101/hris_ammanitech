import 'package:flutter/material.dart';
import '../../../models/user_model.dart';
import '../../../theme/app_colors.dart';

class JadwalShiftModal extends StatelessWidget {
  final UserModel user;

  const JadwalShiftModal({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> scheduleItems = [
      {
        'day': 'Senin, 10 Mar 2025',
        'shift': 'Shift Normal (08:30 - 17:30 WIB)',
        'location': 'Cyber 2 Tower, Jakarta',
        'type': 'Office',
        'isToday': true,
      },
      {
        'day': 'Selasa, 11 Mar 2025',
        'shift': 'Shift Normal (08:30 - 17:30 WIB)',
        'location': 'Site Deploy IoT - GMT',
        'type': 'Site Work',
        'isToday': false,
      },
      {
        'day': 'Rabu, 12 Mar 2025',
        'shift': 'Standby On-Call 24 Hours (Teknis)',
        'location': 'Remote / On-Call Duty',
        'type': 'Piket / On-Call',
        'isToday': false,
      },
      {
        'day': 'Kamis, 13 Mar 2025',
        'shift': 'Shift Normal (08:30 - 17:30 WIB)',
        'location': 'Cyber 2 Tower, Jakarta',
        'type': 'Office',
        'isToday': false,
      },
      {
        'day': 'Jumat, 14 Mar 2025',
        'shift': 'Shift Normal (08:30 - 17:00 WIB)',
        'location': 'Cyber 2 Tower, Jakarta',
        'type': 'Office',
        'isToday': false,
      },
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.calendar_month_rounded,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jadwal Kerja & Shift Piket',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'Jadwal operasional mingguan karyawan',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Schedule List
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: scheduleItems.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = scheduleItems[index];
                final bool isToday = item['isToday'] == true;

                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isToday
                        ? AppColors.accentLight.withValues(alpha: 0.5)
                        : AppColors.inputBackground,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isToday ? AppColors.primary : AppColors.cardBorder,
                      width: isToday ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isToday ? AppColors.primary : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          item['type'] == 'Piket / On-Call'
                              ? Icons.sensors_rounded
                              : Icons.access_time_filled_rounded,
                          color: isToday ? Colors.white : AppColors.primary,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  item['day']!,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: isToday
                                        ? AppColors.primary
                                        : AppColors.textPrimary,
                                  ),
                                ),
                                if (isToday) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Text(
                                      'HARI INI',
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['shift']!,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '📍 ${item['location']}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Tutup', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
