import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class EvaluasiKpiModal extends StatelessWidget {
  const EvaluasiKpiModal({super.key});

  @override
  Widget build(BuildContext context) {
    final kpiScores = [
      {
        'division': 'Enterprise Solution (PT GMT)',
        'lead': 'M. Rizky Elrivany',
        'score': 94.5,
        'status': 'Outstanding',
        'color': AppColors.success,
      },
      {
        'division': 'Digital Commerce (PT HGT)',
        'lead': 'Wendy Swandoyo',
        'score': 90.2,
        'status': 'Exceed Expectations',
        'color': const Color(0xFF0284C7),
      },
      {
        'division': 'Railways & Transportation',
        'lead': 'Pirmadi Sukma',
        'score': 88.0,
        'status': 'Met Expectations',
        'color': const Color(0xFF7C3AED),
      },
      {
        'division': 'Finance & Accounting (AMI)',
        'lead': 'Bachtiar Siagian',
        'score': 92.0,
        'status': 'Exceed Expectations',
        'color': const Color(0xFF0284C7),
      },
      {
        'division': 'HR & General Affairs (AMI)',
        'lead': 'Djoko Kiswantoro',
        'score': 93.8,
        'status': 'Outstanding',
        'color': AppColors.success,
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
                  Icon(Icons.insights_rounded, color: Color(0xFF0F4C81)),
                  SizedBox(width: 8),
                  Text(
                    'Evaluasi Kinerja & KPI Group',
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
              itemCount: kpiScores.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = kpiScores[index];
                final score = item['score'] as double;
                final color = item['color'] as Color;

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
                          Expanded(
                            child: Text(
                              item['division'] as String,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              item['status'] as String,
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Pimpinan: ${item['lead']}',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: LinearProgressIndicator(
                                value: score / 100,
                                backgroundColor: AppColors.inputBackground,
                                valueColor: AlwaysStoppedAnimation<Color>(color),
                                minHeight: 8,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '$score / 100',
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
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
}
