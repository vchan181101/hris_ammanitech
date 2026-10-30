import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class PersetujuanCutiModal extends StatefulWidget {
  const PersetujuanCutiModal({super.key});

  @override
  State<PersetujuanCutiModal> createState() => _PersetujuanCutiModalState();
}

class _PersetujuanCutiModalState extends State<PersetujuanCutiModal> {
  final List<Map<String, dynamic>> _approvalList = [
    {
      'id': 'APV-001',
      'name': 'M. Rizky Elrivany',
      'position': 'Direktur PT Global Moviion Teknologi',
      'company': 'PT Global Moviion Teknologi',
      'type': 'Cuti Tahunan Manajerial (3 Hari)',
      'date': '24 Mar 2025 - 26 Mar 2025',
      'reason': 'Keperluan keluarga dan mendampingi wisuda anak.',
      'status': 'Menunggu Approval Head HR',
    },
    {
      'id': 'APV-002',
      'name': 'Nurandi Marsha',
      'position': 'Project Manager',
      'company': 'PT Hanasta Global Teknologi',
      'type': 'Izin Khusus / Menikah (3 Hari)',
      'date': '18 Apr 2025 - 20 Apr 2025',
      'reason': 'Cuti pernikahan resmi sesuai Peraturan Perusahaan.',
      'status': 'Menunggu Approval Head HR',
    },
    {
      'id': 'APV-003',
      'name': 'Anggun Silvia',
      'position': 'Staff Finance',
      'company': 'PT Aman Media Interaktif',
      'type': 'Cuti Tahunan (2 Hari)',
      'date': '10 Apr 2025 - 11 Apr 2025',
      'reason': 'Telah diverifikasi berkas oleh Mia Aulia (Staff HR).',
      'status': 'Menunggu Approval Head HR',
    },
  ];

  void _handleAction(int index, bool approved) {
    final item = _approvalList[index];
    setState(() {
      item['status'] = approved ? 'Disetujui Head of HR & GA' : 'Ditolak';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          approved
              ? 'Pengajuan cuti ${item['name']} telah disetujui!'
              : 'Pengajuan cuti ${item['name']} ditolak.',
        ),
        backgroundColor: approved ? AppColors.success : AppColors.error,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    Icon(Icons.gavel_rounded, color: Color(0xFF0F4C81)),
                    SizedBox(width: 8),
                    Text(
                      'Persetujuan Akhir Cuti / Izin',
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
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _approvalList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = _approvalList[index];
                final isPending = item['status'] == 'Menunggu Approval Head HR';

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isPending ? const Color(0xFFBAE6FD) : AppColors.cardBorder,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
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
                            item['id'],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F4C81),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: isPending
                                  ? const Color(0xFFFEF3C7)
                                  : (item['status'].toString().contains('Disetujui')
                                      ? const Color(0xFFD1FAE5)
                                      : const Color(0xFFFEE2E2)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              item['status'],
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: isPending
                                    ? const Color(0xFFB45309)
                                    : (item['status'].toString().contains('Disetujui')
                                        ? const Color(0xFF065F46)
                                        : const Color(0xFF991B1B)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['name'],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        '${item['position']} • ${item['company']}',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.inputBackground,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['type'],
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F4C81),
                              ),
                            ),
                            Text('Tanggal: ${item['date']}', style: const TextStyle(fontSize: 12)),
                            const SizedBox(height: 4),
                            Text('Alasan: ${item['reason']}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                      if (isPending) ...[
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => _handleAction(index, false),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.error,
                                  side: const BorderSide(color: AppColors.error),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                child: const Text('Tolak'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _handleAction(index, true),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0F4C81),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                child: const Text('Setujui (Approve)'),
                              ),
                            ),
                          ],
                        ),
                      ],
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
