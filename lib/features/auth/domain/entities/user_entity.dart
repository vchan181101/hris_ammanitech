class UserEntity {
  final String nik;
  final String name;
  final String email;
  final String position;
  final String company;
  final String department;
  final String role;
  final String gender; // 'Male', 'Female'
  final String ageGroup; // '21-30', '31-40', '41-50', '51-60'
  final String education; // 'D3', 'S1', 'S2'
  final String employmentType; // 'TETAP', 'KONTRAK'

  const UserEntity({
    required this.nik,
    required this.name,
    required this.email,
    required this.position,
    required this.company,
    required this.department,
    required this.role,
    this.gender = 'Male',
    this.ageGroup = '31-40',
    this.education = 'S1',
    this.employmentType = 'TETAP',
  });
}
