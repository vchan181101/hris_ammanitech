import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../theme/app_colors.dart';

class EssAttendanceTab extends StatefulWidget {
  final UserModel user;

  const EssAttendanceTab({super.key, required this.user});

  @override
  State<EssAttendanceTab> createState() => _EssAttendanceTabState();
}

class _EssAttendanceTabState extends State<EssAttendanceTab> {
  String _selectedFilter = 'Semua';
  String _selectedMonth = 'Maret 2025';

  final List<Map<String, dynamic>> _attendanceLogs = [
    {
      'date': 'Senin, 10 Mar 2025',
      'in': '08:28 WIB',
      'out': '17:32 WIB',
      'duration': '9 Jam 04 Mnt',
      'location': 'Cyber 2 Tower (HQ)',
      'status': 'Tepat Waktu',
    },
    {
      'date': 'Jumat, 07 Mar 2025',
      'in': '08:45 WIB',
      'out': '17:40 WIB',
      'duration': '8 Jam 55 Mnt',
      'location': 'Site Deploy IoT GMT',
      'status': 'Terlambat',
    },
    {
      'date': 'Kamis, 06 Mar 2025',
      'in': '08:25 WIB',
      'out': '17:35 WIB',
      'duration': '9 Jam 10 Mnt',
      'location': 'Cyber 2 Tower (HQ)',
      'status': 'Tepat Waktu',
    },
    {
      'date': 'Rabu, 05 Mar 2025',
      'in': '-- : --',
      'out': '-- : --',
      'duration': '0 Jam',
      'location': 'Surat Dokter Terlampir',
      'status': 'Izin / Sakit',
    },
    {
      'date': 'Selasa, 04 Mar 2025',
      'in': '08:20 WIB',
      'out': '18:15 WIB',
      'duration': '9 Jam 55 Mnt (+1h OT)',
      'location': 'Cyber 2 Tower (HQ)',
      'status': 'Tepat Waktu',
    },
    {
      'date': 'Senin, 03 Mar 2025',
      'in': '08:30 WIB',
      'out': '17:30 WIB',
      'duration': '9 Jam 00 Mnt',
      'location': 'Cyber 2 Tower (HQ)',
      'status': 'Tepat Waktu',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredList = _attendanceLogs.where((item) {
      if (_selectedFilter == 'Semua') return true;
      return item['status'] == _selectedFilter;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Riwayat Presensi Bulanan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download_outlined, color: Colors.white),
            tooltip: 'Unduh Rekap Presensi',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Mengunduh Laporan Presensi PDF...'),
                  backgroundColor: AppColors.primary,
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Pilih Bulan:',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      value: _selectedMonth,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      items: const [
                        DropdownMenuItem(value: 'Maret 2025', child: Text('Maret 2025')),
                        DropdownMenuItem(value: 'Februari 2025', child: Text('Februari 2025')),
                        DropdownMenuItem(value: 'Januari 2025', child: Text('Januari 2025')),
                      ],
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedMonth = val);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('Semua'),
                      _buildFilterChip('Tepat Waktu'),
                      _buildFilterChip('Terlambat'),
                      _buildFilterChip('Izin / Sakit'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Attendance Log List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: filteredList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = filteredList[index];
                final String status = item['status'];
                Color statusColor = AppColors.success;
                if (status == 'Terlambat') statusColor = AppColors.warning;
                if (status == 'Izin / Sakit') statusColor = Colors.blue;

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.cardBorder),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item['date']!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              status,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: statusColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Icons.login_rounded, size: 16, color: AppColors.primary),
                                const SizedBox(width: 6),
                                Text(
                                  'Masuk: ${item['in']}',
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Icons.logout_rounded, size: 16, color: AppColors.error),
                                const SizedBox(width: 6),
                                Text(
                                  'Keluar: ${item['out']}',
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textSecondary),
                              const SizedBox(width: 4),
                              Text(
                                item['location']!,
                                style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                          Text(
                            'Durasi: ${item['duration']}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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

  Widget _buildFilterChip(String label) {
    final bool isSelected = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        label: Text(label),
        labelStyle: TextStyle(
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.white : AppColors.textPrimary,
        ),
        selectedColor: AppColors.primary,
        backgroundColor: AppColors.inputBackground,
        onSelected: (selected) {
          setState(() {
            _selectedFilter = label;
          });
        },
      ),
    );
  }
}
