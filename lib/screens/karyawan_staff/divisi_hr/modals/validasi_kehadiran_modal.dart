import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class ValidasiKehadiranModal extends StatefulWidget {
  const ValidasiKehadiranModal({super.key});

  @override
  State<ValidasiKehadiranModal> createState() => _ValidasiKehadiranModalState();
}

class _ValidasiKehadiranModalState extends State<ValidasiKehadiranModal> {
  final List<Map<String, dynamic>> _issueList = [
    {
      'id': 'VAL-01',
      'name': 'M Erlan',
      'nik': 'GMT-002',
      'company': 'PT Global Moviion Teknologi',
      'issue': 'GPS Error / Drift di Site Deployment',
      'description': 'Titik koordinat melompat 300m di luar geofence saat clock-in pagi.',
      'time': '08:15 WIB',
      'date': 'Hari Ini',
      'status': 'Pending Validasi',
    },
    {
      'id': 'VAL-02',
      'name': 'Abdul Rajab',
      'nik': 'GMT-005',
      'company': 'PT Global Moviion Teknologi',
      'issue': 'Lupa Clock-Out (Dinas Luar)',
      'description': 'Sedang inspeksi lapangan jalur kereta hingga larut malam.',
      'time': '17:30 WIB (Kemarin)',
      'date': 'Kemarin',
      'status': 'Pending Validasi',
    },
    {
      'id': 'VAL-03',
      'name': 'Nurandi Marsha',
      'nik': 'HGT-003',
      'company': 'PT Hanasta Global Teknologi',
      'issue': 'Koreksi Jam Kerja / Meeting Klien',
      'description': 'Langsung berangkat meeting offline dengan klien e-commerce jam 08:00.',
      'time': '08:00 WIB',
      'date': 'Hari Ini',
      'status': 'Pending Validasi',
    },
  ];

  void _resolveIssue(int index, bool approved) {
    final item = _issueList[index];
    setState(() {
      item['status'] = approved ? 'Disetujui Staff HR' : 'Ditolak';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          approved
              ? 'Kendala presensi ${item['name']} berhasil divalidasi!'
              : 'Kendala presensi ${item['name']} ditolak.',
        ),
        backgroundColor: approved ? AppColors.success : AppColors.error,
        duration: const Duration(seconds: 2),
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
                    Icon(Icons.verified_user_rounded, color: Color(0xFF7C3AED)),
                    SizedBox(width: 8),
                    Text(
                      'Validasi Kendala Kehadiran',
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
              itemCount: _issueList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = _issueList[index];
                final isPending = item['status'] == 'Pending Validasi';

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isPending ? const Color(0xFFDDD6FE) : AppColors.cardBorder,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
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
                            item['id'],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7C3AED),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: isPending
                                  ? const Color(0xFFFEF3C7)
                                  : (item['status'] == 'Disetujui Staff HR'
                                      ? const Color(0xFFD1FAE5)
                                      : const Color(0xFFFEE2E2)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              item['status'],
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: isPending
                                    ? const Color(0xFFB45309)
                                    : (item['status'] == 'Disetujui Staff HR'
                                        ? const Color(0xFF065F46)
                                        : const Color(0xFF991B1B)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['name'],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        '${item['company']} • ${item['nik']}',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.inputBackground,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.warning_amber_rounded, size: 16, color: Color(0xFFB45309)),
                                const SizedBox(width: 6),
                                Text(
                                  item['issue'],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['description'],
                              style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      if (isPending) ...[
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => _resolveIssue(index, false),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.error,
                                  side: const BorderSide(color: AppColors.error),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text('Tolak'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _resolveIssue(index, true),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF7C3AED),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text('Validasi'),
                              ),
                            ),
                          ],
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
