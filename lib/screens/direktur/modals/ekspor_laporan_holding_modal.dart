import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class EksporLaporanHoldingModal extends StatefulWidget {
  const EksporLaporanHoldingModal({super.key});

  @override
  State<EksporLaporanHoldingModal> createState() => _EksporLaporanHoldingModalState();
}

class _EksporLaporanHoldingModalState extends State<EksporLaporanHoldingModal> {
  String _selectedScope = 'Laporan Konsolidasi Eksekutif Triwulan (Q1 2025)';
  String _selectedFormat = 'PDF Document (.pdf)';
  bool _isDownloading = false;

  void _downloadReport() async {
    setState(() => _isDownloading = true);
    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    setState(() => _isDownloading = false);
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '$_selectedScope berhasil diunduh dalam format $_selectedFormat.',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
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
                  color: const Color(0xFF0F4C81).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.file_download_outlined, color: Color(0xFF0F4C81), size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Ekspor Laporan Direksi Grup',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'Dokumen Konsolidasi Holding PT Aman Media Interaktif',
                      style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
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

          const Text('Jenis Laporan Konsolidasi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            initialValue: _selectedScope,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.inputBackground,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
            items: const [
              DropdownMenuItem(
                value: 'Laporan Konsolidasi Eksekutif Triwulan (Q1 2025)',
                child: Text('Laporan Konsolidasi Triwulan Q1 2025', style: TextStyle(fontSize: 13)),
              ),
              DropdownMenuItem(
                value: 'Rekapitulasi SDM & Payroll Konsolidasi Grup',
                child: Text('Rekapitulasi SDM & Payroll Grup', style: TextStyle(fontSize: 13)),
              ),
              DropdownMenuItem(
                value: 'Laporan Status Proyek Strategis & BAST Entitas',
                child: Text('Status Proyek Strategis & BAST Entitas', style: TextStyle(fontSize: 13)),
              ),
              DropdownMenuItem(
                value: 'Laporan Audit Kepatuhan Regulasi Ketenagakerjaan & Pajak',
                child: Text('Audit Regulasi Ketenagakerjaan & Pajak', style: TextStyle(fontSize: 13)),
              ),
            ],
            onChanged: (val) {
              if (val != null) setState(() => _selectedScope = val);
            },
          ),
          const SizedBox(height: 14),

          const Text('Format Dokumen', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            initialValue: _selectedFormat,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.inputBackground,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
            items: const [
              DropdownMenuItem(value: 'PDF Document (.pdf)', child: Text('PDF Document Resmi (.pdf)', style: TextStyle(fontSize: 13))),
              DropdownMenuItem(value: 'Excel Spreadsheet (.xlsx)', child: Text('Excel Spreadsheet (.xlsx)', style: TextStyle(fontSize: 13))),
            ],
            onChanged: (val) {
              if (val != null) setState(() => _selectedFormat = val);
            },
          ),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isDownloading ? null : _downloadReport,
              icon: _isDownloading
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Icon(Icons.download_rounded, color: Colors.white),
              label: Text(
                _isDownloading ? 'Menyiapkan Dokumen Direksi...' : 'Unduh Laporan Konsolidasi',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F4C81),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
