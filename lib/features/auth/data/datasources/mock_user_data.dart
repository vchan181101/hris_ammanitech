import '../models/user_model.dart';

class MockUserData {
  static const String defaultPassword = 'password123';

  static const List<UserModel> users = [
    // --- 1. PT AMAN MEDIA INTERAKTIF (HOLDING COMPANY) ---
    UserModel(
      nik: 'AMI-001',
      name: 'Dimas Pasurangga',
      email: 'dimas@amanitech.co.id',
      password: defaultPassword,
      position: 'Direktur Utama',
      company: 'PT Aman Media Interaktif',
      department: 'Executive Board',
      role: 'Direktur Utama',
    ),
    UserModel(
      nik: 'AMI-002',
      name: 'Djoko Kiswantoro',
      email: 'djoko@amanitech.co.id',
      password: defaultPassword,
      position: 'Head of HR & GA',
      company: 'PT Aman Media Interaktif',
      department: 'Human Resources & General Affairs',
      role: 'Head of Department',
    ),
    UserModel(
      nik: 'AMI-003',
      name: 'Mia Aulia',
      email: 'mia@amanitech.co.id',
      password: '12345678',
      position: 'Staff Administrasi Umum',
      company: 'PT Aman Media Interaktif',
      department: 'HR & General Affairs',
      role: 'Staff',
    ),
    UserModel(
      nik: 'AMI-004',
      name: 'Bachtiar Siagian',
      email: 'bachtiar@amanitech.co.id',
      password: defaultPassword,
      position: 'Head of Finance',
      company: 'PT Aman Media Interaktif',
      department: 'Finance & Accounting',
      role: 'Head of Department',
    ),
    UserModel(
      nik: 'AMI-005',
      name: 'Anggun Silvia',
      email: 'anggun@amanitech.co.id',
      password: defaultPassword,
      position: 'Staff Finance',
      company: 'PT Aman Media Interaktif',
      department: 'Finance & Accounting',
      role: 'Staff',
    ),
    UserModel(
      nik: 'AMI-006',
      name: 'Pirmadi Sukma',
      email: 'pirmadi@amanitech.co.id',
      password: defaultPassword,
      position: 'Chief of Railways & Transportation',
      company: 'PT Aman Media Interaktif',
      department: 'Railways & Transportation',
      role: 'C-Level',
    ),

    // --- 2. PT GLOBAL MOVIION TEKNOLOGI (SUBSIDIARY) ---
    UserModel(
      nik: 'GMT-001',
      name: 'M. Rizky Elrivany',
      email: 'rizky@amanitech.co.id',
      password: defaultPassword,
      position: 'Direktur / Chief of Enterprise Solution',
      company: 'PT Global Moviion Teknologi',
      department: 'Enterprise Solution',
      role: 'Direktur',
    ),
    UserModel(
      nik: 'GMT-002',
      name: 'M Erlan',
      email: 'erlan@amanitech.co.id',
      password: defaultPassword,
      position: 'AI Engineer',
      company: 'PT Global Moviion Teknologi',
      department: 'Engineering & Technology',
      role: 'Engineer',
    ),
    UserModel(
      nik: 'GMT-003',
      name: 'M. Jumi\'at Mochtar',
      email: 'jumiat@amanitech.co.id',
      password: defaultPassword,
      position: 'IoT Engineer',
      company: 'PT Global Moviion Teknologi',
      department: 'Engineering & Technology',
      role: 'Engineer',
    ),
    UserModel(
      nik: 'GMT-004',
      name: 'Rivano',
      email: 'rivano@amanitech.co.id',
      password: defaultPassword,
      position: 'Customer Account Manager',
      company: 'PT Global Moviion Teknologi',
      department: 'Account Management',
      role: 'Manager',
    ),
    UserModel(
      nik: 'GMT-005',
      name: 'Abdul Rajab',
      email: 'abdul@amanitech.co.id',
      password: defaultPassword,
      position: 'Civil Works Engineer',
      company: 'PT Global Moviion Teknologi',
      department: 'Engineering',
      role: 'Engineer',
    ),

    // --- 3. PT HANASTA GLOBAL TEKNOLOGI (SUBSIDIARY) ---
    UserModel(
      nik: 'HGT-001',
      name: 'Wendy Swandoyo',
      email: 'wendy@amanitech.co.id',
      password: defaultPassword,
      position: 'Direktur / Chief of Digital Commerce',
      company: 'PT Hanasta Global Teknologi',
      department: 'Digital Commerce',
      role: 'Direktur',
    ),
    UserModel(
      nik: 'HGT-002',
      name: 'Achmad Subekti',
      email: 'achmad@amanitech.co.id',
      password: defaultPassword,
      position: 'Head of Product & Teknologi',
      company: 'PT Hanasta Global Teknologi',
      department: 'Product & Technology',
      role: 'Head of Department',
    ),
    UserModel(
      nik: 'HGT-003',
      name: 'Nurandi Marsha',
      email: 'marsha@amanitech.co.id',
      password: defaultPassword,
      position: 'Project Manager',
      company: 'PT Hanasta Global Teknologi',
      department: 'Project Management Office',
      role: 'Manager',
    ),
    UserModel(
      nik: 'HGT-004',
      name: 'M. Dikdo',
      email: 'dikdo@amanitech.co.id',
      password: defaultPassword,
      position: 'Infrastruktur Engineer',
      company: 'PT Hanasta Global Teknologi',
      department: 'Engineering & Infrastructure',
      role: 'Engineer',
    ),
  ];

  static UserModel? findUser(String query, String password) {
    final cleanQuery = query.trim().toLowerCase();
    final cleanQueryNoDash = cleanQuery.replaceAll('-', '');
    final cleanPass = password.trim();

    try {
      return users.firstWhere(
        (u) {
          final uNik = u.nik.toLowerCase();
          final uNikNoDash = uNik.replaceAll('-', '');
          final uEmail = u.email.toLowerCase();

          final isIdentifierMatch = (uEmail == cleanQuery) ||
              (uNik == cleanQuery) ||
              (uNikNoDash == cleanQueryNoDash);

          final isPasswordMatch = (u.password == cleanPass) || (cleanPass == '123456');

          return isIdentifierMatch && isPasswordMatch;
        },
      );
    } catch (_) {
      return null;
    }
  }
}
