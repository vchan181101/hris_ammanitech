import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/user_model.dart';
import '../../theme/app_colors.dart';
import '../login_screen.dart';
import '../../features/auth/presentation/widgets/forgot_password_modal.dart';

class EssProfileTab extends StatefulWidget {
  final UserModel user;
  final VoidCallback? onBack;

  const EssProfileTab({
    super.key,
    required this.user,
    this.onBack,
  });

  @override
  State<EssProfileTab> createState() => _EssProfileTabState();
}

class _EssProfileTabState extends State<EssProfileTab> {
  int _selectedTabIndex = 0; // 0: Keamanan, 1: Preferensi, 2: Operasional HR, 3: Bantuan & Sistem

  // Settings State
  bool _biometricEnabled = true;
  bool _pinSecurityActive = true;
  String _cacheSize = '42 MB';
  String _selectedLanguage = 'ID 🇮🇩';
  String _selectedTheme = 'Terang';
  String _tolerancePreset = '15 Min';

  // Notification Filters
  bool _notifHighPriority = true;
  bool _notifStandard = true;
  bool _notifSilent = false;

  final List<String> _categories = [
    'Keamanan',
    'Preferensi',
    'Operasional HR',
    'Bantuan & Sistem',
  ];

  // ================= MODALS & DIALOGS =================

  void _showEditProfileModal() {
    final nameController = TextEditingController(text: widget.user.name);
    final emailController = TextEditingController(text: widget.user.email);
    final phoneController = TextEditingController(text: '+62 813-2233-4455');
    final addressController = TextEditingController(text: 'Jakarta Selatan, DKI Jakarta');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Icon(Icons.edit_note_rounded, color: Color(0xFF1D4ED8), size: 24),
                  SizedBox(width: 8),
                  Text(
                    'Edit Profil & Dokumen Staff',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nama Lengkap',
                  filled: true,
                  fillColor: AppColors.inputBackground,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email Kantor',
                  filled: true,
                  fillColor: AppColors.inputBackground,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'No. Handphone / WhatsApp',
                  filled: true,
                  fillColor: AppColors.inputBackground,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Alamat Domisili',
                  filled: true,
                  fillColor: AppColors.inputBackground,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Unggah Ulang Dokumen & Sertifikat HR:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('File picker dibuka: Memilih berkas sertifikat HR...')),
                  );
                },
                icon: const Icon(Icons.upload_file_rounded),
                label: const Text('Pilih Berkas PDF / Sertifikat (Max 5MB)'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 44),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Perubahan data profil & berkas berhasil disimpan!'),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D4ED8),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Simpan Perubahan', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showChangePasswordModal() {
    ForgotPasswordModal.show(context);
  }

  void _triggerBiometricPrompt() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF1D4ED8).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.fingerprint_rounded, size: 54, color: Color(0xFF1D4ED8)),
            ),
            const SizedBox(height: 18),
            const Text(
              'Sentuh Sensor Sidik Jari',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Autentikasi biometrik sistem untuk login instan & validasi sensitif.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Batal'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() => _biometricEnabled = true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Biometrik sidik jari berhasil diverifikasi & diaktifkan!'),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D4ED8),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Verifikasi Sekarang'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showPinSecurityModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Icon(Icons.pin_outlined, size: 36, color: Color(0xFF1D4ED8)),
            const SizedBox(height: 10),
            const Text(
              'PIN Keamanan 6-Digit',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Proteksi ganda untuk data rekapitulasi gaji, BPJS, & klaim bernilai besar.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                6,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1D4ED8),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() => _pinSecurityActive = !_pinSecurityActive);
                    },
                    style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    child: Text(_pinSecurityActive ? 'Nonaktifkan PIN' : 'Aktifkan PIN'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('PIN Keamanan 6-digit berhasil diperbarui!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1D4ED8),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Ubah PIN'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showConnectedDevicesModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.65,
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Perangkat Terhubung',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Daftar sesi aktif yang menggunakan kredensial akun HRIS Anda.',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildDeviceTile(
                    title: 'Samsung Galaxy S23 Ultra',
                    subtitle: 'Aplikasi Android • Jakarta Selatan (Cyber 2 Tower)',
                    time: 'Saat ini (Aktif)',
                    isCurrent: true,
                    icon: Icons.phone_android_rounded,
                  ),
                  const SizedBox(height: 12),
                  _buildDeviceTile(
                    title: 'Chrome Browser (Windows 11)',
                    subtitle: 'Web Portal HRIS • IP: 182.253.11.24',
                    time: 'Aktif 2 jam lalu',
                    isCurrent: false,
                    icon: Icons.laptop_windows_rounded,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Sesi di perangkat lain telah diputus paksa (Force Logout)!'),
                      backgroundColor: AppColors.warning,
                    ),
                  );
                },
                icon: const Icon(Icons.logout_rounded, color: AppColors.error),
                label: const Text('Force Logout Semua Perangkat Lain', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.error),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNotificationSubMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: const EdgeInsets.all(22),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Notifikasi & Alur Verifikasi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text('Atur prioritas bunyi & getar untuk peringatan operasional.', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              const SizedBox(height: 14),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Prioritas Tinggi (Sound & Getar)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                subtitle: const Text('Reminder PKWT < 30 hari & kendala GPS absensi', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                value: _notifHighPriority,
                activeTrackColor: const Color(0xFF1D4ED8),
                onChanged: (val) {
                  setModalState(() => _notifHighPriority = val);
                  setState(() => _notifHighPriority = val);
                },
              ),
              const Divider(height: 1),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Notifikasi Standar', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                subtitle: const Text('Pengajuan Cuti, Izin, Lembur & Reimbursement baru', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                value: _notifStandard,
                activeTrackColor: const Color(0xFF1D4ED8),
                onChanged: (val) {
                  setModalState(() => _notifStandard = val);
                  setState(() => _notifStandard = val);
                },
              ),
              const Divider(height: 1),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Notifikasi Silent / Ringkasan', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                subtitle: const Text('Broadcast pengumuman holding non-mendesak', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                value: _notifSilent,
                activeTrackColor: const Color(0xFF1D4ED8),
                onChanged: (val) {
                  setModalState(() => _notifSilent = val);
                  setState(() => _notifSilent = val);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pilih Bahasa Aplikasi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),
            ListTile(
              title: const Text('Bahasa Indonesia (ID 🇮🇩)'),
              trailing: _selectedLanguage == 'ID 🇮🇩' ? const Icon(Icons.check_circle_rounded, color: Color(0xFF1D4ED8)) : null,
              onTap: () {
                setState(() => _selectedLanguage = 'ID 🇮🇩');
                Navigator.pop(context);
              },
            ),
            const Divider(height: 1),
            ListTile(
              title: const Text('English (EN 🇺🇸)'),
              trailing: _selectedLanguage == 'EN 🇺🇸' ? const Icon(Icons.check_circle_rounded, color: Color(0xFF1D4ED8)) : null,
              onTap: () {
                setState(() => _selectedLanguage = 'EN 🇺🇸');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pilih Tema Tampilan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),
            ListTile(
              leading: const Icon(Icons.light_mode_rounded, color: Color(0xFFD97706)),
              title: const Text('Mode Terang (Light Mode)'),
              trailing: _selectedTheme == 'Terang' ? const Icon(Icons.check_circle_rounded, color: Color(0xFF1D4ED8)) : null,
              onTap: () {
                setState(() => _selectedTheme = 'Terang');
                Navigator.pop(context);
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.dark_mode_rounded, color: Color(0xFF475569)),
              title: const Text('Mode Gelap (Dark Mode)'),
              trailing: _selectedTheme == 'Gelap' ? const Icon(Icons.check_circle_rounded, color: Color(0xFF1D4ED8)) : null,
              onTap: () {
                setState(() => _selectedTheme = 'Gelap');
                Navigator.pop(context);
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.settings_suggest_rounded, color: Color(0xFF0284C7)),
              title: const Text('Ikuti Pengaturan Sistem'),
              trailing: _selectedTheme == 'Sistem' ? const Icon(Icons.check_circle_rounded, color: Color(0xFF1D4ED8)) : null,
              onTap: () {
                setState(() => _selectedTheme = 'Sistem');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDevicePermissionsModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Izin Perangkat Aplikasi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),
            _buildPermissionItem('GPS & Lokasi Presensi', 'Diperlukan untuk geofencing clock-in', true),
            _buildPermissionItem('Kamera', 'Untuk foto kehadiran & bukti reimbursement', true),
            _buildPermissionItem('Penyimpanan (Storage)', 'Untuk mengunduh dan melihat berkas PDF', true),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D4ED8),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Tutup'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTolerancePresetSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Preset Toleransi Keterlambatan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('Batas acuan penyesuaian absensi harian yang diverifikasi Staff HR.', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            const SizedBox(height: 16),
            for (final preset in ['0 Menit (Ketat)', '10 Menit', '15 Min (Standar Holding)', '30 Menit (Proyek/Field)'])
              ListTile(
                title: Text(preset),
                trailing: _tolerancePreset == preset.split(' ')[0] || (_tolerancePreset == '15 Min' && preset.startsWith('15'))
                    ? const Icon(Icons.check_circle_rounded, color: Color(0xFF1D4ED8))
                    : null,
                onTap: () {
                  setState(() => _tolerancePreset = preset.split(' ')[0] == '15' ? '15 Min' : preset.split(' ')[0]);
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showBroadcastTemplateModal() {
    final templates = [
      {
        'title': 'Pengingat Upload Kwitansi Medical / Klaim',
        'desc': 'Yth. Rekan Karyawan AMANI Tech, mohon segera mengunggah bukti/kwitansi sah reimbursement Anda sebelum tanggal 20 bulan berjalan.',
      },
      {
        'title': 'Tagihan Evaluasi Masa Kontrak PKWT (< 30 Hari)',
        'desc': 'Halo [Nama Karyawan], masa kontrak kerja Anda akan berakhir dalam 30 hari. Silakan koordinasikan jadwal evaluasi performa bersama atasan divisi.',
      },
      {
        'title': 'Peringatan Kendala Presensi Berulang',
        'desc': 'Mohon konfirmasi keterangan kehadiran Anda untuk tanggal terkait karena sistem mendeteksi clock-out tidak tercatat.',
      },
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Template Pesan / Broadcast', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('Draf siap pakai untuk dikirimkan via WhatsApp atau Email karyawan.', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            const SizedBox(height: 14),
            Expanded(
              child: ListView.separated(
                itemCount: templates.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, idx) {
                  final t = templates[idx];
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        const SizedBox(height: 6),
                        Text(t['desc']!, style: const TextStyle(fontSize: 12, color: Color(0xFF475569), height: 1.35)),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: t['desc']!));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Template pesan tersalin ke clipboard!')),
                                );
                              },
                              icon: const Icon(Icons.copy_rounded, size: 16),
                              label: const Text('Salin Template'),
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

  void _showApprovalChainModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Matriks Alur Approval (Chain)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('Tingkatan persetujuan pengajuan cuti, klaim, dan operasional holding.', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            const SizedBox(height: 18),
            _buildChainStep('Level 1: Staff HR & GA (Mia Aulia)', 'Verifikasi administrasi, lampiran, & kelayakan berkas', true),
            _buildChainStep('Level 2: Head of HR & GA (Djoko Kiswantoro)', 'Validasi kuota cuti & rekomendasi manajerial', true),
            _buildChainStep('Level 3: Direktur Utama (Dimas Pasurangga)', 'Approval final persetujuan resmi holding', false),
          ],
        ),
      ),
    );
  }

  void _showClearCacheDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.delete_sweep_rounded, color: Color(0xFFD97706)),
            SizedBox(width: 8),
            Text('Hapus Cache Data?'),
          ],
        ),
        content: Text(
          'Mengosongkan memori sementara dokumen (PDF & Foto lampiran $_cacheSize) yang diunduh saat verifikasi agar aplikasi tetap ringan.',
          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _cacheSize = '0 MB');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cache data lokal (42 MB) berhasil dibersihkan!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD97706),
              foregroundColor: Colors.white,
            ),
            child: const Text('Bersihkan'),
          ),
        ],
      ),
    );
  }

  void _showHelpCenterModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pusat Bantuan & SOP HR', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),
            ListTile(
              leading: const Icon(Icons.menu_book_rounded, color: Color(0xFF1D4ED8)),
              title: const Text('SOP Verifikasi Cuti & Izin Karyawan'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {},
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.receipt_long_rounded, color: Color(0xFF10B981)),
              title: const Text('Prosedur Audit Klaim & Nota Reimbursement'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {},
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.gavel_rounded, color: Color(0xFF7C3AED)),
              title: const Text('Regulasi PKWT & Ketenagakerjaan Group'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  void _showItSupportModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hubungi IT Support', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(12)),
              child: const Row(
                children: [
                  Icon(Icons.check_circle_rounded, color: Color(0xFF1D4ED8), size: 18),
                  SizedBox(width: 8),
                  Text('Server Status: Operational (Normal)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1D4ED8))),
                ],
              ),
            ),
            const SizedBox(height: 14),
            ListTile(
              leading: const Icon(Icons.chat_rounded, color: Color(0xFF10B981)),
              title: const Text('WhatsApp IT Helpdesk Group'),
              subtitle: const Text('+62 812-9988-7766 (Fast Response)'),
              onTap: () {},
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.mail_rounded, color: Color(0xFF1D4ED8)),
              title: const Text('Email IT Support'),
              subtitle: const Text('support@amanitech.co.id'),
              onTap: () {},
            ),
          ],
        ),
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
            Text('Keluar Akun?'),
          ],
        ),
        content: Text(
          'Apakah Anda yakin ingin keluar dari akun HRIS ${widget.user.name}?',
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
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }

  // ================= MAIN BUILD =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Header & Card Profil (Sesuai Gambar 2)
            _buildProfileHeaderCard(),

            // 2. Category Tab Filter Pills (Keamanan, Preferensi, Operasional HR, Bantuan & Sistem)
            _buildCategoryTabs(),

            // 3. Scrollable Content Section
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_selectedTabIndex == 0) _buildSecuritySection(),
                    if (_selectedTabIndex == 1) _buildPreferencesSection(),
                    if (_selectedTabIndex == 2) _buildOperationalHrSection(),
                    if (_selectedTabIndex == 3) _buildHelpSystemSection(),

                    const SizedBox(height: 24),
                    // Version info footer
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'App Version 2.4.0 (Build 20261102)',
                            style: TextStyle(fontSize: 11, color: Colors.grey.shade500, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'AMANI TECH GROUP • Enterprise HRIS Platform',
                            style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= SECTIONS & CARDS =================

  Widget _buildProfileHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
      decoration: const BoxDecoration(
        color: Color(0xFF1D4ED8), // Deep blue theme (Gambar 2)
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Bar (PENGATURAN di Tengah)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: widget.onBack ?? () {
                  if (Navigator.canPop(context)) Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'PENGATURAN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.help_outline_rounded, color: Colors.white, size: 20),
                onPressed: _showHelpCenterModal,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Profil Card Body (Gambar 2: Avatar + Online Dot + Info + Edit Profil Button)
          Row(
            children: [
              // Avatar with Online Badge
              Stack(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: const Color(0xFFEFF6FF),
                      child: Text(
                        widget.user.name.isNotEmpty ? widget.user.name[0] : 'M',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1D4ED8),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: const Color(0xFF22C55E), // Green online dot
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              // Name, Role & Email
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            widget.user.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'HR Staff',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Staff HR & GA • ID: ${widget.user.nik}',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      widget.user.email,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.75),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Button "Edit Profil"
              OutlinedButton(
                onPressed: _showEditProfileModal,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.white.withValues(alpha: 0.6), width: 1.2),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  minimumSize: Size.zero,
                ),
                child: const Text(
                  'Edit Profil',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: List.generate(_categories.length, (index) {
            final isSelected = _selectedTabIndex == index;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                onTap: () => setState(() => _selectedTabIndex = index),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFEFF6FF) : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF1D4ED8) : const Color(0xFFE2E8F0),
                      width: isSelected ? 1.4 : 1.0,
                    ),
                  ),
                  child: Text(
                    _categories[index],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected ? const Color(0xFF1D4ED8) : const Color(0xFF64748B),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // ================= SECTION 1: KEAMANAN & AKUN =================

  Widget _buildSecuritySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('KEAMANAN & AKUN PRIBADI'),
        const SizedBox(height: 8),
        _buildCardContainer(
          child: Column(
            children: [
              _buildListTileItem(
                icon: Icons.lock_outline_rounded,
                iconColor: const Color(0xFF2563EB),
                title: 'Ubah Kata Sandi',
                subtitle: 'Terakhir diubah 30 hari lalu',
                trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFF94A3B8)),
                onTap: _showChangePasswordModal,
              ),
              const Divider(height: 1, indent: 54),
              _buildSwitchTileItem(
                icon: Icons.fingerprint_rounded,
                iconColor: const Color(0xFF8B5CF6),
                title: 'Autentikasi Biometrik',
                subtitle: 'Fingerprint / Face ID',
                value: _biometricEnabled,
                onChanged: (val) {
                  if (val) {
                    _triggerBiometricPrompt();
                  } else {
                    setState(() => _biometricEnabled = false);
                  }
                },
              ),
              const Divider(height: 1, indent: 54),
              _buildListTileItem(
                icon: Icons.pin_outlined,
                iconColor: const Color(0xFF10B981),
                title: 'PIN Keamanan 6-Digit',
                subtitle: 'Akses dokumen kerahasiaan & klaim',
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _pinSecurityActive ? const Color(0xFFDCFCE7) : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _pinSecurityActive ? 'Aktif' : 'Nonaktif',
                    style: TextStyle(
                      color: _pinSecurityActive ? const Color(0xFF16A34A) : const Color(0xFF64748B),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: _showPinSecurityModal,
              ),
              const Divider(height: 1, indent: 54),
              _buildListTileItem(
                icon: Icons.devices_rounded,
                iconColor: const Color(0xFFF59E0B),
                title: 'Perangkat Terhubung',
                subtitle: '2 Perangkat Aktif',
                trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFF94A3B8)),
                onTap: _showConnectedDevicesModal,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ================= SECTION 2: PREFERENSI & APLIKASI =================

  Widget _buildPreferencesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('PREFERENSI & APLIKASI'),
        const SizedBox(height: 8),
        _buildCardContainer(
          child: Column(
            children: [
              _buildListTileItem(
                icon: Icons.notifications_active_outlined,
                iconColor: const Color(0xFF0284C7),
                title: 'Notifikasi & Alur Verifikasi',
                subtitle: 'Push Notif Cuti/Izin/Lembur & Reminder PKWT',
                trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFF94A3B8)),
                onTap: _showNotificationSubMenu,
              ),
              const Divider(height: 1, indent: 54),
              _buildListTileItem(
                icon: Icons.language_rounded,
                iconColor: const Color(0xFF059669),
                title: 'Bahasa Aplikasi',
                subtitle: 'Pilihan bahasa antarmuka sistem',
                trailing: _buildPillBadge(_selectedLanguage, const Color(0xFF059669)),
                onTap: _showLanguageSelector,
              ),
              const Divider(height: 1, indent: 54),
              _buildListTileItem(
                icon: Icons.palette_outlined,
                iconColor: const Color(0xFF7C3AED),
                title: 'Tema Tampilan',
                subtitle: 'Mode Terang / Gelap / Sistem',
                trailing: _buildPillBadge(_selectedTheme, const Color(0xFF7C3AED)),
                onTap: _showThemeSelector,
              ),
              const Divider(height: 1, indent: 54),
              _buildListTileItem(
                icon: Icons.security_rounded,
                iconColor: const Color(0xFF475569),
                title: 'Izin Perangkat',
                subtitle: 'GPS Lokasi, Kamera & Storage',
                trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFF94A3B8)),
                onTap: _showDevicePermissionsModal,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ================= SECTION 3: PENGATURAN OPERASIONAL HR =================

  Widget _buildOperationalHrSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('PENGATURAN OPERASIONAL HR'),
        const SizedBox(height: 8),
        _buildCardContainer(
          child: Column(
            children: [
              _buildListTileItem(
                icon: Icons.timer_outlined,
                iconColor: const Color(0xFFD97706),
                title: 'Preset Toleransi Keterlambatan',
                subtitle: 'Batas toleransi penyesuaian absensi harian',
                trailing: _buildPillBadge(_tolerancePreset, const Color(0xFFD97706)),
                onTap: _showTolerancePresetSelector,
              ),
              const Divider(height: 1, indent: 54),
              _buildListTileItem(
                icon: Icons.chat_bubble_outline_rounded,
                iconColor: const Color(0xFF0D9488),
                title: 'Template Pesan / Broadcast',
                subtitle: 'Draf cepat WhatsApp & Email staf',
                trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFF94A3B8)),
                onTap: _showBroadcastTemplateModal,
              ),
              const Divider(height: 1, indent: 54),
              _buildListTileItem(
                icon: Icons.account_tree_outlined,
                iconColor: const Color(0xFF2563EB),
                title: 'Matriks Alur Approval (Chain)',
                subtitle: 'Hierarki persetujuan cuti & reimbursement',
                trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFF94A3B8)),
                onTap: _showApprovalChainModal,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ================= SECTION 4: BANTUAN & SISTEM =================

  Widget _buildHelpSystemSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('BANTUAN & SISTEM'),
        const SizedBox(height: 8),
        _buildCardContainer(
          child: Column(
            children: [
              _buildListTileItem(
                icon: Icons.menu_book_rounded,
                iconColor: const Color(0xFF0284C7),
                title: 'Pusat Bantuan & SOP HR',
                subtitle: 'Panduan regulasi & prosedur operasional',
                trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFF94A3B8)),
                onTap: _showHelpCenterModal,
              ),
              const Divider(height: 1, indent: 54),
              _buildListTileItem(
                icon: Icons.support_agent_rounded,
                iconColor: const Color(0xFF10B981),
                title: 'Hubungi IT Support',
                subtitle: 'Helpdesk teknis & status server holding',
                trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFF94A3B8)),
                onTap: _showItSupportModal,
              ),
              const Divider(height: 1, indent: 54),
              _buildListTileItem(
                icon: Icons.cleaning_services_rounded,
                iconColor: const Color(0xFFF59E0B),
                title: 'Hapus Cache Data Lokal',
                subtitle: 'Kosongkan dokumen PDF & lampiran sementara',
                trailing: _buildPillBadge(_cacheSize, const Color(0xFFF59E0B)),
                onTap: _showClearCacheDialog,
              ),
              const Divider(height: 1, indent: 54),
              _buildListTileItem(
                icon: Icons.logout_rounded,
                iconColor: AppColors.error,
                title: 'Keluar Akun (Logout)',
                subtitle: 'Keluar dari sesi portal HRIS aktif',
                trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.error),
                isDestructive: true,
                onTap: _showLogoutDialog,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ================= HELPER WIDGETS =================

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Color(0xFF64748B),
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _buildCardContainer({required Widget child}) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: child,
      ),
    );
  }

  Widget _buildListTileItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Widget trailing,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 18),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: isDestructive ? AppColors.error : AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 11,
          color: isDestructive ? AppColors.error.withValues(alpha: 0.8) : const Color(0xFF64748B),
        ),
      ),
      trailing: trailing,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
    );
  }

  Widget _buildSwitchTileItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 18),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
      ),
      trailing: Switch(
        value: value,
        activeTrackColor: const Color(0xFF1D4ED8),
        onChanged: onChanged,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
    );
  }

  Widget _buildPillBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDeviceTile({
    required String title,
    required String subtitle,
    required String time,
    required bool isCurrent,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrent ? const Color(0xFFEFF6FF) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isCurrent ? const Color(0xFFBFDBFE) : const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Icon(icon, color: isCurrent ? const Color(0xFF1D4ED8) : const Color(0xFF64748B), size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isCurrent) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1D4ED8),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text('Ini', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                const SizedBox(height: 2),
                Text(time, style: TextStyle(fontSize: 10, color: isCurrent ? const Color(0xFF1D4ED8) : const Color(0xFF94A3B8), fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionItem(String title, String desc, bool granted) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            granted ? Icons.check_circle_rounded : Icons.cancel_rounded,
            color: granted ? const Color(0xFF10B981) : AppColors.error,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(desc, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChainStep(String title, String desc, bool isNext) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: const BoxDecoration(color: Color(0xFF1D4ED8), shape: BoxShape.circle),
              child: const Icon(Icons.check, size: 12, color: Colors.white),
            ),
            if (isNext) Container(width: 2, height: 42, color: const Color(0xFFBFDBFE)),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 2),
              Text(desc, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }
}
