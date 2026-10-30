import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class KebijakanBroadcastModal extends StatefulWidget {
  const KebijakanBroadcastModal({super.key});

  @override
  State<KebijakanBroadcastModal> createState() => _KebijakanBroadcastModalState();
}

class _KebijakanBroadcastModalState extends State<KebijakanBroadcastModal> {
  final _titleController = TextEditingController(text: 'Instruksi Direktur Utama: Pelaksanaan Q1 Review & Kepatuhan Proyek');
  final _bodyController = TextEditingController(
    text: 'Diharapkan seluruh jajaran Chief (Enterprise Solution, Digital Commerce, Railways & Transportation) dan Head of Department mempersiapkan laporan kemajuan deliverable dan serah terima BAST sebelum rapat umum direksi.',
  );
  String _selectedTarget = 'Semua C-Level / Chief & Head';
  String _priority = 'Prioritas Tinggi / Urgent';
  bool _isSending = false;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _sendDirective() async {
    if (_titleController.text.trim().isEmpty || _bodyController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Judul dan isi instruksi tidak boleh kosong.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isSending = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _isSending = false);
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Instruksi Direksi berhasil disiarkan ke $_selectedTarget!',
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
                  child: const Icon(Icons.campaign_rounded, color: Colors.orange, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Pusat Mandat & Broadcast Direksi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'Kirim instruksi resmi Direktur Utama ke manajemen',
                        style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
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

            const Text('Sasaran Penerima Mandat', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              initialValue: _selectedTarget,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.inputBackground,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
              items: const [
                DropdownMenuItem(value: 'Semua C-Level / Chief & Head', child: Text('Semua C-Level / Chief & Head', style: TextStyle(fontSize: 13))),
                DropdownMenuItem(value: 'Seluruh Karyawan AMANI Tech Group', child: Text('Seluruh Karyawan Grup (Holding & Sub.)', style: TextStyle(fontSize: 13))),
                DropdownMenuItem(value: 'Direksi PT Global Moviion Teknologi (GMT)', child: Text('Manajemen PT GMT', style: TextStyle(fontSize: 13))),
                DropdownMenuItem(value: 'Direksi PT Hanasta Global Teknologi (HGT)', child: Text('Manajemen PT HGT', style: TextStyle(fontSize: 13))),
              ],
              onChanged: (val) {
                if (val != null) setState(() => _selectedTarget = val);
              },
            ),
            const SizedBox(height: 14),

            const Text('Tingkat Prioritas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              initialValue: _priority,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.inputBackground,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
              items: const [
                DropdownMenuItem(value: 'Prioritas Tinggi / Urgent', child: Text('Prioritas Tinggi / Urgent', style: TextStyle(fontSize: 13))),
                DropdownMenuItem(value: 'Pemberitahuan Resmi Normal', child: Text('Pemberitahuan Resmi Normal', style: TextStyle(fontSize: 13))),
                DropdownMenuItem(value: 'Instruksi Kebijakan Baru', child: Text('Instruksi Kebijakan Baru', style: TextStyle(fontSize: 13))),
              ],
              onChanged: (val) {
                if (val != null) setState(() => _priority = val);
              },
            ),
            const SizedBox(height: 14),

            const Text('Judul Instruksi / Kebijakan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 6),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Masukkan judul mandat...',
                filled: true,
                fillColor: AppColors.inputBackground,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 14),

            const Text('Isi Arahan & Instruksi Direktur Utama', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 6),
            TextField(
              controller: _bodyController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Tuliskan arahan resmi...',
                filled: true,
                fillColor: AppColors.inputBackground,
                contentPadding: const EdgeInsets.all(14),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isSending ? null : _sendDirective,
                icon: _isSending
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Icon(Icons.send_rounded, color: Colors.white),
                label: Text(
                  _isSending ? 'Menyiarkan Instruksi...' : 'Kirim Mandat Sekarang',
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
      ),
    );
  }
}
