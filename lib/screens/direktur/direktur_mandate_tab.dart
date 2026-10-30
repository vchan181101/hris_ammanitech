import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../theme/app_colors.dart';
import 'modals/kebijakan_broadcast_modal.dart';

class DirekturMandateTab extends StatefulWidget {
  final UserModel user;

  const DirekturMandateTab({super.key, required this.user});

  @override
  State<DirekturMandateTab> createState() => _DirekturMandateTabState();
}

class _DirekturMandateTabState extends State<DirekturMandateTab> {
  final List<Map<String, dynamic>> _inboxItems = [
    {
      'sender': 'M. Rizky Elrivany',
      'role': 'Chief of Enterprise Solution / Dir. GMT',
      'title': 'Laporan Deliverable BAST Proyek IoT KAI Tahap 2',
      'preview': 'Berita Acara Serah Terima (BAST) untuk instalasi sensor smart telemetry stasiun telah ditandatangani oleh pejabat perkeretaapian.',
      'date': 'Hari Ini, 10:15 WIB',
      'isRead': false,
      'color': Colors.indigo,
    },
    {
      'sender': 'Wendy Swandoyo',
      'role': 'Chief of Digital Commerce / Dir. HGT',
      'title': 'Pencapaian SLA 99.98% & Kesiapan Rilis Fitur Loyalty',
      'preview': 'Platform pembayaran QRIS dan modul reward points v2.0 siap diajukan ke tahap produksi setelah lolos penetration test.',
      'date': 'Hari Ini, 09:20 WIB',
      'isRead': false,
      'color': Colors.purple,
    },
    {
      'sender': 'Pirmadi Sukma',
      'role': 'Chief of Railways & Transportation',
      'title': 'Update Zero Accident & K3 Lintasan Proyek Manggarai',
      'preview': 'Seluruh 32 personel teknis lapangan di lintasan stasiun & depo Manggarai beroperasi aman tanpa kendala insiden kerja.',
      'date': 'Kemarin, 16:45 WIB',
      'isRead': true,
      'color': Colors.blue,
    },
    {
      'sender': 'Bachtiar Siagian',
      'role': 'Head of Finance AMANITech Group',
      'title': 'Laporan Finansial Kas & Efisiensi Budget Q1',
      'preview': 'Realisasi anggaran penyerapan biaya operasional berada di level 84% dengan efisiensi penghematan dana taktis Rp 32 jt.',
      'date': 'Kemarin, 14:10 WIB',
      'isRead': true,
      'color': Colors.green,
    },
  ];

  void _openDetail(Map<String, dynamic> item) {
    setState(() => item['isRead'] = true);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 48,
                height: 5,
                decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: (item['color'] as MaterialColor).withValues(alpha: 0.15),
                  child: Text(
                    (item['sender'] as String).substring(0, 2).toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold, color: (item['color'] as MaterialColor)[800], fontSize: 13),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['sender'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Text(item['role'] as String, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Text(item['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary)),
            const SizedBox(height: 6),
            Text('Waktu Terima: ${item['date']}', style: const TextStyle(fontSize: 11, color: AppColors.textHint)),
            const SizedBox(height: 14),
            Text(item['preview'] as String, style: const TextStyle(fontSize: 13, height: 1.5, color: AppColors.textPrimary)),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Tutup Pesan', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => const KebijakanBroadcastModal(),
          );
        },
        backgroundColor: const Color(0xFF0F4C81),
        icon: const Icon(Icons.campaign_rounded, color: Colors.white),
        label: const Text('Siarkan Mandat', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Komunikasi & Mandat Direksi',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                      Text(
                        'Laporan Strategis Para Chief & Mandat Direktur Utama',
                        style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${_inboxItems.where((i) => i['isRead'] == false).length} Baru',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),

            // Messages
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _inboxItems.length,
                itemBuilder: (context, index) {
                  final item = _inboxItems[index];
                  final MaterialColor color = item['color'] as MaterialColor;
                  final bool isRead = item['isRead'] as bool;

                  return InkWell(
                    onTap: () => _openDetail(item),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isRead ? Colors.white : Colors.blue.shade50.withValues(alpha: 0.45),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: isRead ? AppColors.cardBorder : Colors.blue.shade200),
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
                                radius: 18,
                                backgroundColor: color.withValues(alpha: 0.15),
                                child: Text(
                                  (item['sender'] as String).substring(0, 2).toUpperCase(),
                                  style: TextStyle(fontWeight: FontWeight.bold, color: color[800], fontSize: 11),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['sender'] as String,
                                      style: TextStyle(fontWeight: isRead ? FontWeight.w600 : FontWeight.bold, fontSize: 13),
                                    ),
                                    Text(
                                      item['role'] as String,
                                      style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                                    ),
                                  ],
                                ),
                              ),
                              Text(item['date'] as String, style: const TextStyle(fontSize: 10, color: AppColors.textHint)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item['title'] as String,
                            style: TextStyle(
                              fontWeight: isRead ? FontWeight.w600 : FontWeight.bold,
                              fontSize: 14,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['preview'] as String,
                            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.3),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
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
