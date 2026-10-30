import 'package:flutter/material.dart';
import '../../../models/user_model.dart';
import '../../../theme/app_colors.dart';
import 'modals/verifikasi_cuti_modal.dart';

class HrVerifikasiCutiTab extends StatefulWidget {
  final UserModel user;

  const HrVerifikasiCutiTab({super.key, required this.user});

  @override
  State<HrVerifikasiCutiTab> createState() => _HrVerifikasiCutiTabState();
}

class _HrVerifikasiCutiTabState extends State<HrVerifikasiCutiTab> {
  String _selectedFilter = 'Semua';

  final List<Map<String, dynamic>> _leaveRequests = [
    {
      'employee': 'M. Jumi\'at Mochtar',
      'nik': 'GMT-003',
      'position': 'IoT Engineer',
      'company': 'PT Global Moviion Teknologi',
      'type': 'Cuti Tahunan',
      'dates': '12 Mar 2025 - 14 Mar 2025',
      'duration': '3',
      'remainingLeave': '10 Hari',
      'reason': 'Keperluan keluarga di luar kota dan perbaikan perangkat rumah.',
      'status': 'Pending Staff Review',
    },
    {
      'employee': 'M Erlan',
      'nik': 'GMT-002',
      'position': 'AI Engineer',
      'company': 'PT Global Moviion Teknologi',
      'type': 'Izin Sakit dengan Surat Dokter',
      'dates': '10 Mar 2025',
      'duration': '1',
      'remainingLeave': '12 Hari',
      'reason': 'Demam dan konsultasi dokter (Surat Keterangan Sakit terlampir).',
      'status': 'Pending Staff Review',
    },
    {
      'employee': 'Abdul Rajab',
      'nik': 'GMT-005',
      'position': 'Civil Works Engineer',
      'company': 'PT Global Moviion Teknologi',
      'type': 'Dinas Luar Kota',
      'dates': '15 Mar 2025 - 17 Mar 2025',
      'duration': '3',
      'remainingLeave': '14 Hari',
      'reason': 'Survei site instalasi tower telemetri kereta api.',
      'status': 'Disetujui',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _leaveRequests.where((item) {
      if (_selectedFilter == 'Semua') return true;
      if (_selectedFilter == 'Pending') return item['status'] == 'Pending Staff Review';
      if (_selectedFilter == 'Disetujui') return item['status'] == 'Disetujui';
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Verifikasi Pengajuan Cuti / Izin',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF7C3AED),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Filter Chips
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _chip('Semua'),
                  _chip('Pending'),
                  _chip('Disetujui'),
                ],
              ),
            ),
          ),

          // Leave Requests List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: filtered.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final leave = filtered[index];
                final bool isPending = leave['status'] == 'Pending Staff Review';

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
                              Text(leave['employee']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              Text('${leave['position']} • ${leave['company']}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: isPending ? AppColors.warning.withValues(alpha: 0.15) : AppColors.success.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              leave['status']!,
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isPending ? AppColors.warning : AppColors.success),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 18),
                      Text('Jenis: ${leave['type']}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF7C3AED))),
                      const SizedBox(height: 2),
                      Text('Tanggal: ${leave['dates']} (${leave['duration']} hari)', style: const TextStyle(fontSize: 12, color: AppColors.textPrimary)),
                      const SizedBox(height: 4),
                      Text('Alasan: ${leave['reason']}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => VerifikasiCutiModal(leaveData: leave),
                            );
                          },
                          icon: const Icon(Icons.search_rounded, size: 16),
                          label: Text(isPending ? 'Review & Verifikasi' : 'Detail'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isPending ? const Color(0xFF7C3AED) : AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
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

  Widget _chip(String label) {
    final isSelected = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        label: Text(label),
        selectedColor: const Color(0xFF7C3AED),
        backgroundColor: AppColors.inputBackground,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : AppColors.textPrimary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        onSelected: (val) {
          setState(() => _selectedFilter = label);
        },
      ),
    );
  }
}
