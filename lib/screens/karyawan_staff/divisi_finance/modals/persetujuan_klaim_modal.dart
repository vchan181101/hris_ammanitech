import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class PersetujuanKlaimModal extends StatefulWidget {
  const PersetujuanKlaimModal({super.key});

  @override
  State<PersetujuanKlaimModal> createState() => _PersetujuanKlaimModalState();
}

class _PersetujuanKlaimModalState extends State<PersetujuanKlaimModal> {
  final List<Map<String, dynamic>> _claims = [
    {
      'id': 'CLM-GMT-001',
      'title': 'Klaim Pengadaan Sensor IoT & Gateway Site Kereta',
      'applicant': 'M. Jumi\'at Mochtar (IoT Engineer)',
      'company': 'PT Global Moviion Teknologi',
      'amount': 'Rp 3.850.000',
      'verifiedBy': 'Anggun Silvia (Staff Finance)',
      'category': 'Operasional Site / Proyek',
      'status': 'Menunggu Approval Head Finance',
    },
    {
      'id': 'CLM-GMT-002',
      'title': 'Langganan Instance GPU Training Model AI',
      'applicant': 'M Erlan (AI Engineer)',
      'company': 'PT Global Moviion Teknologi',
      'amount': 'Rp 4.200.000',
      'verifiedBy': 'Anggun Silvia (Staff Finance)',
      'category': 'Infrastruktur Cloud',
      'status': 'Menunggu Approval Head Finance',
    },
    {
      'id': 'CLM-HGT-001',
      'title': 'Biaya Jamuan Meeting Klien E-Commerce',
      'applicant': 'Nurandi Marsha (Project Manager)',
      'company': 'PT Hanasta Global Teknologi',
      'amount': 'Rp 1.150.000',
      'verifiedBy': 'Anggun Silvia (Staff Finance)',
      'category': 'Perjalanan Dinas',
      'status': 'Menunggu Approval Head Finance',
    },
  ];

  void _handleApproval(int index, bool approved) {
    setState(() {
      _claims[index]['status'] = approved ? 'Disetujui (Approved)' : 'Ditolak';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          approved
              ? 'Klaim ${_claims[index]['id']} berhasil disetujui untuk pencairan!'
              : 'Klaim ${_claims[index]['id']} ditolak.',
        ),
        backgroundColor: approved ? AppColors.success : AppColors.error,
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
                    Icon(Icons.gavel_rounded, color: Color(0xFF047857)),
                    SizedBox(width: 8),
                    Text(
                      'Persetujuan Klaim Reimbursement',
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
              itemCount: _claims.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = _claims[index];
                final isPending = item['status'] == 'Menunggu Approval Head Finance';

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isPending ? const Color(0xFFA7F3D0) : AppColors.cardBorder,
                    ),
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
                          Text(
                            item['id'],
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF047857)),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: isPending
                                  ? const Color(0xFFFEF3C7)
                                  : (item['status'] == 'Disetujui (Approved)'
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
                                    : (item['status'] == 'Disetujui (Approved)'
                                        ? const Color(0xFF065F46)
                                        : const Color(0xFF991B1B)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['title'],
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${item['applicant']} • ${item['company']}',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.inputBackground,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['amount'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF047857),
                              ),
                            ),
                            Text(
                              'Verifikasi: ${item['verifiedBy']}',
                              style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      if (isPending) ...[
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => _handleApproval(index, false),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.error,
                                  side: const BorderSide(color: AppColors.error),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                child: const Text('Tolak Klaim'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _handleApproval(index, true),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF047857),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                child: const Text('Approve Pencairan'),
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
