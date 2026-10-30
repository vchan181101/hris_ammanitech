import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class ExecutiveApprovalModal extends StatefulWidget {
  const ExecutiveApprovalModal({super.key});

  @override
  State<ExecutiveApprovalModal> createState() => _ExecutiveApprovalModalState();
}

class _ExecutiveApprovalModalState extends State<ExecutiveApprovalModal> {
  final List<Map<String, dynamic>> _approvals = [
    {
      'id': 'APP-GMT-01',
      'applicant': 'Rivano',
      'position': 'Customer Account Manager',
      'type': 'Klaim Operasional / Entertainment Client',
      'amount': 'Rp 2.450.000',
      'description': 'Meeting koordinasi & penyerahan BAST project IoT dengan Direksi PT KAI di Gambir.',
      'date': '27 Maret 2025',
      'status': 'Pending',
      'icon': Icons.receipt_long_rounded,
      'color': Colors.blue,
    },
    {
      'id': 'APP-GMT-02',
      'applicant': 'Pirmadi Sukma',
      'position': 'Chief of Railways & Transp. (Project Collab)',
      'type': 'Pengajuan Dinas Lapangan & Mobilisasi',
      'amount': 'Rp 4.800.000',
      'description': 'Survei jalur depo dan sensor lintasan LRT Jabodebek - 4 Engineer tim GMT & R&T.',
      'date': '26 Maret 2025',
      'status': 'Pending',
      'icon': Icons.commute_rounded,
      'color': Colors.indigo,
    },
    {
      'id': 'APP-GMT-03',
      'applicant': 'M Erlan',
      'position': 'AI Engineer Lead',
      'type': 'Pengajuan Cuti Tahunan',
      'amount': '3 Hari Kerja (2 - 4 April 2025)',
      'description': 'Cuti tahunan keperluan keluarga (telah didelegasikan ke AI Engineer junior).',
      'date': '28 Maret 2025',
      'status': 'Pending',
      'icon': Icons.event_available_rounded,
      'color': Colors.purple,
    },
  ];

  void _handleDecision(int index, bool isApprove) {
    final item = _approvals[index];
    setState(() {
      _approvals.removeAt(index);
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

    if (_approvals.isEmpty) {
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    color: Colors.amber.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.verified_user_rounded, color: Colors.orange, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Executive Approval Center',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'Persetujuan level Head & Manager (${_approvals.length} Berkas)',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
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

            if (_approvals.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 36),
                child: Center(
                  child: Column(
                    children: const [
                      Icon(Icons.check_circle_outline_rounded, color: Colors.green, size: 48),
                      SizedBox(height: 12),
                      Text(
                        'Semua berkas pengajuan telah ditindaklanjuti!',
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                    ],
                  ),
                ),
              )
            else
              ...List.generate(_approvals.length, (index) {
                final item = _approvals[index];
                final MaterialColor color = item['color'] as MaterialColor;
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: color.withValues(alpha: 0.15),
                            child: Icon(item['icon'] as IconData, color: color[800], size: 18),
                          ),
                          const SizedBox(width: 10),
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
                              item['id'] as String,
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
                        'Nominal / Durasi: ${item['amount']}',
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.primary),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['description'] as String,
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.3),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Diajukan: ${item['date']}',
                        style: const TextStyle(fontSize: 10, color: AppColors.textHint),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => _handleDecision(index, false),
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
                              onPressed: () => _handleDecision(index, true),
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
              }),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
