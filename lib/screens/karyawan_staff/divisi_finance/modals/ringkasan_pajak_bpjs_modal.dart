import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class RingkasanPajakBpjsModal extends StatelessWidget {
  const RingkasanPajakBpjsModal({super.key});

  @override
  Widget build(BuildContext context) {
    final taxBpjsList = [
      {
        'title': 'PPh 21 (Pajak Penghasilan Karyawan)',
        'nominal': 'Rp 17.500.000',
        'deadline': '10 April 2025 (e-Billing DJP)',
        'status': 'Siap Bayar & Lapor',
        'isCompliant': true,
      },
      {
        'title': 'BPJS Ketenagakerjaan (JKK, JKM, JHT, JP)',
        'nominal': 'Rp 8.200.000',
        'deadline': '15 April 2025 (SIPP Online)',
        'status': 'Terverifikasi Sesuai Data HR',
        'isCompliant': true,
      },
      {
        'title': 'BPJS Kesehatan (4% Perusahaan, 1% Karyawan)',
        'nominal': 'Rp 4.900.000',
        'deadline': '10 April 2025 (Edabu BPJS)',
        'status': 'Sinkronisasi 50 Karyawan OK',
        'isCompliant': true,
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
                  Icon(Icons.account_balance_rounded, color: Color(0xFF047857)),
                  SizedBox(width: 8),
                  Text(
                    'Kepatuhan Pajak & BPJS',
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
              itemCount: taxBpjsList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = taxBpjsList[index];

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
                              color: const Color(0xFFD1FAE5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Taat Regulasi',
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF047857)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Nominal: ${item['nominal']}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF047857),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Batas Waktu: ${item['deadline']}',
                        style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                      ),
                      Text(
                        'Status: ${item['status']}',
                        style: const TextStyle(fontSize: 11, color: Color(0xFF0284C7), fontWeight: FontWeight.w500),
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
