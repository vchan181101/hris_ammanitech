import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../theme/app_colors.dart';
import '../login_screen.dart';

class DirekturProfileTab extends StatefulWidget {
  final UserModel user;

  const DirekturProfileTab({super.key, required this.user});

  @override
  State<DirekturProfileTab> createState() => _DirekturProfileTabState();
}

class _DirekturProfileTabState extends State<DirekturProfileTab> {
  bool _biometricEnabled = true;
  bool _pushNotifications = true;
  String _activeGovernanceView = 'Holding Parent: PT Aman Media Interaktif (CEO Board)';

  void _showGovernanceDialog() {
    final options = [
      'Holding Parent: PT Aman Media Interaktif (CEO Board)',
      'Dewan Direksi Konsolidasi: AMANI Tech Group',
      'Pengawasan Operasional Anak Usaha (GMT & HGT)',
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: const [
            Icon(Icons.account_balance_rounded, color: AppColors.primary),
            SizedBox(width: 10),
            Text('Tata Kelola Direksi', style: TextStyle(fontSize: 18)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih mode wewenang tata kelola aktif:',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 12),
            ...options.map((opt) {
              final isSelected = _activeGovernanceView == opt;
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary.withValues(alpha: 0.08) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isSelected ? AppColors.primary : AppColors.cardBorder),
                ),
                child: ListTile(
                  dense: true,
                  title: Text(
                    opt,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? AppColors.primary : AppColors.textPrimary,
                      fontSize: 13,
                    ),
                  ),
                  trailing: isSelected ? const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 20) : null,
                  onTap: () {
                    setState(() => _activeGovernanceView = opt);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Beralih ke wewenang: $opt'),
                        backgroundColor: AppColors.primary,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
        ],
      ),
    );
  }

  void _showPinDialog() {
    final pinController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: const [
            Icon(Icons.lock_outline_rounded, color: AppColors.primary),
            SizedBox(width: 10),
            Text('PIN Otorisasi Direksi', style: TextStyle(fontSize: 18)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Masukkan 6-digit PIN otorisasi final dokumen direksi & payroll:',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: pinController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              obscureText: true,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, letterSpacing: 8, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.inputBackground,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('PIN Otorisasi Direktur Utama berhasil diperbarui.'),
                  backgroundColor: AppColors.success,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Simpan PIN', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.logout_rounded, color: AppColors.error),
            SizedBox(width: 10),
            Text('Keluar Akun Direksi?'),
          ],
        ),
        content: Text(
          'Apakah Anda yakin ingin keluar dari akun Direktur Utama ${widget.user.name}?',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Keluar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Director Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.cardBorder),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.amber.shade300, width: 2.5),
                      ),
                      child: CircleAvatar(
                        radius: 36,
                        backgroundColor: const Color(0xFF0F4C81).withValues(alpha: 0.12),
                        child: Text(
                          widget.user.name.isNotEmpty
                              ? widget.user.name.split(' ').map((n) => n[0]).take(2).join()
                              : 'DP',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F4C81),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.user.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.user.position,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'NIK: ${widget.user.nik} | ${widget.user.company}',
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF0F4C81)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 8),

                    // Multi-Entity Governance Switcher
                    InkWell(
                      onTap: _showGovernanceDialog,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFCBD5E1)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.swap_horiz_rounded, color: Color(0xFF0F4C81), size: 22),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Tata Kelola Direksi Aktif:', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                                  Text(
                                    _activeGovernanceView,
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Security Settings
              const Text('Keamanan & Otorisasi Direksi', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              const SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Column(
                  children: [
                    SwitchListTile(
                      value: _biometricEnabled,
                      onChanged: (val) => setState(() => _biometricEnabled = val),
                      title: const Text('Biometrik / Face ID Direksi', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      subtitle: const Text('Login instan & otorisasi dokumen pengesahan direksi', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      secondary: const Icon(Icons.fingerprint_rounded, color: Color(0xFF0F4C81)),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      onTap: _showPinDialog,
                      leading: const Icon(Icons.dialpad_rounded, color: Color(0xFF0F4C81)),
                      title: const Text('Atur PIN Otorisasi Direksi (6-Digit)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      subtitle: const Text('Digunakan untuk otorisasi final Capex dan pencairan payroll grup', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
                    ),
                    const Divider(height: 1),
                    SwitchListTile(
                      value: _pushNotifications,
                      onChanged: (val) => setState(() => _pushNotifications = val),
                      title: const Text('Notifikasi Real-Time Dewan Direksi', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      subtitle: const Text('Peringatan instan saat ada pengajuan mendesak dari Chief/Head', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      secondary: const Icon(Icons.notifications_active_outlined, color: Color(0xFF0F4C81)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Corporate Governance Hotline
              const Text('Sekretariat Perusahaan & Bantuan', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              const SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.support_agent_rounded, color: Colors.indigo),
                      title: const Text('Corporate Secretary & Legal Hotline', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                      subtitle: const Text('Bantuan prioritas notaris, legal holding & tata kelola direksi', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Sekretariat Perusahaan: corsec@amanitech.co.id | +62 811-9876-5432'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.logout_rounded, color: AppColors.error),
                      title: const Text('Keluar dari Akun', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.error)),
                      onTap: _showLogoutDialog,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
