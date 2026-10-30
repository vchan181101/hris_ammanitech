import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class RiwayatPembayaranModal extends StatelessWidget {
  const RiwayatPembayaranModal({super.key});

  @override
  Widget build(BuildContext context) {
    final payments = [
      {
        'title': 'Pencairan Reimbursement Sensor IoT Site',
        'recipient': 'M. Jumi\'at Mochtar (PT GMT)',
        'amount': 'Rp 3.850.000',
        'date': '14 Maret 2025 • Bank Mandiri',
        'ref': 'TRX-REF-9921',
        'type': 'Reimbursement',
      },
      {
        'title': 'Pencairan Klaim Tiket Kereta Dinas Site',
        'recipient': 'Abdul Rajab (PT GMT)',
        'amount': 'Rp 1.450.000',
        'date': '12 Maret 2025 • BCA',
        'ref': 'TRX-REF-9918',
        'type': 'Reimbursement',
      },
      {
        'title': 'Transfer Payroll Gaji Periode Februari 2025',
        'recipient': 'Seluruh Karyawan Group (50 Akun)',
        'amount': 'Rp 248.500.000',
        'date': '25 Februari 2025 • Payroll Batch',
        'ref': 'PAYROLL-FEB-AMI',
        'type': 'Gaji Bulanan',
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
                  Icon(Icons.receipt_long_rounded, color: Color(0xFF059669)),
                  SizedBox(width: 8),
                  Text(
                    'Riwayat Transfer & Pembayaran',
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
              itemCount: payments.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = payments[index];
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
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD1FAE5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.check_circle_rounded, color: Color(0xFF059669), size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title']!,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item['recipient']!,
                              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item['amount']!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF059669),
                                  ),
                                ),
                                Text(
                                  item['ref']!,
                                  style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                                ),
                              ],
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
