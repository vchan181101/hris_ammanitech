import 'package:flutter/material.dart';
import '../../../../models/user_model.dart';
import '../../../../theme/app_colors.dart';

class ChiefEnterpriseProjectsTab extends StatefulWidget {
  final UserModel user;

  const ChiefEnterpriseProjectsTab({super.key, required this.user});

  @override
  State<ChiefEnterpriseProjectsTab> createState() => _ChiefEnterpriseProjectsTabState();
}

class _ChiefEnterpriseProjectsTabState extends State<ChiefEnterpriseProjectsTab> {
  String _selectedFilter = 'Semua';

  final List<Map<String, dynamic>> _projects = [
    {
      'title': 'Smart Energy Metering Depo KAI',
      'client': 'PT Kereta Api Indonesia (Persero)',
      'code': 'PRJ-KAI-01',
      'category': 'IoT & Infrastructure',
      'lead': 'M. Jumi\'at Mochtar',
      'progress': 88,
      'status': 'Deployment',
      'budget': 'Rp 850.000.000',
      'deadline': '30 April 2025',
      'color': Colors.blue,
      'milestones': '8/10 Milestone Selesai',
    },
    {
      'title': 'Track Vision Obstacle Detection AI',
      'client': 'LRT Jabodebek Operation',
      'code': 'PRJ-LRT-04',
      'category': 'Artificial Intelligence',
      'lead': 'M Erlan',
      'progress': 74,
      'status': 'Testing / QA',
      'budget': 'Rp 620.000.000',
      'deadline': '15 Mei 2025',
      'color': Colors.purple,
      'milestones': '6/8 Model Validated',
    },
    {
      'title': 'Tower Sensor Civil Foundation',
      'client': 'Balai Perkeretaapian Jakarta',
      'code': 'PRJ-CW-09',
      'category': 'Civil Works',
      'lead': 'Abdul Rajab',
      'progress': 92,
      'status': 'Finishing',
      'budget': 'Rp 410.000.000',
      'deadline': '10 April 2025',
      'color': Colors.orange,
      'milestones': 'Pengecoran Tiang Selesai',
    },
    {
      'title': 'IoT Logistics Telematics Fleet',
      'client': 'Pelabuhan Tanjung Priok Hub',
      'code': 'PRJ-FLT-12',
      'category': 'IoT & Infrastructure',
      'lead': 'Budi Santoso',
      'progress': 58,
      'status': 'Installation',
      'budget': 'Rp 390.000.000',
      'deadline': '30 Juni 2025',
      'color': Colors.teal,
      'milestones': '40 Unit GPS Hub Terpasang',
    },
    {
      'title': 'Predictive Maintenance Engine v2',
      'client': 'MRT Jakarta Workshop',
      'code': 'PRJ-MRT-07',
      'category': 'Artificial Intelligence',
      'lead': 'M Erlan',
      'progress': 45,
      'status': 'Data Gathering',
      'budget': 'Rp 540.000.000',
      'deadline': '15 Juli 2025',
      'color': Colors.purple,
      'milestones': 'Telemetry API Integrated',
    },
    {
      'title': 'Automatic Switch Point Sensor',
      'client': 'KCIC Halim Maintenance',
      'code': 'PRJ-KCIC-02',
      'category': 'IoT & Infrastructure',
      'lead': 'M. Jumi\'at Mochtar',
      'progress': 82,
      'status': 'Handover Review',
      'budget': 'Rp 780.000.000',
      'deadline': '25 April 2025',
      'color': Colors.blue,
      'milestones': 'Draft BAST Diajukan',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _selectedFilter == 'Semua'
        ? _projects
        : _projects.where((p) => (p['category'] as String).contains(_selectedFilter)).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: AppColors.cardBorder)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Enterprise Project Operations',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                          ),
                          Text(
                            'Portofolio Proyek PT Global Moviion Teknologi',
                            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${_projects.length} Proyek',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Filter Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ['Semua', 'IoT', 'Artificial Intelligence', 'Civil Works'].map((cat) {
                        final isSelected = _selectedFilter == cat;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(
                              cat,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected ? Colors.white : AppColors.textPrimary,
                              ),
                            ),
                            selected: isSelected,
                            selectedColor: AppColors.primary,
                            backgroundColor: Colors.grey.shade100,
                            onSelected: (val) {
                              if (val) setState(() => _selectedFilter = cat);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Project List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final p = filtered[index];
                  final MaterialColor color = p['color'] as MaterialColor;
                  final int progress = p['progress'] as int;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.cardBorder),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                p['code'] as String,
                                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color[800]),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                p['status'] as String,
                                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          p['title'] as String,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Klien: ${p['client']}',
                          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 10),

                        Row(
                          children: [
                            const Icon(Icons.person_pin_circle_rounded, size: 14, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(
                              'Lead: ${p['lead']}',
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            const Icon(Icons.event_outlined, size: 14, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(
                              'Deadline: ${p['deadline']}',
                              style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Progress
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              p['milestones'] as String,
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color[800]),
                            ),
                            Text(
                              '$progress%',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color[800]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: progress / 100,
                            minHeight: 6,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: AlwaysStoppedAnimation<Color>(color),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.monetization_on_outlined, size: 14, color: Colors.green),
                            const SizedBox(width: 4),
                            Text(
                              'Nilai Kontrak: ${p['budget']}',
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.green),
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
      ),
    );
  }
}
