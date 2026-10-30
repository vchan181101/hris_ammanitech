import 'package:flutter/material.dart';
import '../../../../models/user_model.dart';
import '../../../../theme/app_colors.dart';

class ChiefRailwaysProjectsTab extends StatefulWidget {
  final UserModel user;

  const ChiefRailwaysProjectsTab({super.key, required this.user});

  @override
  State<ChiefRailwaysProjectsTab> createState() => _ChiefRailwaysProjectsTabState();
}

class _ChiefRailwaysProjectsTabState extends State<ChiefRailwaysProjectsTab> {
  String _selectedFilter = 'Semua';

  final List<Map<String, dynamic>> _railProjects = [
    {
      'title': 'Signaling & Interlocking Telemetry KAI',
      'location': 'Stasiun Gambir - Manggarai',
      'code': 'R&T-KAI-01',
      'lead': 'Ir. Hendra Kusuma',
      'progress': 82,
      'status': 'Testing / Comm.',
      'crew': '12 Field Engineers',
      'budget': 'Rp 1.450.000.000',
      'safetyRating': '100% Zero Incident',
      'color': Colors.blue,
    },
    {
      'title': 'AFC Gate Reader & QR Ticket Scanner',
      'location': '14 Stasiun Commuter KRL',
      'code': 'R&T-AFC-03',
      'lead': 'Fajar Prasetyo',
      'progress': 94,
      'status': 'Pre-Handover',
      'crew': '8 Technicians',
      'budget': 'Rp 920.000.000',
      'safetyRating': '100% Zero Incident',
      'color': Colors.green,
    },
    {
      'title': 'Overhead Catenary Vibration IoT Array',
      'location': 'LRT Jabodebek (Cawang - Harjamukti)',
      'code': 'R&T-LRT-05',
      'lead': 'M. Jumi\'at Mochtar',
      'progress': 68,
      'status': 'Implementation',
      'crew': '6 IoT Engineers',
      'budget': 'Rp 780.000.000',
      'safetyRating': '100% Zero Incident',
      'color': Colors.purple,
    },
    {
      'title': 'Substation SCADA & Traction Remote Control',
      'location': 'KCIC Workshop Tegalluar & Halim',
      'code': 'R&T-KCIC-02',
      'lead': 'Surya Darmawan',
      'progress': 45,
      'status': 'Hardware Installation',
      'crew': '6 Power Engineers',
      'budget': 'Rp 1.850.000.000',
      'safetyRating': '100% Zero Incident',
      'color': Colors.orange,
    },
    {
      'title': 'Transit Dispatcher Control Room Video Wall',
      'location': 'TOC Manggarai Lantai 3',
      'code': 'R&T-DISP-08',
      'lead': 'Abdul Rajab (Civil/Structure)',
      'progress': 76,
      'status': 'Display Setup',
      'crew': '4 Engineers',
      'budget': 'Rp 560.000.000',
      'safetyRating': '100% Zero Incident',
      'color': Colors.teal,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _selectedFilter == 'Semua'
        ? _railProjects
        : _railProjects.where((p) => (p['status'] as String).contains(_selectedFilter) || (p['location'] as String).contains(_selectedFilter)).toList();

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
                            'Railways & Transport Projects',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                          ),
                          Text(
                            'Portofolio Operasi Lapangan Kereta Api & Transit',
                            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0284C7).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${_railProjects.length} Proyek',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF0284C7)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ['Semua', 'Testing', 'Handover', 'Implementation', 'Manggarai', 'KCIC'].map((filter) {
                        final isSelected = _selectedFilter == filter;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(
                              filter,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected ? Colors.white : AppColors.textPrimary,
                              ),
                            ),
                            selected: isSelected,
                            selectedColor: const Color(0xFF0284C7),
                            backgroundColor: Colors.grey.shade100,
                            onSelected: (val) {
                              if (val) setState(() => _selectedFilter = filter);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Projects List
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
                                color: Colors.blue.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                p['status'] as String,
                                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          p['title'] as String,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.place_rounded, size: 14, color: Colors.red),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                p['location'] as String,
                                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        Row(
                          children: [
                            const Icon(Icons.person_pin_circle_rounded, size: 14, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text('Lead: ${p['lead']}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                            const Spacer(),
                            const Icon(Icons.engineering_rounded, size: 14, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(p['crew'] as String, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                          ],
                        ),
                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              p['safetyRating'] as String,
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.green),
                            ),
                            Text(
                              'Progress: $progress%',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color[800]),
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
                              'Anggaran: ${p['budget']}',
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
