import 'package:flutter/material.dart';
import '../../../models/user_model.dart';
import '../../../theme/app_colors.dart';

class HrPresensiMonitorTab extends StatefulWidget {
  final UserModel user;

  const HrPresensiMonitorTab({super.key, required this.user});

  @override
  State<HrPresensiMonitorTab> createState() => _HrPresensiMonitorTabState();
}

class _HrPresensiMonitorTabState extends State<HrPresensiMonitorTab> {
  String _selectedCompany = 'Semua Perusahaan';

  final List<Map<String, dynamic>> _employeeAttendanceFeed = [
    {
      'name': 'M. Jumi\'at Mochtar',
      'position': 'IoT Engineer',
      'company': 'PT Global Moviion Teknologi',
      'timeIn': '08:28 WIB',
      'timeOut': '--:-- WIB',
      'location': 'Cyber 2 Tower (HQ Jakarta)',
      'status': 'Tepat Waktu',
      'selfieVerified': true,
      'gpsAccuracy': '4m (Geofence OK)',
    },
    {
      'name': 'M Erlan',
      'position': 'AI Engineer',
      'company': 'PT Global Moviion Teknologi',
      'timeIn': '08:42 WIB',
      'timeOut': '--:-- WIB',
      'location': 'Site Deploy AI - GMT',
      'status': 'Terlambat (+12 mnt)',
      'selfieVerified': true,
      'gpsAccuracy': '6m (Geofence OK)',
    },
    {
      'name': 'Anggun Silvia',
      'position': 'Staff Finance',
      'company': 'PT Aman Media Interaktif',
      'timeIn': '08:15 WIB',
      'timeOut': '--:-- WIB',
      'location': 'Cyber 2 Tower (HQ Jakarta)',
      'status': 'Tepat Waktu',
      'selfieVerified': true,
      'gpsAccuracy': '3m (Geofence OK)',
    },
    {
      'name': 'Abdul Rajab',
      'position': 'Civil Works Engineer',
      'company': 'PT Global Moviion Teknologi',
      'timeIn': '08:30 WIB',
      'timeOut': '--:-- WIB',
      'location': 'Site Railway Telemetry',
      'status': 'Tepat Waktu',
      'selfieVerified': true,
      'gpsAccuracy': '5m (Geofence OK)',
    },
    {
      'name': 'M. Dikdo',
      'position': 'Infrastruktur Engineer',
      'company': 'PT Hanasta Global Teknologi',
      'timeIn': '08:25 WIB',
      'timeOut': '--:-- WIB',
      'location': 'HGT Commerce Office',
      'status': 'Tepat Waktu',
      'selfieVerified': true,
      'gpsAccuracy': '5m (Geofence OK)',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _employeeAttendanceFeed.where((item) {
      if (_selectedCompany == 'Semua Perusahaan') return true;
      return item['company'] == _selectedCompany;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Live Monitoring Presensi Karyawan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF0284C7),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Memperbarui feed presensi real-time...')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Company Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Entitas Company:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                DropdownButton<String>(
                  value: _selectedCompany,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary),
                  items: const [
                    DropdownMenuItem(value: 'Semua Perusahaan', child: Text('Semua Perusahaan')),
                    DropdownMenuItem(value: 'PT Aman Media Interaktif', child: Text('PT AMI (Holding)')),
                    DropdownMenuItem(value: 'PT Global Moviion Teknologi', child: Text('PT GMT (Subsidiary)')),
                    DropdownMenuItem(value: 'PT Hanasta Global Teknologi', child: Text('PT HGT (Subsidiary)')),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedCompany = val);
                  },
                ),
              ],
            ),
          ),

          // Employee Feed List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: filtered.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = filtered[index];
                final bool isLate = item['status'].toString().startsWith('Terlambat');

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.accentLight,
                                child: Text(item['name'][0], style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['name']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                  Text('${item['position']} • ${item['company']}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: isLate ? AppColors.warning.withValues(alpha: 0.15) : AppColors.success.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              item['status']!,
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isLate ? AppColors.warning : AppColors.success),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.access_time_rounded, size: 14, color: AppColors.primary),
                          const SizedBox(width: 6),
                          Text('Clock In: ${item['timeIn']}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 16),
                          const Icon(Icons.location_on_rounded, size: 14, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Expanded(child: Text(item['location']!, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary), overflow: TextOverflow.ellipsis)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.verified_rounded, size: 14, color: AppColors.success),
                          const SizedBox(width: 4),
                          Text('Selfie Wajah Verifikasi OK • GPS: ${item['gpsAccuracy']}', style: const TextStyle(fontSize: 10, color: AppColors.success, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
