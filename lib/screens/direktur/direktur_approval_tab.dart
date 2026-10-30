import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../theme/app_colors.dart';

class DirekturApprovalTab extends StatefulWidget {
  final UserModel user;

  const DirekturApprovalTab({super.key, required this.user});

  @override
  State<DirekturApprovalTab> createState() => _DirekturApprovalTabState();
}

class _DirekturApprovalTabState extends State<DirekturApprovalTab> {
  final List<Map<String, dynamic>> _approvals = [
    {
      'id': 'BOD-APP-01',
      'title': 'Otorisasi Final Penggajian Bulanan AMANI Tech Group',
      'applicant': 'Bachtiar Siagian (Head of Finance)',
      'entity': 'PT AMI, PT GMT & PT HGT (54 Karyawan)',
      'amount': 'Rp 286.400.000',
      'description': 'Validasi rekapitulasi gaji, lembur teknis, BPJS, dan potongan PPh 21 seluruh grup perusahaan periode berjalan.',
      'type': 'Pencairan Payroll Grup',
      'color': Colors.blue,
      'date': '28 Maret 2025',
    },
    {
      'id': 'BOD-APP-02',
      'title': 'Alokasi Plafon Anggaran Proyek Interlocking Kereta KAI',
      'applicant': 'Pirmadi Sukma (Chief of Railways & Transp.)',
      'entity': 'Lintas Gambir - Manggarai',
      'amount': 'Rp 450.000.000 (Capex Tahap 2)',
      'description': 'Pengadaan modul telemetry IoT & sertifikasi K3 integrasi sinyal stasiun.',
      'type': 'Capex & Budget Proyek',
      'color': Colors.indigo,
      'date': '27 Maret 2025',
    },
    {
      'id': 'BOD-APP-03',
      'title': 'Usulan Pengangkatan Senior Lead & Penyesuaian Grade',
      'applicant': 'Djoko Kiswantoro (Head of HR & GA)',
      'entity': 'Divisi Engineering PT GMT & PT HGT',
      'amount': '2 Personel (M Erlan & M. Dikdo)',
      'description': 'Kenaikan tingkat menjadi Principal Architect atas pencapaian milestone sistem zero-downtime.',
      'type': 'Promosi & Struktur SDM',
      'color': Colors.purple,
      'date': '26 Maret 2025',
    },
    {
      'id': 'BOD-APP-04',
      'title': 'Kontrak Kerjasama Baru B2B Payment Merchant Regional',
      'applicant': 'Wendy Swandoyo (Chief of Digital Commerce)',
      'entity': 'PT Hanasta Global Teknologi',
      'amount': 'Estimasi GMV Rp 1.2 M / Bln',
      'description': 'Perjanjian agregasi gateway QRIS merchant kuliner Jawa Barat.',
      'type': 'Kemitraan Strategis',
      'color': Colors.teal,
      'date': '25 Maret 2025',
    },
  ];

  void _handleDecision(int index, bool isApprove) {
    final item = _approvals[index];
    setState(() {
      _approvals.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isApprove
              ? 'Keputusan Direktur Utama: ${item['title']} BERHASIL DISAHKAN.'
              : 'Keputusan Direktur Utama: ${item['title']} DITOLAK.',
        ),
        backgroundColor: isApprove ? AppColors.success : AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: AppColors.cardBorder)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Pusat Otorisasi Direksi',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                      Text(
                        'Persetujuan Strategis Tingkat Direktur Utama',
                        style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${_approvals.length} Berkas Pending',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ),

            // Approvals List
            Expanded(
              child: _approvals.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.check_circle_outline_rounded, color: Colors.green, size: 54),
                          SizedBox(height: 12),
                          Text(
                            'Seluruh Pengajuan Strategis Telah Ditindaklanjuti',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Tidak ada dokumen yang menunggu otorisasi Direktur Utama.',
                            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _approvals.length,
                      itemBuilder: (context, index) {
                        final item = _approvals[index];
                        final MaterialColor color = item['color'] as MaterialColor;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.cardBorder),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.02),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: color.withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      item['type'] as String,
                                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color[800]),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(item['date'] as String, style: const TextStyle(fontSize: 10, color: AppColors.textHint)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item['title'] as String,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Pemohon: ${item['applicant']} | ${item['entity']}',
                                style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Nilai / Implikasi: ${item['amount']}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF0F4C81)),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                item['description'] as String,
                                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.3),
                              ),
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () => _handleDecision(index, false),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: AppColors.error,
                                        side: const BorderSide(color: AppColors.error),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      ),
                                      child: const Text('Tolak'),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () => _handleDecision(index, true),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.success,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      ),
                                      child: const Text('Sahkan / Setujui', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
