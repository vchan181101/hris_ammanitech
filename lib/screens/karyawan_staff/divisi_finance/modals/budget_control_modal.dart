import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class BudgetControlModal extends StatelessWidget {
  const BudgetControlModal({super.key});

  @override
  Widget build(BuildContext context) {
    final budgets = [
      {
        'entity': 'PT Aman Media Interaktif (Holding)',
        'allocated': 'Rp 450.000.000',
        'spent': 'Rp 315.000.000',
        'remaining': 'Rp 135.000.000',
        'percentage': 0.70,
        'status': 'Normal (70% Used)',
        'color': const Color(0xFF047857),
      },
      {
        'entity': 'PT Global Moviion Teknologi',
        'allocated': 'Rp 600.000.000',
        'spent': 'Rp 540.000.000',
        'remaining': 'Rp 60.000.000',
        'percentage': 0.90,
        'status': 'Warning (90% Used)',
        'color': const Color(0xFFD97706),
      },
      {
        'entity': 'PT Hanasta Global Teknologi',
        'allocated': 'Rp 350.000.000',
        'spent': 'Rp 210.000.000',
        'remaining': 'Rp 140.000.000',
        'percentage': 0.60,
        'status': 'Hemat (60% Used)',
        'color': const Color(0xFF0284C7),
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
                  Icon(Icons.pie_chart_outline_rounded, color: Color(0xFF047857)),
                  SizedBox(width: 8),
                  Text(
                    'Budget Control & Monitoring',
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
              itemCount: budgets.length,
              separatorBuilder: (context, index) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final item = budgets[index];
                final color = item['color'] as Color;
                final percentage = item['percentage'] as double;

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
                              item['entity'] as String,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
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
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: percentage,
                          backgroundColor: AppColors.inputBackground,
                          valueColor: AlwaysStoppedAnimation<Color>(color),
                          minHeight: 8,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Budget Dialokasikan', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                              Text(item['allocated'] as String, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Terpakai (Spent)', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                              Text(item['spent'] as String, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('Sisa Anggaran', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                              Text(item['remaining'] as String, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF047857))),
                            ],
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
