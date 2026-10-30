import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class KasOperasionalModal extends StatefulWidget {
  const KasOperasionalModal({super.key});

  @override
  State<KasOperasionalModal> createState() => _KasOperasionalModalState();
}

class _KasOperasionalModalState extends State<KasOperasionalModal> {
  final List<Map<String, dynamic>> _operationalFunds = [
    {
      'code': 'KAS-CW-01',
      'title': 'Material Tambahan Site Civil Works',
      'requester': 'Abdul Rajab (Civil Works Eng)',
      'company': 'PT Global Moviion Teknologi',
      'amount': 'Rp 4.500.000',
      'date': 'Hari ini, 09:30 WIB',
      'notes': 'Semen instan, pipa conduit, dan kabel grounding site BTS kereta.',
      'status': 'Menunggu Verifikasi Staff',
    },
    {
      'code': 'KAS-IOT-02',
      'title': 'Baterai Li-ion & Sensor Telemetri Lapangan',
      'requester': 'M. Jumi\'at Mochtar (IoT Eng)',
      'company': 'PT Global Moviion Teknologi',
      'amount': 'Rp 2.800.000',
      'date': 'Kemarin',
      'notes': 'Emergency replacement baterai gateway sensor rel kereta api.',
      'status': 'Terverifikasi (Disbursed)',
    },
    {
      'code': 'KAS-HGT-01',
      'title': 'Langganan Server Testing E-Commerce',
      'requester': 'M. Dikdo (Infrastruktur Eng)',
      'company': 'PT Hanasta Global Teknologi',
      'amount': 'Rp 1.250.000',
      'date': 'Kemarin',
      'notes': 'Biaya instance sandbox load testing high-traffic.',
      'status': 'Terverifikasi (Disbursed)',
    },
  ];

  void _verifyFund(int index) {
    setState(() {
      _operationalFunds[index]['status'] = 'Terverifikasi Staff Finance';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Dana kas operasional berhasil diverifikasi!'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
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
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 44,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.account_balance_wallet_rounded, color: Color(0xFF059669)),
                    SizedBox(width: 8),
                    Text(
                      'Kas Operasional Proyek & Site',
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
          ),
          const Divider(height: 1),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _operationalFunds.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = _operationalFunds[index];
                final isPending = item['status'] == 'Menunggu Verifikasi Staff';

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isPending ? const Color(0xFFA7F3D0) : AppColors.cardBorder,
                    ),
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
                          Text(
                            item['code'],
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF059669)),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: isPending ? const Color(0xFFFEF3C7) : const Color(0xFFD1FAE5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              item['status'],
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: isPending ? const Color(0xFFB45309) : const Color(0xFF065F46),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['title'],
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${item['requester']} • ${item['company']}',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.inputBackground,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['amount'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF059669),
                              ),
                            ),
                            Text(
                              item['date'],
                              style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Keterangan: ${item['notes']}',
                        style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                      ),
                      if (isPending) ...[
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _verifyFund(index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF059669),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text('Verifikasi Nota Kas Operasional'),
                          ),
                        ),
                      ],
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
