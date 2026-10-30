import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class KonsolidasiEntitasModal extends StatelessWidget {
  const KonsolidasiEntitasModal({super.key});

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
                    color: const Color(0xFF0F4C81).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.apartment_rounded, color: Color(0xFF0F4C81), size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Konsolidasi Entitas Grup',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'Holding & Anak Perusahaan AMANI Tech Group',
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

            // Top Summary Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0F4C81), Color(0xFF1E3A8A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSummaryItem('3 Entitas', 'Holding & Sub.', Icons.business_rounded),
                  Container(height: 36, width: 1, color: Colors.white.withValues(alpha: 0.3)),
                  _buildSummaryItem('54 Karyawan', 'Total SDM Grup', Icons.people_alt_rounded),
                  Container(height: 36, width: 1, color: Colors.white.withValues(alpha: 0.3)),
                  _buildSummaryItem('13 Proyek', 'Sektor Aktif', Icons.rocket_launch_rounded),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Rincian Entitas Bisnis & Kepemimpinan',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 12),

            // 1. PT Aman Media Interaktif (Holding)
            _buildCompanyCard(
              name: 'PT Aman Media Interaktif',
              badge: 'HOLDING COMPANY',
              badgeColor: Colors.blue,
              director: 'Dimas Pasurangga (Direktur Utama)',
              headcount: '12 Staf & Eksekutif',
              projects: 'Governance, HR/GA, Finance & Railways Collab',
              revenueStatus: 'Surplus Operasional Sehat',
              accentColor: Colors.blue,
            ),
            const SizedBox(height: 12),

            // 2. PT Global Moviion Teknologi
            _buildCompanyCard(
              name: 'PT Global Moviion Teknologi',
              badge: 'SUBSIDIARY (ENTERPRISE)',
              badgeColor: Colors.indigo,
              director: 'M. Rizky Elrivany (Direktur / Chief ES)',
              headcount: '24 Engineer & Staf',
              projects: '8 Proyek Aktif (IoT, AI, Civil Works & KAI Depo)',
              revenueStatus: 'Realisasi Kontrak 92%',
              accentColor: Colors.indigo,
            ),
            const SizedBox(height: 12),

            // 3. PT Hanasta Global Teknologi
            _buildCompanyCard(
              name: 'PT Hanasta Global Teknologi',
              badge: 'SUBSIDIARY (COMMERCE)',
              badgeColor: Colors.purple,
              director: 'Wendy Swandoyo (Direktur / Chief DC)',
              headcount: '18 Staf & Engineer',
              projects: 'Platform Commerce, QRIS Gateway & CS 24/7',
              revenueStatus: 'GMV +18.4% MoM',
              accentColor: Colors.purple,
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Tutup Tinjauan', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String val, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(height: 4),
        Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.white70)),
      ],
    );
  }

  Widget _buildCompanyCard({
    required String name,
    required String badge,
    required MaterialColor badgeColor,
    required String director,
    required String headcount,
    required String projects,
    required String revenueStatus,
    required MaterialColor accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accentColor.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: accentColor[900]),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  badge,
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: badgeColor[800]),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.person_outline_rounded, size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Expanded(
                child: Text(director, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.groups_outlined, size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(headcount, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.task_alt_rounded, size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Expanded(
                child: Text(projects, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.trending_up_rounded, size: 14, color: Colors.green),
                const SizedBox(width: 6),
                Text(
                  revenueStatus,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
