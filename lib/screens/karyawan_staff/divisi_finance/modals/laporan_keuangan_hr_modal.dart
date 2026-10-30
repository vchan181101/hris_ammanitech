import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class LaporanKeuanganHrModal extends StatefulWidget {
  const LaporanKeuanganHrModal({super.key});

  @override
  State<LaporanKeuanganHrModal> createState() => _LaporanKeuanganHrModalState();
}

class _LaporanKeuanganHrModalState extends State<LaporanKeuanganHrModal> {
  String _selectedMonth = 'Maret 2025';
  String _reportType = 'Laporan Payroll & Reimbursement HR';
  String _format = 'Excel (.xlsx)';
  bool _isExporting = false;

  void _export() async {
    setState(() => _isExporting = true);
    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    setState(() => _isExporting = false);
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Laporan Keuangan HR ($_format) periode $_selectedMonth berhasil diunduh!',
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
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.file_download_rounded, color: Color(0xFF059669)),
                  SizedBox(width: 8),
                  Text(
                    'Ekspor Laporan Keuangan HR',
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
          const SizedBox(height: 10),

          const Text('Jenis Laporan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _reportType,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.inputBackground,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
            items: const [
              DropdownMenuItem(
                value: 'Laporan Payroll & Reimbursement HR',
                child: Text('Laporan Payroll & Reimbursement HR'),
              ),
              DropdownMenuItem(
                value: 'Rekapitulasi Pajak PPh 21 & BPJS',
                child: Text('Rekapitulasi Pajak PPh 21 & BPJS'),
              ),
              DropdownMenuItem(
                value: 'Realisasi Kas Operasional Proyek & Site',
                child: Text('Realisasi Kas Operasional Proyek & Site'),
              ),
            ],
            onChanged: (val) => setState(() => _reportType = val!),
          ),
          const SizedBox(height: 14),

          const Text('Periode Bulan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _selectedMonth,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.inputBackground,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
            items: const [
              DropdownMenuItem(value: 'Maret 2025', child: Text('Maret 2025')),
              DropdownMenuItem(value: 'Februari 2025', child: Text('Februari 2025')),
              DropdownMenuItem(value: 'Januari 2025', child: Text('Januari 2025')),
            ],
            onChanged: (val) => setState(() => _selectedMonth = val!),
          ),
          const SizedBox(height: 14),

          const Text('Format Dokumen', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: const Center(child: Text('Excel (.xlsx)')),
                  selected: _format == 'Excel (.xlsx)',
                  selectedColor: const Color(0xFF059669),
                  labelStyle: TextStyle(
                    color: _format == 'Excel (.xlsx)' ? Colors.white : AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  onSelected: (val) => setState(() => _format = 'Excel (.xlsx)'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ChoiceChip(
                  label: const Center(child: Text('PDF Document')),
                  selected: _format == 'PDF Document',
                  selectedColor: const Color(0xFF059669),
                  labelStyle: TextStyle(
                    color: _format == 'PDF Document' ? Colors.white : AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  onSelected: (val) => setState(() => _format = 'PDF Document'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: _isExporting ? null : _export,
              icon: _isExporting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : const Icon(Icons.download_rounded),
              label: Text(_isExporting ? 'Mengunduh Dokumen...' : 'Unduh Laporan Keuangan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF059669),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
