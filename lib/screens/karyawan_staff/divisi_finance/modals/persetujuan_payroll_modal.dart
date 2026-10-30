import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class PersetujuanPayrollModal extends StatefulWidget {
  const PersetujuanPayrollModal({super.key});

  @override
  State<PersetujuanPayrollModal> createState() => _PersetujuanPayrollModalState();
}

class _PersetujuanPayrollModalState extends State<PersetujuanPayrollModal> {
  bool _isApproved = false;

  final List<Map<String, dynamic>> _entitiesPayroll = [
    {
      'company': 'PT Aman Media Interaktif (Holding)',
      'count': '18 Karyawan',
      'gross': 'Rp 95.400.000',
      'deductions': 'Rp 8.600.000',
      'net': 'Rp 86.800.000',
    },
    {
      'company': 'PT Global Moviion Teknologi',
      'count': '20 Karyawan',
      'gross': 'Rp 121.800.000',
      'deductions': 'Rp 12.100.000',
      'net': 'Rp 109.700.000',
    },
    {
      'company': 'PT Hanasta Global Teknologi',
      'count': '12 Karyawan',
      'gross': 'Rp 78.100.000',
      'deductions': 'Rp 7.800.000',
      'net': 'Rp 70.300.000',
    },
  ];

  @override
  Widget build(BuildContext context) {
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
                  Icon(Icons.payments_rounded, color: Color(0xFF047857)),
                  SizedBox(width: 8),
                  Text(
                    'Persetujuan Payroll Bulanan',
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

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF065F46), Color(0xFF047857)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Total Payroll Bersih (Grup)', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    SizedBox(height: 4),
                    Text(
                      'Rp 266.800.000',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text('Periode: Maret 2025 • 50 Karyawan', style: TextStyle(color: Colors.white70, fontSize: 11)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _isApproved ? 'Telah Disetujui' : 'Menunggu Validasi',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          Expanded(
            child: ListView.separated(
              itemCount: _entitiesPayroll.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = _entitiesPayroll[index];
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item['company'],
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ),
                          Text(item['count'], style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Bruto: ${item['gross']}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                          Text('Potongan: ${item['deductions']}', style: const TextStyle(fontSize: 11, color: AppColors.error)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Netto: ${item['net']}',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF047857)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 14),

          if (!_isApproved)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() => _isApproved = true);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Payroll periode Maret 2025 telah divalidasi dan disetujui! Instruksi transfer diteruskan ke Bank.'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                },
                icon: const Icon(Icons.check_circle_rounded),
                label: const Text('Validasi & Approve Pencairan Payroll'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF047857),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
