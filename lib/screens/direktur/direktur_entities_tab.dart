import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../theme/app_colors.dart';

class DirekturEntitiesTab extends StatefulWidget {
  final UserModel user;

  const DirekturEntitiesTab({super.key, required this.user});

  @override
  State<DirekturEntitiesTab> createState() => _DirekturEntitiesTabState();
}

class _DirekturEntitiesTabState extends State<DirekturEntitiesTab> {
  String _selectedEntity = 'Semua Entitas';

  final List<Map<String, dynamic>> _entitiesData = [
    {
      'company': 'PT Aman Media Interaktif',
      'roleInGroup': 'Holding Company & Railways Governance',
      'leader': 'Dimas Pasurangga (Direktur Utama)',
      'sdm': '12 Karyawan',
      'projects': 5,
      'budget': 'Rp 160.000.000',
      'realization': 'Rp 142.000.000 (88.7%)',
      'status': 'Holding Parent',
      'color': Colors.blue,
      'highlights': [
        'Kemitraan strategis perkeretaapian PT KAI & LRT',
        'Audit kepatuhan tata kelola HR & Keuangan Grup',
        'Penyelarasan KPI lintas anak perusahaan',
      ],
    },
    {
      'company': 'PT Global Moviion Teknologi',
      'roleInGroup': 'Enterprise Solution Subsidiary',
      'leader': 'M. Rizky Elrivany (Direktur)',
      'sdm': '24 Karyawan',
      'projects': 8,
      'budget': 'Rp 200.000.000',
      'realization': 'Rp 185.000.000 (92.5%)',
      'status': 'Subsidiary (Tech)',
      'color': Colors.indigo,
      'highlights': [
        'Proyek Telemetri Depo KAI Manggarai Tahap 2',
        'Model AI Vision Pendeteksi Rintangan Lintasan Rel',
        'Civil works pondasi gantry sensor tower',
      ],
    },
    {
      'company': 'PT Hanasta Global Teknologi',
      'roleInGroup': 'Digital Commerce Subsidiary',
      'leader': 'Wendy Swandoyo (Direktur)',
      'sdm': '18 Karyawan',
      'projects': 4,
      'budget': 'Rp 120.000.000',
      'realization': 'Rp 105.000.000 (87.5%)',
      'status': 'Subsidiary (Commerce)',
      'color': Colors.purple,
      'highlights': [
        'Core Payment Gateway QRIS Multi-Acquirer',
        'Loyalty Point Engine v2.0 Sandbox Stage',
        'Layanan Operasional CS Merchant 24/7 (SLA 99.98%)',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _selectedEntity == 'Semua Entitas'
        ? _entitiesData
        : _entitiesData.where((e) => (e['company'] as String).contains(_selectedEntity)).toList();

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
                            'Portofolio Entitas Bisnis Grup',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                          ),
                          Text(
                            'Tinjauan Holding & Anak Usaha AMANI Tech Group',
                            style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F4C81).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          '3 Entitas',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF0F4C81)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ['Semua Entitas', 'Holding', 'Moviion', 'Hanasta'].map((tag) {
                        final isSelected = _selectedEntity == tag;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(
                              tag,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected ? Colors.white : AppColors.textPrimary,
                              ),
                            ),
                            selected: isSelected,
                            selectedColor: const Color(0xFF0F4C81),
                            backgroundColor: Colors.grey.shade100,
                            onSelected: (val) {
                              if (val) setState(() => _selectedEntity = tag);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Entities List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final e = filtered[index];
                  final MaterialColor color = e['color'] as MaterialColor;
                  final highlights = e['highlights'] as List<String>;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppColors.cardBorder),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
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
                            Expanded(
                              child: Text(
                                e['company'] as String,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textPrimary),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                e['status'] as String,
                                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color[800]),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          e['roleInGroup'] as String,
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color[800]),
                        ),
                        const Divider(height: 20),

                        Row(
                          children: [
                            const Icon(Icons.person_pin_circle_rounded, size: 14, color: AppColors.textSecondary),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                'Penanggung Jawab: ${e['leader']}',
                                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.groups_outlined, size: 14, color: AppColors.textSecondary),
                            const SizedBox(width: 6),
                            Text('Kekuatan SDM: ${e['sdm']}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                            const Spacer(),
                            const Icon(Icons.rocket_launch_outlined, size: 14, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text('${e['projects']} Proyek Aktif', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary)),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Budget Bar
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Plafon Anggaran Q1', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                                  Text(e['budget'] as String, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text('Realisasi Kas', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                                  Text(e['realization'] as String, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),

                        const Text('Highlight Operasional & Output:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                        const SizedBox(height: 6),
                        ...highlights.map((h) => Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.check_circle_rounded, size: 13, color: Colors.green),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(h, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                                  ),
                                ],
                              ),
                            )),
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
