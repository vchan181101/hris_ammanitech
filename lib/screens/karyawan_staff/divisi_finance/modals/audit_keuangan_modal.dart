import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class AuditKeuanganModal extends StatelessWidget {
  const AuditKeuanganModal({super.key});

  @override
  Widget build(BuildContext context) {
    final auditLogs = [
      {
        'title': 'Audit Pengeluaran Kas Lapangan Proyek Kereta',
        'auditor': 'Bachtiar Siagian & KAP Eksternal',
        'entity': 'PT Global Moviion Teknologi',
        'result': 'Wajar Tanpa Pengecualian (WTP)',
        'date': '15 Maret 2025',
        'color': const Color(0xFF047857),
      },
      {
        'title': 'Uji Petik Bukti Nota Reimbursement Q1 2025',
        'auditor': 'Internal Audit Holding (Finance Team)',
        'entity': 'PT Aman Media Interaktif',
        'result': '100% Nota Fisik Valid Sesuai SOP',
        'date': '10 Maret 2025',
        'color': const Color(0xFF047857),
      },
      {
        'title': 'Pemeriksaan Rekonsiliasi Bank & Kas Masuk',
        'auditor': 'Finance Division Holding',
        'entity': 'PT Hanasta Global Teknologi',
        'result': 'Selisih Rp 0 (Balance)',
        'date': '01 Maret 2025',
        'color': const Color(0xFF0284C7),
      },
    ];

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(20),
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
            width: 44,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.policy_rounded, color: Color(0xFF047857)),
                  SizedBox(width: 8),
                  Text(
                    'Audit & Histori Transaksi HR',
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
          const Divider(),
          const SizedBox(height: 8),

          Expanded(
            child: ListView.separated(
              itemCount: auditLogs.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = auditLogs[index];
                final color = item['color'] as Color;

                return Container(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item['title'] as String,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              item['result'] as String,
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Entitas: ${item['entity']} • Tanggal: ${item['date']}',
                        style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Pelaksana Audit: ${item['auditor']}',
                        style: const TextStyle(fontSize: 11, color: Color(0xFF047857), fontWeight: FontWeight.w500),
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
