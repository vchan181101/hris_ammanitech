import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../theme/app_colors.dart';

class EssInboxTab extends StatefulWidget {
  final UserModel user;

  const EssInboxTab({super.key, required this.user});

  @override
  State<EssInboxTab> createState() => _EssInboxTabState();
}

class _EssInboxTabState extends State<EssInboxTab> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'Pengumuman Holding AMANI Tech Group',
      'body': 'Informasi jadwal libur bersama dan penyesuaian jam kerja bulan Ramadhan 1446 H.',
      'time': '10 Mar, 09:00 WIB',
      'type': 'Announcement',
      'isUnread': true,
      'icon': Icons.campaign_rounded,
      'color': Colors.blue,
    },
    {
      'title': 'Pengajuan Cuti Disetujui',
      'body': 'Pengajuan cuti tahunan Anda (12 Mar 2025) telah disetujui oleh Djoko Kiswantoro (Head of HR).',
      'time': '09 Mar, 15:30 WIB',
      'type': 'Approval',
      'isUnread': true,
      'icon': Icons.check_circle_rounded,
      'color': AppColors.success,
    },
    {
      'title': 'Klaim Reimbursement Diproses',
      'body': 'Klaim pengeluaran "BBM & Transport Client" sebesar Rp 450.000 telah diverifikasi oleh Finance (Bachtiar Siagian).',
      'time': '08 Mar, 11:20 WIB',
      'type': 'Finance',
      'isUnread': false,
      'icon': Icons.payments_rounded,
      'color': Colors.purple,
    },
    {
      'title': 'Pengingat Presensi Masuk',
      'body': 'Jangan lupa untuk melakukan Clock In selfie & lokasi GPS sebelum jam 08:30 WIB.',
      'time': '08 Mar, 08:00 WIB',
      'type': 'Reminder',
      'isUnread': false,
      'icon': Icons.alarm_rounded,
      'color': AppColors.warning,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Pusat Notifikasi & Kotak Masuk',
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
            icon: const Icon(Icons.done_all_rounded, color: Colors.white),
            tooltip: 'Tandai Semua Dibaca',
            onPressed: () {
              setState(() {
                for (var item in _notifications) {
                  item['isUnread'] = false;
                }
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Semua notifikasi ditandai telah dibaca'),
                  backgroundColor: AppColors.primary,
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _notifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = _notifications[index];
          final bool unread = item['isUnread'] == true;

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: unread ? AppColors.accentLight.withValues(alpha: 0.3) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: unread ? AppColors.primary.withValues(alpha: 0.3) : AppColors.cardBorder,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: (item['color'] as Color).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: item['color'] as Color,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item['title']!,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: unread ? FontWeight.bold : FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          if (unread)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['body']!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['time']!,
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.textHint,
                          fontWeight: FontWeight.w500,
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
    );
  }
}
