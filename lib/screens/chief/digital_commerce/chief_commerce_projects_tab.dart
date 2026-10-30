import 'package:flutter/material.dart';
import '../../../../models/user_model.dart';
import '../../../../theme/app_colors.dart';

class ChiefCommerceProjectsTab extends StatefulWidget {
  final UserModel user;

  const ChiefCommerceProjectsTab({super.key, required this.user});

  @override
  State<ChiefCommerceProjectsTab> createState() => _ChiefCommerceProjectsTabState();
}

class _ChiefCommerceProjectsTabState extends State<ChiefCommerceProjectsTab> {
  String _selectedFilter = 'Semua';

  final List<Map<String, dynamic>> _platforms = [
    {
      'title': 'AmaniPay & QRIS Multi-Acquirer Gateway',
      'lead': 'Achmad Subekti',
      'category': 'Payment & Fintech',
      'progress': 92,
      'status': 'Operational',
      'version': 'v3.4.1',
      'sla': '99.99%',
      'uptime': '30 Hari Zero-Downtime',
      'color': Colors.green,
    },
    {
      'title': 'Loyalty Engine & Reward Points v2.0',
      'lead': 'Nurandi Marsha (PM)',
      'category': 'Product Feature',
      'progress': 86,
      'status': 'Beta Testing',
      'version': 'v2.0-rc2',
      'sla': '99.95%',
      'uptime': 'QA Staging Sandbox',
      'color': Colors.purple,
    },
    {
      'title': 'Merchant Mobile POS & Cashier App',
      'lead': 'Rian Hidayat',
      'category': 'Mobile & Terminal',
      'progress': 78,
      'status': 'Rollout',
      'version': 'v1.8.0',
      'sla': '99.92%',
      'uptime': '148 Merchant Terhubung',
      'color': Colors.blue,
    },
    {
      'title': 'B2B Commerce API & Webhook Dispatcher',
      'lead': 'M. Dikdo',
      'category': 'Infrastructure',
      'progress': 95,
      'status': 'High Availability',
      'version': 'v4.1.0',
      'sla': '99.98%',
      'uptime': 'Cluster Latency: 42ms',
      'color': Colors.teal,
    },
    {
      'title': 'Customer CS AI Chatbot & Auto-Ticketing',
      'lead': 'Siti Rahma (CS Lead)',
      'category': 'Support & Operations',
      'progress': 65,
      'status': 'Development',
      'version': 'v1.0-alpha',
      'sla': '98.50%',
      'uptime': 'Training Dataset NLP',
      'color': Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _selectedFilter == 'Semua'
        ? _platforms
        : _platforms.where((p) => (p['category'] as String).contains(_selectedFilter)).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: AppColors.cardBorder)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Digital Commerce Platform Hub',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                          ),
                          Text(
                            'Ketersediaan Platform PT Hanasta Global Teknologi',
                            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.purple.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${_platforms.length} Layanan',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.purple),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ['Semua', 'Payment', 'Product Feature', 'Infrastructure', 'Mobile'].map((cat) {
                        final isSelected = _selectedFilter == cat;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(
                              cat,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected ? Colors.white : AppColors.textPrimary,
                              ),
                            ),
                            selected: isSelected,
                            selectedColor: const Color(0xFF6B21A8),
                            backgroundColor: Colors.grey.shade100,
                            onSelected: (val) {
                              if (val) setState(() => _selectedFilter = cat);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Platforms List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final p = filtered[index];
                  final MaterialColor color = p['color'] as MaterialColor;
                  final int progress = p['progress'] as int;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.cardBorder),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                p['category'] as String,
                                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color[800]),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                p['status'] as String,
                                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          p['title'] as String,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.person_outline_rounded, size: 14, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text('Lead: ${p['lead']}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                            const SizedBox(width: 14),
                            const Icon(Icons.label_outline_rounded, size: 14, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text('${p['version']}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'SLA Platform: ${p['sla']}',
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.green),
                            ),
                            Text(
                              'Kesiapan: $progress%',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color[800]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: progress / 100,
                            minHeight: 6,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: AlwaysStoppedAnimation<Color>(color),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.cloud_done_outlined, size: 14, color: Colors.teal),
                            const SizedBox(width: 4),
                            Text(
                              p['uptime'] as String,
                              style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
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
      ),
    );
  }
}
