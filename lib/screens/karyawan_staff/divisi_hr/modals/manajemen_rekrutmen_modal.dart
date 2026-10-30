import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class ManajemenRekrutmenModal extends StatelessWidget {
  const ManajemenRekrutmenModal({super.key});

  @override
  Widget build(BuildContext context) {
    final candidatePipeline = [
      {
        'candidate': 'Budi Santoso, S.Kom',
        'role': 'Senior Flutter Developer',
        'company': 'PT Hanasta Global Teknologi',
        'stage': 'Interview User & Direktur',
        'date': 'Besok, 10:00 WIB',
        'statusColor': const Color(0xFF0284C7),
      },
      {
        'candidate': 'Dewi Lestari, M.T.',
        'role': 'Computer Vision AI Specialist',
        'company': 'PT Global Moviion Teknologi',
        'stage': 'Offering Letter Negotiation',
        'date': 'Menunggu Konfirmasi',
        'statusColor': const Color(0xFF059669),
      },
      {
        'candidate': 'Farhan Ramadhan',
        'role': 'Junior IoT Field Technician',
        'company': 'PT Global Moviion Teknologi',
        'stage': 'Onboarding Day 1',
        'date': 'Mulai 01 April 2025',
        'statusColor': const Color(0xFF7C3AED),
      },
      {
        'candidate': 'Siti Rahmawati',
        'role': 'Account Executive B2B',
        'company': 'PT Aman Media Interaktif',
        'stage': 'Screening CV & Psikotes',
        'date': 'Review Mia Aulia',
        'statusColor': AppColors.warning,
      },
    ];

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(20),
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
            width: 44,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.person_search_rounded, color: Color(0xFF0F4C81)),
                  SizedBox(width: 8),
                  Text(
                    'Pipeline Rekrutmen & Talent',
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
          const SizedBox(height: 8),

          Expanded(
            child: ListView.separated(
              itemCount: candidatePipeline.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = candidatePipeline[index];
                final statusColor = item['statusColor'] as Color;

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
                          Text(
                            item['candidate'] as String,
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              item['stage'] as String,
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: statusColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${item['role']} • ${item['company']}',
                        style: const TextStyle(fontSize: 12, color: Color(0xFF0F4C81), fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Jadwal / Status: ${item['date']}',
                        style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
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
}
