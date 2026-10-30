import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class KalkulasiPayrollModal extends StatefulWidget {
  const KalkulasiPayrollModal({super.key});

  @override
  State<KalkulasiPayrollModal> createState() => _KalkulasiPayrollModalState();
}

class _KalkulasiPayrollModalState extends State<KalkulasiPayrollModal> {
  final List<Map<String, dynamic>> _payrollSummary = [
    {
      'title': 'Gaji Pokok & Tunjangan Tetap',
      'holding': 'Rp 85.000.000',
      'gmt': 'Rp 115.000.000',
      'hgt': 'Rp 75.000.000',
      'total': 'Rp 275.000.000',
      'status': 'Terverifikasi HR',
    },
    {
      'title': 'Kompensasi Lembur (Overtime)',
      'holding': 'Rp 2.400.000',
      'gmt': 'Rp 6.800.000',
      'hgt': 'Rp 3.100.000',
      'total': 'Rp 12.300.000',
      'status': 'Siap Validasi',
    },
    {
      'title': 'Potongan BPJS (Ketenagakerjaan & Kesehatan)',
      'holding': '- Rp 3.400.000',
      'gmt': '- Rp 4.600.000',
      'hgt': '- Rp 3.000.000',
      'total': '- Rp 11.000.000',
      'status': 'Otomatis Sistem',
    },
    {
      'title': 'Potongan PPh 21 (Pajak Karyawan)',
      'holding': '- Rp 5.200.000',
      'gmt': '- Rp 7.500.000',
      'hgt': '- Rp 4.800.000',
      'total': '- Rp 17.500.000',
      'status': 'Sesuai Tarif Efektif (TER)',
    },
  ];

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
                    Icon(Icons.calculate_rounded, color: Color(0xFF059669)),
                    SizedBox(width: 8),
                    Text(
                      'Kalkulasi Payroll & Potongan',
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

          // Header summary box
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFECFDF5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFA7F3D0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Estimasi Penggajian Bersih Group',
                        style: TextStyle(fontSize: 12, color: Color(0xFF065F46)),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Rp 258.800.000',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF047857),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF059669),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '78% Siap',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _payrollSummary.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = _payrollSummary[index];
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
                              item['title'],
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              item['status'],
                              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('PT AMI: ${item['holding']}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                          Text('PT GMT: ${item['gmt']}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                          Text('PT HGT: ${item['hgt']}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Total: ${item['total']}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF059669),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
