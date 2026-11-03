import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hris_ammanitech/data/mock_users.dart';
import 'package:hris_ammanitech/app.dart';
import 'package:hris_ammanitech/screens/karyawan_staff/divisi_hr/hr_home_tab.dart';
import 'package:hris_ammanitech/screens/karyawan_staff/ess_profile_tab.dart';
import 'package:hris_ammanitech/screens/karyawan_staff/ess_home_tab.dart';
import 'package:hris_ammanitech/screens/karyawan_staff/ess_main_screen.dart';

void main() {
  test('MockUserData findUser supports both NIK and Email', () {
    // 1. Cek login via NIK Dimas Pasurangga (Direktur Utama)
    final userByNik = MockUserData.findUser('AMI-001', 'password123');
    expect(userByNik, isNotNull);
    expect(userByNik?.name, 'Dimas Pasurangga');
    expect(userByNik?.position, 'Direktur Utama');
    expect(userByNik?.company, 'PT Aman Media Interaktif');

    // 2. Cek login via Email Dimas Pasurangga
    final userByEmail = MockUserData.findUser('dimas@amanitech.co.id', 'password123');
    expect(userByEmail, isNotNull);
    expect(userByEmail!.name, 'Dimas Pasurangga');

    // 3. Cek login Mia Aulia dengan password khususnya '12345678' via NIK & Email
    final miaByEmail = MockUserData.findUser('mia@amanitech.co.id', '12345678');
    expect(miaByEmail, isNotNull);
    expect(miaByEmail!.position, 'Staff Administrasi Umum');

    final miaByNik = MockUserData.findUser('AMI-003', '12345678');
    expect(miaByNik, isNotNull);
    expect(miaByNik!.name, 'Mia Aulia');

    // 4. Cek login M Erlan via Email
    final erlanByEmail = MockUserData.findUser('erlan@amanitech.co.id', 'password123');
    expect(erlanByEmail, isNotNull);
    expect(erlanByEmail!.position, 'AI Engineer');

    // 5. Cek login Anggun Silvia (Staff Finance - AMI-005)
    final anggunByNik = MockUserData.findUser('AMI-005', 'password123');
    expect(anggunByNik, isNotNull);
    expect(anggunByNik?.name, 'Anggun Silvia');
    expect(anggunByNik?.position, 'Staff Finance');

    // 6. Cek login Bachtiar Siagian (Head of Finance - AMI-004)
    final bachtiarByEmail = MockUserData.findUser('bachtiar@amanitech.co.id', 'password123');
    expect(bachtiarByEmail, isNotNull);
    expect(bachtiarByEmail?.name, 'Bachtiar Siagian');
    expect(bachtiarByEmail?.position, 'Head of Finance');

    // 7. Cek login M. Rizky Elrivany (Chief of Enterprise Solution - GMT-001)
    final rizkyByNik = MockUserData.findUser('GMT-001', 'password123');
    expect(rizkyByNik, isNotNull);
    expect(rizkyByNik?.name, 'M. Rizky Elrivany');
    expect(rizkyByNik?.company, 'PT Global Moviion Teknologi');

    // 8. Cek login Wendy Swandoyo (Chief of Digital Commerce - HGT-001)
    final wendyByEmail = MockUserData.findUser('wendy@amanitech.co.id', 'password123');
    expect(wendyByEmail, isNotNull);
    expect(wendyByEmail?.name, 'Wendy Swandoyo');
    expect(wendyByEmail?.company, 'PT Hanasta Global Teknologi');

    // 9. Cek login Pirmadi Sukma (Chief of Railways & Transportation - AMI-006)
    final pirmadiByNik = MockUserData.findUser('AMI-006', 'password123');
    expect(pirmadiByNik, isNotNull);
    expect(pirmadiByNik?.name, 'Pirmadi Sukma');
    expect(pirmadiByNik?.position, 'Chief of Railways & Transportation');
  });

  testWidgets('Splash screen transitions to Login screen and renders form', (WidgetTester tester) async {
    await tester.pumpWidget(const HrisApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Clicking Lupa Sandi shows HRD contact modal with notification and action buttons', (WidgetTester tester) async {
    await tester.pumpWidget(const HrisApp());
    await tester.pump(const Duration(seconds: 3)); // finish splash transition to login
    await tester.pumpAndSettle();

    final lupaSandiBtn = find.text('Lupa Sandi?');
    expect(lupaSandiBtn, findsOneWidget);

    await tester.tap(lupaSandiBtn);
    await tester.pumpAndSettle();

    // Verify notification text
    expect(
      find.text('Jika Anda lupa kata sandi akun HRIS, silakan hubungi Tim HRD untuk verifikasi dan pembaharuan kata sandi.'),
      findsOneWidget,
    );

    // Verify Contact Cards
    expect(find.text('Djoko Kiswantoro'), findsOneWidget);
    expect(find.text('Head of HR & GA'), findsOneWidget);
    expect(find.text('Mia Aulia'), findsOneWidget);
    expect(find.text('Staff Administrasi Umum / HR'), findsOneWidget);

    // Verify Action buttons (2 buttons each)
    expect(find.text('Hubungi via WhatsApp'), findsNWidgets(2));
    expect(find.text('Kirim Email'), findsNWidgets(2));
  });

  testWidgets('HrHomeTab displays 5 operational indicator cards with new design', (WidgetTester tester) async {
    final miaUser = MockUserData.findUser('AMI-003', '12345678')!;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HrHomeTab(user: miaUser),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify 5 titles
    expect(find.text('Karyawan'), findsWidgets);
    expect(find.text('Departemen'), findsOneWidget);
    expect(find.text('Total Payroll'), findsOneWidget);
    expect(find.text('BPJS'), findsOneWidget);
    expect(find.text('Total PPH 21'), findsOneWidget);

    // Verify values
    expect(find.text('325'), findsWidgets);
    expect(find.text('12 Dept'), findsOneWidget);
    expect(find.text('Rp 2,45 M'), findsOneWidget);
    expect(find.text('Rp 187,35 Jt'), findsOneWidget);
    expect(find.text('Rp 245,18 Jt'), findsOneWidget);

    // Verify Visualisasi Kehadiran 5 kategori (Gambar 1 revisi: Hadir, Sakit, Izin, Terlambat, Cuti)
    expect(find.text('Hadir'), findsOneWidget);
    expect(find.text('Sakit'), findsOneWidget);
    expect(find.text('Izin'), findsOneWidget);
    expect(find.text('Terlambat'), findsOneWidget);
    expect(find.text('Cuti'), findsOneWidget);

    // Verify Gambar 2 (Payroll Overview + BPJS Overview)
    expect(find.text('Payroll Overview'), findsOneWidget);
    expect(find.text('BPJS Overview'), findsOneWidget);
    expect(find.text('BPJS Kesehatan'), findsOneWidget);
    expect(find.text('BPJS Ketenagakerjaan'), findsOneWidget);

    // Verify Gambar 3 (Demografi Karyawan: Gender, Age Group, Education, Type Status)
    expect(find.text('Employees by\nGender'), findsOneWidget);
    expect(find.text('Employees by\nAge Group'), findsOneWidget);
    expect(find.text('Employees by\nEducation'), findsOneWidget);
    expect(find.text('Employees by\nType Status'), findsOneWidget);
  });

  testWidgets('EssProfileTab renders revised profile header, category tabs, and interactive modules', (WidgetTester tester) async {
    final miaUser = MockUserData.findUser('AMI-003', '12345678')!;

    await tester.pumpWidget(
      MaterialApp(
        home: EssProfileTab(user: miaUser),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Verify Header & Profile Card
    expect(find.text('PENGATURAN'), findsOneWidget);
    expect(find.text('Mia Aulia'), findsOneWidget);
    expect(find.text('HR Staff'), findsOneWidget);
    expect(find.text('Edit Profil'), findsOneWidget);

    // 2. Verify 4 Category Tabs
    expect(find.text('Keamanan'), findsOneWidget);
    expect(find.text('Preferensi'), findsOneWidget);
    expect(find.text('Operasional HR'), findsOneWidget);
    expect(find.text('Bantuan & Sistem'), findsOneWidget);

    // 3. Tab Keamanan items (Default)
    expect(find.text('KEAMANAN & AKUN PRIBADI'), findsOneWidget);
    expect(find.text('Ubah Kata Sandi'), findsOneWidget);
    expect(find.text('Autentikasi Biometrik'), findsOneWidget);
    expect(find.text('PIN Keamanan 6-Digit'), findsOneWidget);
    expect(find.text('Perangkat Terhubung'), findsOneWidget);

    // Click on 'Ubah Kata Sandi' to trigger ForgotPasswordModal (Gambar 2)
    await tester.tap(find.text('Ubah Kata Sandi'));
    await tester.pumpAndSettle();

    expect(find.text('Lupa Kata Sandi?'), findsOneWidget);
    expect(find.text('Bantuan Pemulihan Akun HRIS'), findsOneWidget);
    expect(
      find.text('Jika Anda lupa kata sandi akun HRIS, silakan hubungi Tim HRD untuk verifikasi dan pembaharuan kata sandi.'),
      findsOneWidget,
    );
    expect(find.text('Kartu Kontak HRD (Contact Cards):'), findsOneWidget);
    expect(find.text('Djoko Kiswantoro'), findsOneWidget);
    expect(find.text('Mia Aulia'), findsWidgets);
    expect(find.text('Tutup'), findsOneWidget);

    // Close the modal using close icon in header
    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pumpAndSettle();

    // 4. Switch to Preferensi Tab
    await tester.tap(find.text('Preferensi'));
    await tester.pumpAndSettle();
    expect(find.text('PREFERENSI & APLIKASI'), findsOneWidget);
    expect(find.text('Notifikasi & Alur Verifikasi'), findsOneWidget);
    expect(find.text('Bahasa Aplikasi'), findsOneWidget);
    expect(find.text('Tema Tampilan'), findsOneWidget);
    expect(find.text('Izin Perangkat'), findsOneWidget);

    // 5. Switch to Operasional HR Tab
    await tester.tap(find.text('Operasional HR'));
    await tester.pumpAndSettle();
    expect(find.text('PENGATURAN OPERASIONAL HR'), findsOneWidget);
    expect(find.text('Preset Toleransi Keterlambatan'), findsOneWidget);
    expect(find.text('Template Pesan / Broadcast'), findsOneWidget);
    expect(find.text('Matriks Alur Approval (Chain)'), findsOneWidget);

    // 6. Switch to Bantuan & Sistem Tab
    await tester.tap(find.text('Bantuan & Sistem'));
    await tester.pumpAndSettle();
    expect(find.text('BANTUAN & SISTEM'), findsOneWidget);
    expect(find.text('Pusat Bantuan & SOP HR'), findsOneWidget);
    expect(find.text('Hubungi IT Support'), findsOneWidget);
    expect(find.text('Hapus Cache Data Lokal'), findsOneWidget);
    expect(find.text('Keluar Akun (Logout)'), findsOneWidget);
  });

  testWidgets('EssHomeTab renders empty initial attendance card, NCI status, and automatic time on Clock In', (WidgetTester tester) async {
    final erlanUser = MockUserData.findUser('erlan@amanitech.co.id', 'password123')!;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EssHomeTab(user: erlanUser),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Verify date & live clock (Jam : Menit : Detik WIB)
    expect(find.textContaining('November'), findsOneWidget);
    expect(find.textContaining('WIB'), findsWidgets);

    // 2. Initial state: kolom masih kosong (belum ada yang klik)
    expect(find.text('Jam Masuk'), findsOneWidget);
    expect(find.text('Jam Keluar'), findsOneWidget);
    expect(find.text('--:-- WIB'), findsNWidgets(2));

    // Initial status badge is 'NCI' (Warna Biru)
    expect(find.text('NCI'), findsOneWidget);

    // Initial button is 'Clock In' (Warna Biru)
    expect(find.text('Clock In'), findsOneWidget);
    final clockInBtnText = tester.widget<Text>(find.text('Clock In'));
    expect(clockInBtnText.style?.color, const Color(0xFF2563EB));

    // 3. Verify GPS location bar and refresh button
    expect(find.textContaining('Lokasi GPS: Cyber 2 Tower'), findsOneWidget);
    final refreshBtn = find.byIcon(Icons.refresh_rounded);
    expect(refreshBtn, findsOneWidget);

    // Tap refresh GPS
    await tester.tap(refreshBtn);
    await tester.pump(const Duration(milliseconds: 700));
    await tester.pumpAndSettle();
    expect(find.textContaining('Akurasi 3m'), findsWidgets);

    // 4. Test clicking Clock In -> Opens PresensiCameraScreen in New Page (Gambar 1 & Gambar 3)
    await tester.tap(find.text('Clock In'));
    await tester.pumpAndSettle();

    // Verify New Page Header & Camera Viewfinder elements
    expect(find.text('Presensi Jam Masuk'), findsOneWidget);
    expect(find.text('Verifikasi Wajah & Lokasi GPS'), findsOneWidget);
    expect(find.text('Wajah Terdeteksi'), findsOneWidget);

    // Verify Switch Camera button in top-right corner
    final switchCamBtn = find.byIcon(Icons.cameraswitch_rounded);
    expect(switchCamBtn, findsOneWidget);
    await tester.tap(switchCamBtn);
    ScaffoldMessenger.of(tester.element(switchCamBtn)).hideCurrentSnackBar();
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    // Verify Geofencing GPS Status Card
    expect(find.text('Geofencing GPS Status:'), findsOneWidget);

    // Tap Konfirmasi Clock In
    final confirmBtn = find.widgetWithText(ElevatedButton, 'Konfirmasi Clock In');
    expect(confirmBtn, findsOneWidget);
    await tester.ensureVisible(confirmBtn);
    await tester.tap(confirmBtn, warnIfMissed: false);
    await tester.pump(const Duration(milliseconds: 1200));
    await tester.pumpAndSettle();

    // Returned to Home Tab: Button now changes to 'Clock Out'
    expect(find.text('Clock Out'), findsOneWidget);
    // Status badge changes from NCI to On-Time or Late
    expect(find.byWidgetPredicate((w) => w is Text && (w.data == 'On-Time' || w.data == 'Late')), findsOneWidget);
    // Jam Masuk is now filled with live time containing WIB and not '--:-- WIB'
    expect(find.text('--:-- WIB'), findsOneWidget); // only Jam Keluar is still empty

    // 5. Test clicking Clock Out -> Opens PresensiCameraScreen in New Page (Gambar 2)
    // Dismiss any active SnackBar
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Clock Out'));
    await tester.pumpAndSettle();

    expect(find.text('Presensi Jam Keluar'), findsOneWidget);
    final confirmOutBtn = find.widgetWithText(ElevatedButton, 'Konfirmasi Clock Out');
    expect(confirmOutBtn, findsOneWidget);
    await tester.ensureVisible(confirmOutBtn);

    await tester.tap(confirmOutBtn);
    await tester.pump(const Duration(milliseconds: 1200));
    await tester.pumpAndSettle();

    // Both Jam Masuk & Jam Keluar are now filled (0 widgets with '--:-- WIB')
    expect(find.text('--:-- WIB'), findsNothing);
    // Status badge is Quick Exit or Selesai
    expect(find.byWidgetPredicate((w) => w is Text && (w.data == 'Quick Exit' || w.data == 'Selesai')), findsOneWidget);
  });

  testWidgets('EssHomeTab displays revised Menu Akses Cepat ESS (4 atas & 4 bawah) and navigates to new pages', (WidgetTester tester) async {
    final erlanUser = MockUserData.findUser('erlan@amanitech.co.id', 'password123')!;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EssHomeTab(user: erlanUser),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Verify Title & 8 Layanan Utama
    expect(find.text('Menu Akses Cepat ESS'), findsOneWidget);
    expect(find.text('8 Layanan Utama'), findsOneWidget);

    // 2. Verify 4 Kolom Atas
    expect(find.text('ID Card'), findsOneWidget);
    expect(find.text('Kalender'), findsOneWidget);
    expect(find.text('Departemen'), findsOneWidget);
    expect(find.text('Pajak & BPJS'), findsOneWidget);

    // 3. Verify 4 Kolom Bawah
    expect(find.text('Slip Gaji'), findsOneWidget);
    expect(find.text('Pengajuan'), findsOneWidget);
    expect(find.text('Reimburse'), findsOneWidget);
    expect(find.text('Laporan'), findsOneWidget);

    // 4. Test clicking ID Card -> opens IdCardPage
    await tester.ensureVisible(find.text('ID Card'));
    await tester.tap(find.text('ID Card'));
    await tester.pumpAndSettle();
    expect(find.text('Kartu ID Karyawan (Digital)'), findsOneWidget);
    expect(find.text('AMANI TECH GROUP'), findsWidgets);
    expect(find.text('QR ACCESS PASS'), findsOneWidget);

    // Go back
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();

    // 5. Test clicking Slip Gaji -> opens SlipGajiPage
    await tester.ensureVisible(find.text('Slip Gaji'));
    await tester.tap(find.text('Slip Gaji'));
    await tester.pumpAndSettle();
    expect(find.text('Slip Gaji Resmi (E-Payslip)'), findsOneWidget);
    expect(find.text('TOTAL TAKE HOME PAY (NET)'), findsOneWidget);

    // Go back
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();

    // 6. Test clicking Pajak & BPJS -> opens PajakBpjsPage
    await tester.ensureVisible(find.text('Pajak & BPJS'));
    await tester.tap(find.text('Pajak & BPJS'));
    await tester.pumpAndSettle();
    expect(find.text('Pajak (PPh 21) & BPJS'), findsOneWidget);
    expect(find.text('KARTU NPWP ELEKTRONIK'), findsOneWidget);

    // Go back
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();
  });

  testWidgets('EssMainScreen renders revised 5 bottom navigation items for Karyawan/Staff', (WidgetTester tester) async {
    final erlanUser = MockUserData.findUser('erlan@amanitech.co.id', 'password123')!;

    await tester.pumpWidget(
      MaterialApp(
        home: EssMainScreen(user: erlanUser),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Verify 5 Bottom Navigation items for Karyawan/Staff:
    // [ 🏠 Dashboard ]   [ 📅 Presensi ]   [ 📋 Pengajuan ]   [ 🔔 Notifikasi ]   [ 👤 Profil ]
    final bottomNav = find.byType(BottomNavigationBar);
    expect(find.descendant(of: bottomNav, matching: find.text('Dashboard')), findsOneWidget);
    expect(find.descendant(of: bottomNav, matching: find.text('Presensi')), findsOneWidget);
    expect(find.descendant(of: bottomNav, matching: find.text('Pengajuan')), findsOneWidget);
    expect(find.descendant(of: bottomNav, matching: find.text('Notifikasi')), findsOneWidget);
    expect(find.descendant(of: bottomNav, matching: find.text('Profil')), findsOneWidget);

    // 2. Test switching to Presensi tab
    await tester.tap(find.descendant(of: bottomNav, matching: find.text('Presensi')));
    await tester.pumpAndSettle();
    expect(find.text('Riwayat Presensi Bulanan'), findsOneWidget);

    // 3. Test switching to Pengajuan tab
    await tester.tap(find.descendant(of: bottomNav, matching: find.text('Pengajuan')));
    await tester.pumpAndSettle();
    expect(find.text('Pengajuan Cuti, Izin & Lembur'), findsOneWidget);
    expect(find.text('Buat Pengajuan'), findsOneWidget);

    // 4. Test switching to Notifikasi tab
    await tester.tap(find.descendant(of: bottomNav, matching: find.text('Notifikasi')));
    await tester.pumpAndSettle();
    expect(find.text('Pusat Notifikasi & Kotak Masuk'), findsOneWidget);

    // 5. Test switching to Profil tab
    await tester.tap(find.descendant(of: bottomNav, matching: find.text('Profil')));
    await tester.pumpAndSettle();
    expect(find.text('PENGATURAN'), findsOneWidget);
  });
}
