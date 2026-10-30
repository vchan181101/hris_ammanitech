import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class KebijakanDokumenModal extends StatelessWidget {
  const KebijakanDokumenModal({super.key});

  @override
  Widget build(BuildContext context) {
    final policyDocs = [
      {
        'title': 'SOP Presensi, Jam Kerja & Lembur 2025',
        'code': 'SOP-HR-001/AMI/2025',
        'category': 'Standard Operating Procedure (SOP)',
        'updated': '02 Januari 2025',
        'size': '2.4 MB PDF',
      },
      {
        'title': 'Peraturan Perusahaan (PP) AMANI Tech Group',
        'code': 'PP-CORP-2024-2026',
        'category': 'Kebijakan Ketenagakerjaan',
        'updated': 'Disahkan Disnaker',
        'size': '4.1 MB PDF',
      },
      {
        'title': 'Template Kontrak Kerja PKWT Engineering',
        'code': 'TPL-HR-PKWT-ENG-V2',
        'category': 'Contract Template',
        'updated': '15 Februari 2025',
        'size': '540 KB DOCX',
      },
      {
        'title': 'Panduan Keselamatan & Kesehatan Kerja (K3) Site',
        'code': 'K3-GA-SITE-004',
        'category': 'General Affairs & Site Safety',
        'updated': '10 Januari 2025',
        'size': '1.8 MB PDF',
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
                  Icon(Icons.policy_rounded, color: Color(0xFF0F4C81)),
                  SizedBox(width: 8),
                  Text(
                    'Kebijakan & SOP Perusahaan',
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
              itemCount: policyDocs.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = policyDocs[index];

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
                          color: const Color(0xFFE0F2FE),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.picture_as_pdf_rounded,
                          color: Color(0xFF0284C7),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'] as String,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${item['code']} • ${item['category']}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF0F4C81),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Update: ${item['updated']} • ${item['size']}',
                              style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.download_rounded, color: Color(0xFF0F4C81)),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Mengunduh dokumen ${item['title']}...'),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                        },
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
