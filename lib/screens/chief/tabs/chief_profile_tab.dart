import 'package:flutter/material.dart';
import '../../../../models/user_model.dart';
import '../../../../theme/app_colors.dart';
import '../../login_screen.dart';

class ChiefProfileTab extends StatefulWidget {
  final UserModel user;

  const ChiefProfileTab({super.key, required this.user});

  @override
  State<ChiefProfileTab> createState() => _ChiefProfileTabState();
}

class _ChiefProfileTabState extends State<ChiefProfileTab> {
  bool _biometricEnabled = true;
  bool _pushNotifications = true;
  late String _activeRoleView;

  @override
  void initState() {
    super.initState();
    if (widget.user.nik == 'GMT-001') {
      _activeRoleView = 'Chief of Enterprise Solution';
    } else if (widget.user.nik == 'HGT-001') {
      _activeRoleView = 'Chief of Digital Commerce';
    } else {
      _activeRoleView = 'Chief of Railways & Transportation';
    }
  }

  void _showMultiRoleDialog() {
    List<String> roles;
    if (widget.user.nik == 'GMT-001') {
      roles = [
        'Chief of Enterprise Solution (AMANI Group)',
        'Direktur Utama PT Global Moviion Teknologi',
      ];
    } else if (widget.user.nik == 'HGT-001') {
      roles = [
        'Chief of Digital Commerce (AMANI Group)',
        'Direktur Utama PT Hanasta Global Teknologi',
      ];
    } else {
      roles = [
        'Chief of Railways & Transportation',
        'Head of Strategic Project Taskforce',
      ];
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: const [
            Icon(Icons.swap_horiz_rounded, color: AppColors.primary),
            SizedBox(width: 10),
            Text('Multi-Role Switcher', style: TextStyle(fontSize: 18)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih mode wewenang portofolio aktif Anda:',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 12),
            ...roles.map((r) {
              final isSelected = _activeRoleView.contains(r.split(' ')[0]);
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
                    r,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? AppColors.primary : AppColors.textPrimary,
                      fontSize: 13,
                    ),
                  ),
                  trailing: isSelected ? const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 20) : null,
                  onTap: () {
                    setState(() => _activeRoleView = r);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Beralih ke mode wewenang: $r'),
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
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
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
            Text('PIN Otorisasi Eksekutif', style: TextStyle(fontSize: 18)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Masukkan 6-digit PIN otorisasi transaksi & approval:',
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
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('PIN Otorisasi Eksekutif berhasil diperbarui.'),
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
            Text('Keluar Akun Eksekutif?'),
          ],
        ),
        content: Text(
          'Apakah Anda yakin ingin keluar dari akun ${widget.user.name}?',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
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
              // Profile Card
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
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                      child: Text(
                        widget.user.name.isNotEmpty
                            ? widget.user.name.split(' ').map((n) => n[0]).take(2).join()
                            : 'CH',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
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
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 8),

                    // Multi-role Switcher Button
                    InkWell(
                      onTap: _showMultiRoleDialog,
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
                            const Icon(Icons.swap_horiz_rounded, color: AppColors.primary, size: 22),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Wewenang Aktif (Multi-Role):', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                                  Text(
                                    _activeRoleView,
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

              // Executive Security Settings
              const Text('Keamanan & Otorisasi Eksekutif', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
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
                      title: const Text('Biometrik / Face ID Eksekutif', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      subtitle: const Text('Login instan & otorisasi approval dengan sidik jari/wajah', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      secondary: const Icon(Icons.fingerprint_rounded, color: AppColors.primary),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      onTap: _showPinDialog,
                      leading: const Icon(Icons.dialpad_rounded, color: AppColors.primary),
                      title: const Text('Atur PIN Otorisasi 6-Digit', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      subtitle: const Text('Digunakan untuk otorisasi final persetujuan dana/cuti', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
                    ),
                    const Divider(height: 1),
                    SwitchListTile(
                      value: _pushNotifications,
                      onChanged: (val) => setState(() => _pushNotifications = val),
                      title: const Text('Notifikasi Real-Time Persetujuan', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      subtitle: const Text('Peringatan instan saat ada pengajuan mendesak dari Head/Manager', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      secondary: const Icon(Icons.notifications_active_outlined, color: AppColors.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Akun & Bantuan
              const Text('Akun & Bantuan', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
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
                      leading: const Icon(Icons.headset_mic_outlined, color: Colors.teal),
                      title: const Text('Executive Concierge & IT Support', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                      subtitle: const Text('Dukungan prioritas tim IT AMANI Group 24/7', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Hotline IT Support: +62 812-3456-7890 (24 Jam Prioritas)'),
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
