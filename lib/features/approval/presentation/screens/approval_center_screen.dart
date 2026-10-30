import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../auth/data/models/user_model.dart';

class ApprovalCenterScreen extends StatefulWidget {
  final UserModel user;

  const ApprovalCenterScreen({super.key, required this.user});

  @override
  State<ApprovalCenterScreen> createState() => _ApprovalCenterScreenState();
}

class _ApprovalCenterScreenState extends State<ApprovalCenterScreen> {
  final List<Map<String, dynamic>> _pendingApprovals = [
    {
      'title': 'Pengajuan Cuti Tahunan (3 Hari)',
      'applicant': 'M. Jumi\'at Mochtar',
      'position': 'IoT Engineer (PT GMT)',
      'category': 'Cuti / Izin',
      'date': '10 Mar 2025',
      'detail': 'Tanggal 12 Mar - 14 Mar 2025 (Keperluan keluarga)',
    },
    {
      'title': 'Klaim Reimbursement Sensor IoT',
      'applicant': 'M. Jumi\'at Mochtar',
      'position': 'IoT Engineer (PT GMT)',
      'category': 'Reimbursement',
      'date': '10 Mar 2025',
      'detail': 'Nominal: Rp 3.850.000 (Struk terlampir)',
    },
    {
      'title': 'Klaim Cloud GPU Training Model AI',
      'applicant': 'M Erlan',
      'position': 'AI Engineer (PT GMT)',
      'category': 'Reimbursement',
      'date': '09 Mar 2025',
      'detail': 'Nominal: Rp 4.200.000 (Invoice AWS terlampir)',
    },
    {
      'title': 'Draft Payroll Bulan Maret 2025',
      'applicant': 'Anggun Silvia (Staff Finance)',
      'position': 'Finance & Accounting',
      'category': 'Payroll',
      'date': '08 Mar 2025',
      'detail': 'Total Rp 185.000.000 (50 Karyawan Group)',
    },
  ];

  void _actionApproval(int index, bool isApproved) {
    final item = _pendingApprovals[index];
    setState(() {
      _pendingApprovals.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isApproved
              ? '${item['title']} oleh ${item['applicant']} berhasil DISETUJUI!'
              : '${item['title']} telah DIKEMBALIKAN untuk revisi.',
        ),
        backgroundColor: isApproved ? AppColors.success : AppColors.warning,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Pusat Persetujuan (Approval Center)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Approval Header Banner
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryDark, AppColors.primary],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.verified_user_rounded, color: Colors.white, size: 36),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Peninjau: ${widget.user.name}', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('${widget.user.position} • ${widget.user.company}', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text(
              'Menunggu Persetujuan Anda (${_pendingApprovals.length})',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 12),

            if (_pendingApprovals.isEmpty)
              Container(
                padding: const EdgeInsets.all(32),
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.cardBorder)),
                child: const Column(
                  children: [
                    Icon(Icons.check_circle_outline_rounded, color: AppColors.success, size: 48),
                    SizedBox(height: 12),
                    Text('Semua Pengajuan Telah Selesai Diproses!', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                    SizedBox(height: 4),
                    Text('Tidak ada dokumen yang memerlukan persetujuan saat ini.', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _pendingApprovals.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = _pendingApprovals[index];

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
                            Text(item['category']!, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary)),
                            Text(item['date']!, style: const TextStyle(fontSize: 10, color: AppColors.textHint)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(item['title']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                        const SizedBox(height: 2),
                        Text('${item['applicant']} • ${item['position']}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                        const SizedBox(height: 6),
                        Text(item['detail']!, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => _actionApproval(index, false),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: AppColors.warning),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                child: const Text('Tolak / Revisi', style: TextStyle(color: AppColors.warning, fontSize: 12, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _actionApproval(index, true),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.success,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                child: const Text('Setujui (Approve)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              ),
                            ),
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
}
