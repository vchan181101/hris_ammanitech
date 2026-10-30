import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class FieldAttendanceModal extends StatelessWidget {
  const FieldAttendanceModal({super.key});

  final List<Map<String, dynamic>> _fieldStaff = const [
    {
      'name': 'Bagus Prasetya',
      'role': 'Senior Track Signaling Tech',
      'location': 'Stasiun Gambir (Peron 3 Jalur Hulu)',
      'clockIn': '06:45 WIB',
      'gpsAccuracy': '3 Meter (Valid Geofence)',
      'status': 'On-Site',
      'color': Colors.green,
    },
    {
      'name': 'Dedi Kurniawan',
      'role': 'Depo Traction Specialist',
      'location': 'Balai Yasa / Depo Manggarai',
      'clockIn': '07:05 WIB',
      'gpsAccuracy': '5 Meter (Valid Geofence)',
      'status': 'On-Site',
      'color': Colors.green,
    },
    {
      'name': 'Rahmat Hidayat',
      'role': 'Catenary IoT Technician',
      'location': 'Lintas LRT Cawang km 12+400',
      'clockIn': '07:15 WIB',
      'gpsAccuracy': '4 Meter (Valid Geofence)',
      'status': 'On-Site',
      'color': Colors.green,
    },
    {
      'name': 'Ahmad Fauzi',
      'role': 'High-Speed Railway Telecom Tech',
      'location': 'Stasiun KCIC Halim Perdanakusuma',
      'clockIn': '07:28 WIB',
      'gpsAccuracy': '6 Meter (Valid Geofence)',
      'status': 'On-Site',
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
                    color: Colors.green.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.location_on_rounded, color: Colors.green, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Field GPS Attendance Tracking',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'Monitoring presensi peron/depo/jalur proyek berbasis GPS',
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
                  Icon(Icons.gps_fixed_rounded, color: Colors.green, size: 24),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '32 Tim Lapangan Terverifikasi dalam Geofence Radius Stasiun/Depo Kerja Resmi.',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF065F46)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            const Text('Aktivitas Clock-In Lapangan Hari Ini', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const SizedBox(height: 10),

            ..._fieldStaff.map((staff) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.green.withValues(alpha: 0.15),
                      child: const Icon(Icons.person_pin_circle_rounded, color: Colors.green, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(staff['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              const Spacer(),
                              Text(staff['clockIn'] as String, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary)),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(staff['role'] as String, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.place_rounded, size: 12, color: Colors.red),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(staff['location'] as String, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text('GPS: ${staff['gpsAccuracy']}', style: const TextStyle(fontSize: 10, color: Colors.green, fontWeight: FontWeight.w600)),
                        ],
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
                child: const Text('Tutup GPS Tracking', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
