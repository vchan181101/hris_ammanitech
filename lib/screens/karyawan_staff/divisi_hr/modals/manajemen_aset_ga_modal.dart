import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class ManajemenAsetGaModal extends StatefulWidget {
  const ManajemenAsetGaModal({super.key});

  @override
  State<ManajemenAsetGaModal> createState() => _ManajemenAsetGaModalState();
}

class _ManajemenAsetGaModalState extends State<ManajemenAsetGaModal> {
  String _selectedCategory = 'Semua Kategori';

  final List<Map<String, dynamic>> _assets = [
    {
      'code': 'AST-LPT-01',
      'name': 'MacBook Pro M2 16"',
      'category': 'Laptop / Komputer',
      'assignedTo': 'M Erlan (AI Engineer)',
      'company': 'PT Global Moviion Teknologi',
      'condition': 'Sangat Baik',
      'borrowDate': '12 Jan 2024',
    },
    {
      'code': 'AST-IOT-04',
      'name': 'Kit Telemetri IoT & Sensor Gateway',
      'category': 'Perangkat IoT / Lapangan',
      'assignedTo': 'M. Jumi\'at Mochtar (IoT Engineer)',
      'company': 'PT Global Moviion Teknologi',
      'condition': 'Baik (Operasional Site)',
      'borrowDate': '01 Feb 2024',
    },
    {
      'code': 'AST-MOB-01',
      'name': 'Toyota Innova Zenix (B 1234 AMI)',
      'category': 'Kendaraan Operasional',
      'assignedTo': 'Pool GA Holding (Djoko / Mia)',
      'company': 'PT Aman Media Interaktif',
      'condition': 'Siap Pakai (Service Rutin OK)',
      'borrowDate': 'Standby Pool',
    },
    {
      'code': 'AST-LPT-09',
      'name': 'Dell Latitude 5440 i7',
      'category': 'Laptop / Komputer',
      'assignedTo': 'Anggun Silvia (Staff Finance)',
      'company': 'PT Aman Media Interaktif',
      'condition': 'Baik',
      'borrowDate': '10 Mar 2024',
    },
    {
      'code': 'AST-SRV-02',
      'name': 'Server Rack Blade Cisco UCS',
      'category': 'Infrastruktur IT',
      'assignedTo': 'M. Dikdo (Infrastruktur Eng)',
      'company': 'PT Hanasta Global Teknologi',
      'condition': 'Running 24/7 (Data Center)',
      'borrowDate': '05 Jan 2024',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _assets.where((item) {
      if (_selectedCategory == 'Semua Kategori') return true;
      return item['category'] == _selectedCategory;
    }).toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 44,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.inventory_2_rounded, color: Color(0xFF0F4C81)),
                    SizedBox(width: 8),
                    Text(
                      'Manajemen Aset & General Affairs',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Chips Filter
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                'Semua Kategori',
                'Laptop / Komputer',
                'Perangkat IoT / Lapangan',
                'Kendaraan Operasional',
                'Infrastruktur IT'
              ].map((cat) {
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(
                      cat,
                      style: TextStyle(
                        fontSize: 11,
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: const Color(0xFF0F4C81),
                    backgroundColor: AppColors.inputBackground,
                    onSelected: (val) {
                      if (val) setState(() => _selectedCategory = cat);
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: filtered.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final asset = filtered[index];
                return Container(
                  padding: const EdgeInsets.all(14),
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
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0F2FE),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.devices_other_rounded,
                          color: Color(0xFF0284C7),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              asset['name'],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Kode: ${asset['code']} • ${asset['category']}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF0F4C81),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Pemegang: ${asset['assignedTo']}',
                              style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                            ),
                            Text(
                              'Kondisi: ${asset['condition']}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.success,
                                fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }
}
