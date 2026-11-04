import 'package:flutter/material.dart';
import '../../../../features/auth/data/datasources/mock_users.dart';
import '../../../../models/user_model.dart';
import '../../../../theme/app_colors.dart';

class DatabaseKaryawanModal extends StatefulWidget {
  const DatabaseKaryawanModal({super.key});

  @override
  State<DatabaseKaryawanModal> createState() => _DatabaseKaryawanModalState();
}

class _DatabaseKaryawanModalState extends State<DatabaseKaryawanModal> {
  String _searchQuery = '';
  String _selectedCompany = 'Semua Perusahaan';

  final List<String> _companies = [
    'Semua Perusahaan',
    'PT Aman Media Interaktif',
    'PT Global Moviion Teknologi',
    'PT Hanasta Global Teknologi',
  ];

  @override
  Widget build(BuildContext context) {
    final filteredUsers = MockUserData.users.where((user) {
      final matchesQuery = user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          user.nik.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          user.position.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCompany = _selectedCompany == 'Semua Perusahaan' ||
          user.company == _selectedCompany;
      return matchesQuery && matchesCompany;
    }).toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
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
                    Icon(Icons.badge_rounded, color: Color(0xFF7C3AED)),
                    SizedBox(width: 8),
                    Text(
                      'Database Karyawan Group',
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

          // Search & Filter Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: InputDecoration(
                    hintText: 'Cari nama, NIK, atau jabatan...',
                    prefixIcon: const Icon(Icons.search_rounded, color: AppColors.primary),
                    filled: true,
                    fillColor: AppColors.inputBackground,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _companies.map((company) {
                      final isSelected = _selectedCompany == company;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(
                            company == 'Semua Perusahaan' ? 'Semua' : company.replaceAll('PT ', ''),
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : AppColors.textPrimary,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          selected: isSelected,
                          selectedColor: const Color(0xFF7C3AED),
                          backgroundColor: AppColors.inputBackground,
                          onSelected: (val) {
                            if (val) setState(() => _selectedCompany = company);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          // List Karyawan
          Expanded(
            child: filteredUsers.isEmpty
                ? const Center(
                    child: Text('Tidak ada data karyawan yang sesuai.'),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: filteredUsers.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final u = filteredUsers[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: const Color(0xFFEDE9FE),
                          child: Text(
                            u.name[0],
                            style: const TextStyle(
                              color: Color(0xFF6D28D9),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          u.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${u.position} • ${u.nik}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF7C3AED),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              u.company,
                              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD1FAE5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Aktif',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF065F46),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onTap: () {
                          _showEmployeeDetail(u);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showEmployeeDetail(UserModel u) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(u.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('NIK', u.nik),
            _buildDetailRow('Email', u.email),
            _buildDetailRow('Perusahaan', u.company),
            _buildDetailRow('Departemen', u.department),
            _buildDetailRow('Posisi / Jabatan', u.position),
            _buildDetailRow('Status', 'PKWTT (Tetap) - Aktif'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
