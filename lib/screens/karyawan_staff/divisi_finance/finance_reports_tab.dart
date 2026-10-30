import 'package:flutter/material.dart';
import '../../../models/user_model.dart';
import '../../../theme/app_colors.dart';

class FinanceReportsTab extends StatelessWidget {
  final UserModel user;

  const FinanceReportsTab({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> reportTypes = [
      {
        'title': 'Laporan Realisasi Reimbursement Karyawan',
        'subtitle': 'Rekap nota klaim disetujui bulan berjalan per divisi',
        'icon': Icons.receipt_long_rounded,
        'format': 'Excel (.xlsx) / PDF',
      },
      {
        'title': 'Laporan Draft Roll Gaji & Transfer Bank',
        'subtitle': 'Rekap komponen Gaji Pokok, Tunjangan, & Insentif',
        'icon': Icons.payments_rounded,
        'format': 'PDF / CSV Bank Transfer',
      },
      {
        'title': 'Buku Kas Kecil Operasional (Petty Cash)',
        'subtitle': 'Catatan transaksi kas kecil kantor Finance & GA',
        'icon': Icons.account_balance_wallet_rounded,
        'format': 'Excel (.xlsx)',
      },
      {
        'title': 'Laporan Budgeting Project (GMT & HGT)',
        'subtitle': 'Realisasi anggaran proyek IoT, AI, & Digital Commerce',
        'icon': Icons.pie_chart_rounded,
        'format': 'PDF Executive Summary',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Laporan Keuangan & Export Data',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF7C3AED),
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: reportTypes.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final report = reportTypes[index];

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7C3AED).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(report['icon'] as IconData, color: const Color(0xFF7C3AED), size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report['title']!,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        report['subtitle']!,
                        style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Format: ${report['format']}',
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF7C3AED)),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.file_download_outlined, color: Color(0xFF7C3AED)),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Mengunduh ${report['title']}...'),
                        backgroundColor: const Color(0xFF7C3AED),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
