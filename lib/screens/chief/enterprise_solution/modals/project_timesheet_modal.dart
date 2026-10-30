import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class ProjectTimesheetModal extends StatefulWidget {
  const ProjectTimesheetModal({super.key});

  @override
  State<ProjectTimesheetModal> createState() => _ProjectTimesheetModalState();
}

class _ProjectTimesheetModalState extends State<ProjectTimesheetModal> {
  String _selectedRole = 'Semua Divisi';

  final List<Map<String, dynamic>> _timesheets = [
    {
      'name': 'M. Jumi\'at Mochtar',
      'role': 'IoT Engineer',
      'project': 'Smart Energy Metering & Hub Depo',
      'hours': '42 Jam',
      'overtime': '6 Jam',
      'status': 'Verified',
      'avatar': 'JM',
      'color': Colors.blue,
    },
    {
      'name': 'M Erlan',
      'role': 'AI Engineer',
      'project': 'Railway Obstacle Detection Model',
      'hours': '40 Jam',
      'overtime': '4 Jam',
      'status': 'Verified',
      'avatar': 'ME',
      'color': Colors.purple,
    },
    {
      'name': 'Abdul Rajab',
      'role': 'Civil Works Engineer',
      'project': 'Pondasi Gantry Sensor Manggarai',
      'hours': '45 Jam',
      'overtime': '9 Jam',
      'status': 'Review Lead',
      'avatar': 'AR',
      'color': Colors.orange,
    },
    {
      'name': 'Rivano',
      'role': 'Customer Account Manager',
      'project': 'Client Milestone Review PT KAI',
      'hours': '38 Jam',
      'overtime': '0 Jam',
      'status': 'Verified',
      'avatar': 'RV',
      'color': Colors.teal,
    },
    {
      'name': 'Budi Santoso',
      'role': 'IoT Field Technician',
      'project': 'Wiring & Gateway Setup Gambir',
      'hours': '44 Jam',
      'overtime': '8 Jam',
      'status': 'Review Lead',
      'avatar': 'BS',
      'color': Colors.blue,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _selectedRole == 'Semua Divisi'
        ? _timesheets
        : _timesheets.where((item) => (item['role'] as String).contains(_selectedRole)).toList();

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
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.timer_outlined, color: Colors.blue, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Project Timesheet Monitoring',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'Alokasi jam kerja & lembur tim teknis GMT',
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

            // Summary row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Total Log Jam Kerja', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                        SizedBox(height: 4),
                        Text('842 Jam', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
                        Text('Minggu ini', style: TextStyle(fontSize: 10, color: Colors.green, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Total Jam Lembur', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                        SizedBox(height: 4),
                        Text('58 Jam', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange)),
                        Text('14 engineer on-duty', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Role filter chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  'Semua Divisi',
                  'IoT',
                  'AI',
                  'Civil Works',
                  'Account',
                ].map((role) {
                  final isSelected = _selectedRole == role;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(
                        role,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: AppColors.primary,
                      backgroundColor: Colors.grey.shade100,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() => _selectedRole = role);
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Timesheet list
            ...filtered.map((item) {
              final MaterialColor color = item['color'] as MaterialColor;
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.cardBorder),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: color.withValues(alpha: 0.15),
                      child: Text(
                        item['avatar'] as String,
                        style: TextStyle(fontWeight: FontWeight.bold, color: color[800], fontSize: 13),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                item['name'] as String,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  item['role'] as String,
                                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: color[800]),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['project'] as String,
                            style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.access_time_rounded, size: 12, color: Colors.blue),
                              const SizedBox(width: 4),
                              Text(
                                item['hours'] as String,
                                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(width: 10),
                              const Icon(Icons.bolt_rounded, size: 12, color: Colors.orange),
                              const SizedBox(width: 4),
                              Text(
                                'Lembur: ${item['overtime']}',
                                style: const TextStyle(fontSize: 11, color: Colors.orange, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Tutup Timesheet', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
