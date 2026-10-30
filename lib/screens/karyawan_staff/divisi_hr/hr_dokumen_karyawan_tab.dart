import 'package:flutter/material.dart';
import '../../../models/user_model.dart';
import '../../../theme/app_colors.dart';
import 'modals/tambah_karyawan_modal.dart';

class HrDokumenKaryawanTab extends StatelessWidget {
  final UserModel user;

  const HrDokumenKaryawanTab({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> employeeDocs = [
      {
        'name': 'M. Jumi\'at Mochtar',
        'nik': 'GMT-003',
        'position': 'IoT Engineer',
        'company': 'PT Global Moviion Teknologi',
        'status': 'PKWTT (Karyawan Tetap)',
        'contractDate': '01 Jan 2023 - Permanen',
        'docs': ['Surat_Perjanjian_Kerja_GMT003.pdf', 'KTP_NPWP.pdf', 'Sertifikat_IoT_Embedded.pdf'],
      },
      {
        'name': 'M Erlan',
        'nik': 'GMT-002',
        'position': 'AI Engineer',
        'company': 'PT Global Moviion Teknologi',
        'status': 'PKWT (Kontrak 2 Tahun)',
        'contractDate': '01 Jul 2023 - 30 Jun 2025',
        'docs': ['Kontrak_Kerja_PKWT_GMT002.pdf', 'KTP_NPWP.pdf'],
      },
      {
        'name': 'Anggun Silvia',
        'nik': 'AMI-005',
        'position': 'Staff Finance',
        'company': 'PT Aman Media Interaktif',
        'status': 'PKWTT (Karyawan Tetap)',
        'contractDate': '15 Mar 2022 - Permanen',
        'docs': ['SK_Pengangkatan_Tetap_AMI005.pdf', 'KTP_Brevet_Finance.pdf'],
      },
      {
        'name': 'Abdul Rajab',
        'nik': 'GMT-005',
        'position': 'Civil Works Engineer',
        'company': 'PT Global Moviion Teknologi',
        'status': 'PKWT (Kontrak 1 Tahun)',
        'contractDate': '01 Okt 2024 - 30 Sep 2025',
        'docs': ['Kontrak_PKWT_Civil_GMT005.pdf', 'KTP_Sertifikat_K3.pdf'],
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Direktori & Dokumen Kontrak (PKWT)',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFD97706),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_rounded, color: Colors.white),
            tooltip: 'Tambah Data Karyawan',
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const TambahKaryawanModal(),
              );
            },
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: employeeDocs.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final emp = employeeDocs[index];
          final List<String> docs = List<String>.from(emp['docs']);

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
                        Text(emp['name']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        Text('${emp['position']} • ${emp['nik']}', style: const TextStyle(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.accentLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(emp['status']!, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primary)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text('Masa Kontrak: ${emp['contractDate']}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                const Divider(height: 16),
                const Text('File Dokumen Terlampir:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Column(
                  children: docs.map((docName) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          const Icon(Icons.picture_as_pdf_rounded, size: 14, color: AppColors.error),
                          const SizedBox(width: 6),
                          Expanded(child: Text(docName, style: const TextStyle(fontSize: 11, color: AppColors.textPrimary))),
                          const Icon(Icons.download_rounded, size: 14, color: AppColors.primary),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
