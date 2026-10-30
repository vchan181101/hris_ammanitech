import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class RekapitulasiAbsensiModal extends StatefulWidget {
  const RekapitulasiAbsensiModal({super.key});

  @override
  State<RekapitulasiAbsensiModal> createState() => _RekapitulasiAbsensiModalState();
}

class _RekapitulasiAbsensiModalState extends State<RekapitulasiAbsensiModal> {
  String _selectedPeriod = 'Bulan Ini (Maret 2025)';
  String _selectedCompany = 'Semua Entitas (Group)';
  String _exportFormat = 'Excel (.xlsx)';
  bool _isExporting = false;

  void _handleExport() async {
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
                'Laporan rekapitulasi kehadiran berhasil diekspor ke $_exportFormat!',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                  Icon(Icons.assessment_rounded, color: Color(0xFF7C3AED)),
                  SizedBox(width: 8),
                  Text(
                    'Rekapitulasi Absensi',
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

          const Text('Periode Laporan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _selectedPeriod,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.inputBackground,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
            items: const [
              DropdownMenuItem(value: 'Bulan Ini (Maret 2025)', child: Text('Bulan Ini (Maret 2025)')),
              DropdownMenuItem(value: 'Bulan Lalu (Februari 2025)', child: Text('Bulan Lalu (Februari 2025)')),
              DropdownMenuItem(value: 'Kuartal 1 (Jan - Mar 2025)', child: Text('Kuartal 1 (Jan - Mar 2025)')),
            ],
            onChanged: (val) => setState(() => _selectedPeriod = val!),
          ),
          const SizedBox(height: 14),

          const Text('Entitas Perusahaan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _selectedCompany,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.inputBackground,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
            items: const [
              DropdownMenuItem(value: 'Semua Entitas (Group)', child: Text('Semua Entitas (Group)')),
              DropdownMenuItem(value: 'PT Aman Media Interaktif', child: Text('PT Aman Media Interaktif')),
              DropdownMenuItem(value: 'PT Global Moviion Teknologi', child: Text('PT Global Moviion Teknologi')),
              DropdownMenuItem(value: 'PT Hanasta Global Teknologi', child: Text('PT Hanasta Global Teknologi')),
            ],
            onChanged: (val) => setState(() => _selectedCompany = val!),
          ),
          const SizedBox(height: 14),

          const Text('Format Ekspor', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: const Center(child: Text('Excel (.xlsx)')),
                  selected: _exportFormat == 'Excel (.xlsx)',
                  selectedColor: const Color(0xFF7C3AED),
                  labelStyle: TextStyle(
                    color: _exportFormat == 'Excel (.xlsx)' ? Colors.white : AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  onSelected: (val) => setState(() => _exportFormat = 'Excel (.xlsx)'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ChoiceChip(
                  label: const Center(child: Text('PDF Document')),
                  selected: _exportFormat == 'PDF Document',
                  selectedColor: const Color(0xFF7C3AED),
                  labelStyle: TextStyle(
                    color: _exportFormat == 'PDF Document' ? Colors.white : AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  onSelected: (val) => setState(() => _exportFormat = 'PDF Document'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: _isExporting ? null : _handleExport,
              icon: _isExporting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : const Icon(Icons.download_rounded),
              label: Text(_isExporting ? 'Memproses Ekspor...' : 'Unduh Laporan Rekapitulasi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C3AED),
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
