import 'package:flutter/material.dart';
import '../../../models/user_model.dart';
import '../../../theme/app_colors.dart';
import 'modals/verifikasi_reimbursement_modal.dart';

class FinanceReimbursementTab extends StatefulWidget {
  final UserModel user;

  const FinanceReimbursementTab({super.key, required this.user});

  @override
  State<FinanceReimbursementTab> createState() =>
      _FinanceReimbursementTabState();
}

class _FinanceReimbursementTabState extends State<FinanceReimbursementTab> {
  String _selectedFilter = 'Semua';

  final List<Map<String, dynamic>> _claimList = [
    {
      'employee': 'M. Jumi\'at Mochtar',
      'position': 'IoT Engineer',
      'company': 'PT Global Moviion Teknologi',
      'title': 'Pembelian Gateway Modbus & Sensor ESP32',
      'category': 'Komponen & Material IoT',
      'amount': 'Rp 3.850.000',
      'date': '10 Mar 2025',
      'status': 'Pending Staff Review',
      'receiptName': 'Struk_Belanja_Sensor_IoT.jpg',
    },
    {
      'employee': 'M Erlan',
      'position': 'AI Engineer',
      'company': 'PT Global Moviion Teknologi',
      'title': 'Sewa Server Cloud GPU Training Model',
      'category': 'Perjalanan Dinas & Server',
      'amount': 'Rp 4.200.000',
      'date': '09 Mar 2025',
      'status': 'Pending Staff Review',
      'receiptName': 'Invoice_AWS_GPU_Cloud.pdf',
    },
    {
      'employee': 'Abdul Rajab',
      'position': 'Civil Works Engineer',
      'company': 'PT Global Moviion Teknologi',
      'title': 'BBM & Toll Client Site Field Visit',
      'category': 'BBM & Transportasi Client',
      'amount': 'Rp 850.000',
      'date': '08 Mar 2025',
      'status': 'Pending Staff Review',
      'receiptName': 'Struk_Tol_Pertamax_Site.jpg',
    },
    {
      'employee': 'Mia Aulia',
      'position': 'Staff Administrasi Umum',
      'company': 'PT Aman Media Interaktif',
      'title': 'Pembelian ATK & Konsumsi Meeting Holding',
      'category': 'Konsumsi Team & Meeting',
      'amount': 'Rp 1.550.000',
      'date': '06 Mar 2025',
      'status': 'Disetujui',
      'receiptName': 'Struk_Gramedia_Kopi.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _claimList.where((item) {
      if (_selectedFilter == 'Semua') return true;
      if (_selectedFilter == 'Pending') return item['status'] == 'Pending Staff Review';
      if (_selectedFilter == 'Disetujui') return item['status'] == 'Disetujui';
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Verifikasi Klaim Reimbursement',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF059669),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Filter Header
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildChip('Semua'),
                  _buildChip('Pending'),
                  _buildChip('Disetujui'),
                ],
              ),
            ),
          ),

          // List Klaim Karyawan
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: filtered.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final claim = filtered[index];
                final bool isPending = claim['status'] == 'Pending Staff Review';

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                claim['employee']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                '${claim['position']} • ${claim['company']}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: isPending
                                  ? AppColors.warning.withValues(alpha: 0.15)
                                  : AppColors.success.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              claim['status']!,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: isPending ? AppColors.warning : AppColors.success,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 18),
                      Text(
                        claim['title']!,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Kategori: ${claim['category']} • Tgl: ${claim['date']}',
                        style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            claim['amount']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => VerifikasiReimbursementModal(claimData: claim),
                              );
                            },
                            icon: const Icon(Icons.search_rounded, size: 16),
                            label: Text(isPending ? 'Verifikasi' : 'Detail'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isPending ? const Color(0xFF059669) : AppColors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
    );
  }

  Widget _buildChip(String label) {
    final isSelected = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        label: Text(label),
        selectedColor: const Color(0xFF059669),
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
