import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class PersetujuanStrategisModal extends StatefulWidget {
  const PersetujuanStrategisModal({super.key});

  @override
  State<PersetujuanStrategisModal> createState() => _PersetujuanStrategisModalState();
}

class _PersetujuanStrategisModalState extends State<PersetujuanStrategisModal> {
  final List<Map<String, dynamic>> _strategicItems = [
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
    final item = _strategicItems[index];
    setState(() {
      _strategicItems.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isApprove
              ? 'Keputusan Direksi: ${item['title']} BERHASIL DISETUJUI & DISAHKAN.'
              : 'Keputusan Direksi: ${item['title']} DITOLAK.',
        ),
        backgroundColor: isApprove ? AppColors.success : AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );

    if (_strategicItems.isEmpty) {
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 48,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.verified_user_rounded, color: Colors.orange, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Persetujuan Strategis Direksi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'Otorisasi tingkat Direktur Utama (${_strategicItems.length} Pengajuan Pending)',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
                ),
              ],
            ),
            const SizedBox(height: 18),

            if (_strategicItems.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 36),
                child: Center(
                  child: Column(
                    children: const [
                      Icon(Icons.check_circle_outline_rounded, color: Colors.green, size: 48),
                      SizedBox(height: 12),
                      Text(
                        'Semua pengajuan strategis telah selesai ditindaklanjuti!',
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                    ],
                  ),
                ),
              )
            else
              ...List.generate(_strategicItems.length, (index) {
                final item = _strategicItems[index];
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
                        blurRadius: 8,
                        offset: const Offset(0, 3),
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
              }),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
