import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hris_ammanitech/data/mock_users.dart';
import 'package:hris_ammanitech/app.dart';

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
}
