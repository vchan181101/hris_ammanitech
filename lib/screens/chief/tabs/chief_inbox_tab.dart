import 'package:flutter/material.dart';
import '../../../../models/user_model.dart';
import '../../../../theme/app_colors.dart';

class ChiefInboxTab extends StatefulWidget {
  final UserModel user;

  const ChiefInboxTab({super.key, required this.user});

  @override
  State<ChiefInboxTab> createState() => _ChiefInboxTabState();
}

class _ChiefInboxTabState extends State<ChiefInboxTab> {
  final List<Map<String, dynamic>> _messages = [
    {
      'id': 'DIR-001',
      'sender': 'Dimas Pasurangga',
      'senderRole': 'Direktur Utama AMANITech Group',
      'title': 'Instruksi Rapat Direksi & Review Q1 2025',
      'body': 'Mohon persiapkan rangkuman utilisasi resource proyek enterprise, SLA platform digital commerce, dan kesiapan serah terima BAST perkeretaapian sebelum rapat direksi Senin depan jam 09:00 WIB.',
      'priority': 'Sangat Penting / Urgent',
      'date': 'Hari ini, 08:30 WIB',
      'isRead': false,
      'isInstruction': true,
      'color': Colors.red,
    },
    {
      'id': 'REP-002',
      'sender': 'Sistem HR & Presensi Otomatis',
      'senderRole': 'AMANI Core HRIS',
      'title': 'Laporan Presensi Harian Tim Teknis Lapangan',
      'body': 'Tingkat kehadiran tim teknis GMT & Transportasi mencapai 96.2%. Sebanyak 32 personel on-site telah melakukan geofence clock-in.',
      'priority': 'Laporan Rutin',
      'date': 'Hari ini, 08:00 WIB',
      'isRead': false,
      'isInstruction': false,
      'color': Colors.blue,
    },
    {
      'id': 'PMO-003',
      'sender': 'Nurandi Marsha (PM)',
      'senderRole': 'Project Management Office HGT',
      'title': 'Eskalasi Integrasi Merchant Payment Gateway',
      'body': 'Integrasi 50 merchant kuliner Bandung telah rampung di environment staging. Menunggu otorisasi peluncuran ke production cluster.',
      'priority': 'Eskalasi Proyek',
      'date': 'Kemarin, 17:15 WIB',
      'isRead': true,
      'isInstruction': false,
      'color': Colors.purple,
    },
    {
      'id': 'FIN-004',
      'sender': 'Bachtiar Siagian',
      'senderRole': 'Head of Finance AMANITech',
      'title': 'Pemberitahuan Pencairan Reimbursement Operasional',
      'body': 'Klaim operasional lapangan yang telah Anda setujui minggu lalu sebesar Rp 14.850.000 telah selesai ditransfer ke rekening engineer bersangkutan.',
      'priority': 'Finance Update',
      'date': 'Kemarin, 14:20 WIB',
      'isRead': true,
      'isInstruction': false,
      'color': Colors.green,
    },
  ];

  void _showMessageDetail(Map<String, dynamic> msg) {
    setState(() {
      msg['isRead'] = true;
    });

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
                  backgroundColor: (msg['color'] as MaterialColor).withValues(alpha: 0.15),
                  child: Icon(
                    msg['isInstruction'] == true ? Icons.campaign_rounded : Icons.mail_rounded,
                    color: (msg['color'] as MaterialColor)[800],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(msg['sender'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Text(msg['senderRole'] as String, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: (msg['color'] as MaterialColor).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    msg['priority'] as String,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: (msg['color'] as MaterialColor)[800]),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Text(msg['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary)),
            const SizedBox(height: 6),
            Text('Diterima: ${msg['date']}', style: const TextStyle(fontSize: 11, color: AppColors.textHint)),
            const SizedBox(height: 14),
            Text(msg['body'] as String, style: const TextStyle(fontSize: 13, height: 1.5, color: AppColors.textPrimary)),
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
                        'Kotak Masuk Eksekutif',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                      Text(
                        'Instruksi Direktur Utama, Laporan Proyek & Notifikasi',
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
                      '${_messages.where((m) => m['isRead'] == false).length} Belum Dibaca',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),

            // Messages List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  final MaterialColor color = msg['color'] as MaterialColor;
                  final bool isRead = msg['isRead'] as bool;

                  return InkWell(
                    onTap: () => _showMessageDetail(msg),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isRead ? Colors.white : Colors.blue.shade50.withValues(alpha: 0.5),
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
                                child: Icon(
                                  msg['isInstruction'] == true ? Icons.campaign_rounded : Icons.mail_outline_rounded,
                                  color: color[800],
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      msg['sender'] as String,
                                      style: TextStyle(
                                        fontWeight: isRead ? FontWeight.w600 : FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      msg['senderRole'] as String,
                                      style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                msg['date'] as String,
                                style: const TextStyle(fontSize: 10, color: AppColors.textHint),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            msg['title'] as String,
                            style: TextStyle(
                              fontWeight: isRead ? FontWeight.w600 : FontWeight.bold,
                              fontSize: 14,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            msg['body'] as String,
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
