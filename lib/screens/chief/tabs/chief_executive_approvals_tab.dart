import 'package:flutter/material.dart';
import '../../../../models/user_model.dart';
import '../../../../theme/app_colors.dart';

class ChiefExecutiveApprovalsTab extends StatefulWidget {
  final UserModel user;

  const ChiefExecutiveApprovalsTab({super.key, required this.user});

  @override
  State<ChiefExecutiveApprovalsTab> createState() => _ChiefExecutiveApprovalsTabState();
}

class _ChiefExecutiveApprovalsTabState extends State<ChiefExecutiveApprovalsTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _items = [
    {
      'id': 'APP-01',
      'applicant': 'Rivano',
      'position': 'Customer Account Manager (GMT)',
      'type': 'Klaim Operasional / Entertainment Klien KAI',
      'amount': 'Rp 2.450.000',
      'description': 'Meeting koordinasi & penyerahan BAST project IoT dengan jajaran manajemen KAI di Stasiun Gambir.',
      'category': 'Klaim & Biaya',
      'status': 'Pending',
      'date': '27 Maret 2025',
      'color': Colors.blue,
    },
    {
      'id': 'APP-02',
      'applicant': 'Achmad Subekti',
      'position': 'Head of Product & Technology (HGT)',
      'type': 'Pengadaan Server Cloud Sandbox QA',
      'amount': 'Rp 5.200.000 / Bulan',
      'description': 'Peningkatan kapasitas cluster staging untuk stress-test fitur Loyalty Point Engine v2.0.',
      'category': 'Klaim & Biaya',
      'status': 'Pending',
      'date': '27 Maret 2025',
      'color': Colors.purple,
    },
    {
      'id': 'APP-03',
      'applicant': 'Ir. Hendra Kusuma',
      'position': 'Site Project Manager Manggarai',
      'type': 'Surat Perintah Perjalanan Dinas (SPPD)',
      'amount': 'Rp 3.850.000',
      'description': 'Survei teknis interfase interlocking sinyal stasiun Cikarang - Karawang (3 Teknisi Lapangan).',
      'category': 'Klaim & Biaya',
      'status': 'Pending',
      'date': '26 Maret 2025',
      'color': Colors.indigo,
    },
    {
      'id': 'APP-04',
      'applicant': 'M Erlan',
      'position': 'AI Engineer Lead (GMT)',
      'type': 'Pengajuan Cuti Tahunan',
      'amount': '3 Hari Kerja (2 - 4 April 2025)',
      'description': 'Cuti tahunan keperluan keluarga (pekerjaan telah didelegasikan ke AI Engineer junior).',
      'category': 'Cuti / Izin',
      'status': 'Pending',
      'date': '28 Maret 2025',
      'color': Colors.teal,
    },
    {
      'id': 'APP-05',
      'applicant': 'M. Dikdo',
      'position': 'Infrastructure Engineer (HGT)',
      'type': 'Klaim Lembur Weekend Maintenance Core Gateway',
      'amount': '12 Jam Lembur (Rp 850.000)',
      'description': 'Migrasi database zero-downtime dan security patch core payment gateway.',
      'category': 'Lembur & Timesheet',
      'status': 'Pending',
      'date': '25 Maret 2025',
      'color': Colors.orange,
    },
    {
      'id': 'APP-06',
      'applicant': 'Abdul Rajab',
      'position': 'Civil Works Engineer (GMT)',
      'type': 'Lembur Pengecoran Pondasi Tower Manggarai',
      'amount': '9 Jam Lembur Malam (Window Time)',
      'description': 'Pengecoran gantry sensor lintasan saat non-operasional jam 00:30 - 04:00 WIB.',
      'category': 'Lembur & Timesheet',
      'status': 'Pending',
      'date': '27 Maret 2025',
      'color': Colors.orange,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleDecision(String id, bool isApprove) {
    final item = _items.firstWhere((element) => element['id'] == id);
    setState(() {
      _items.removeWhere((element) => element['id'] == id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isApprove
              ? 'Pengajuan ${item['applicant']} (${item['type']}) BERHASIL DISETUJUI.'
              : 'Pengajuan ${item['applicant']} DITOLAK.',
        ),
        backgroundColor: isApprove ? AppColors.success : AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                            'Executive Approval Center',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                          ),
                          Text(
                            'Pusat Persetujuan Cuti, Lembur, dan Klaim Tingkat Head / Manager',
                            style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${_items.length} Pending',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.orange),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  TabBar(
                    controller: _tabController,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.textSecondary,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    indicatorColor: AppColors.primary,
                    indicatorWeight: 3,
                    isScrollable: true,
                    tabs: const [
                      Tab(text: 'Semua Berkas'),
                      Tab(text: 'Cuti / Izin'),
                      Tab(text: 'Lembur & Timesheet'),
                      Tab(text: 'Klaim & Biaya Dinas'),
                    ],
                  ),
                ],
              ),
            ),

            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildList(_items),
                  _buildList(_items.where((i) => i['category'] == 'Cuti / Izin').toList()),
                  _buildList(_items.where((i) => i['category'] == 'Lembur & Timesheet').toList()),
                  _buildList(_items.where((i) => i['category'] == 'Klaim & Biaya').toList()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<Map<String, dynamic>> list) {
    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.check_circle_outline_rounded, color: Colors.green, size: 54),
            SizedBox(height: 12),
            Text(
              'Tidak ada berkas yang menunggu persetujuan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary),
            ),
            SizedBox(height: 4),
            Text(
              'Semua permohonan telah selesai ditindaklanjuti.',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        final MaterialColor color = item['color'] as MaterialColor;

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
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: color.withValues(alpha: 0.15),
                    child: Text(
                      (item['applicant'] as String).substring(0, 2).toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.bold, color: color[800], fontSize: 12),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['applicant'] as String,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        Text(
                          item['position'] as String,
                          style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item['category'] as String,
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.orange),
                    ),
                  ),
                ],
              ),
              const Divider(height: 20),
              Text(
                item['type'] as String,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: color[800]),
              ),
              const SizedBox(height: 4),
              Text(
                'Nilai / Durasi: ${item['amount']}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.primary),
              ),
              const SizedBox(height: 6),
              Text(
                item['description'] as String,
                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.3),
              ),
              const SizedBox(height: 8),
              Text('Tanggal Diajukan: ${item['date']}', style: const TextStyle(fontSize: 10, color: AppColors.textHint)),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _handleDecision(item['id'] as String, false),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.error),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Tolak'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _handleDecision(item['id'] as String, true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Setujui', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
