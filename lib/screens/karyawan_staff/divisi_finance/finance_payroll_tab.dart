import 'package:flutter/material.dart';
import '../../../models/user_model.dart';
import '../../../theme/app_colors.dart';

class FinancePayrollTab extends StatefulWidget {
  final UserModel user;

  const FinancePayrollTab({super.key, required this.user});

  @override
  State<FinancePayrollTab> createState() => _FinancePayrollTabState();
}

class _FinancePayrollTabState extends State<FinancePayrollTab> {
  String _selectedMonth = 'Maret 2025';

  final List<Map<String, dynamic>> _payrollDrafts = [
    {
      'name': 'M. Jumi\'at Mochtar',
      'nik': 'GMT-003',
      'position': 'IoT Engineer',
      'company': 'PT Global Moviion Teknologi',
      'basicSalary': 'Rp 9.500.000',
      'allowance': 'Rp 3.500.000',
      'overtime': 'Rp 850.000',
      'deductions': '- Rp 650.000',
      'netSalary': 'Rp 13.200.000',
      'status': 'Draft Siap Review',
    },
    {
      'name': 'M Erlan',
      'nik': 'GMT-002',
      'position': 'AI Engineer',
      'company': 'PT Global Moviion Teknologi',
      'basicSalary': 'Rp 10.000.000',
      'allowance': 'Rp 3.800.000',
      'overtime': 'Rp 1.200.000',
      'deductions': '- Rp 700.000',
      'netSalary': 'Rp 14.300.000',
      'status': 'Draft Siap Review',
    },
    {
      'name': 'Mia Aulia',
      'nik': 'AMI-003',
      'position': 'Staff Administrasi Umum',
      'company': 'PT Aman Media Interaktif',
      'basicSalary': 'Rp 6.500.000',
      'allowance': 'Rp 2.000.000',
      'overtime': 'Rp 450.000',
      'deductions': '- Rp 450.000',
      'netSalary': 'Rp 8.500.000',
      'status': 'Draft Siap Review',
    },
    {
      'name': 'Abdul Rajab',
      'nik': 'GMT-005',
      'position': 'Civil Works Engineer',
      'company': 'PT Global Moviion Teknologi',
      'basicSalary': 'Rp 8.800.000',
      'allowance': 'Rp 2.800.000',
      'overtime': 'Rp 600.000',
      'deductions': '- Rp 550.000',
      'netSalary': 'Rp 11.650.000',
      'status': 'Draft Siap Review',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Draft Pengolahan Gaji (Payroll)',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF0F4C81),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.send_rounded, color: Colors.white),
            tooltip: 'Kirim Draft ke Bachtiar Siagian',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Draft Payroll Maret 2025 berhasil dikirim ke Bachtiar Siagian (Head of Finance)!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selector Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Periode Gaji Bulanan', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      SizedBox(height: 2),
                      Text('Pengolahan Data Gaji', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  DropdownButton<String>(
                    value: _selectedMonth,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primary),
                    items: const [
                      DropdownMenuItem(value: 'Maret 2025', child: Text('Maret 2025')),
                      DropdownMenuItem(value: 'Februari 2025', child: Text('Februari 2025')),
                      DropdownMenuItem(value: 'Januari 2025', child: Text('Januari 2025')),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedMonth = val);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              'Rincian Draft Per Karyawan',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 12),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _payrollDrafts.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = _payrollDrafts[index];

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['name']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              Text('${item['position']} • ${item['nik']}', style: const TextStyle(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.accentLight,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(item['status']!, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primary)),
                          ),
                        ],
                      ),
                      const Divider(height: 16),
                      _row('Gaji Pokok', item['basicSalary']!),
                      _row('Tunjangan Jabatan & Project', item['allowance']!),
                      _row('Lembur (Overtime)', item['overtime']!),
                      _row('Potongan BPJS & PPh21', item['deductions']!, isError: true),
                      const Divider(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Take Home Pay:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          Text(item['netSalary']!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.success)),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, {bool isError = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          Text(value, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isError ? AppColors.error : AppColors.textPrimary)),
        ],
      ),
    );
  }
}
