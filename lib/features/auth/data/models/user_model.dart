import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String password;

  const UserModel({
    required super.nik,
    required super.name,
    required super.email,
    required this.password,
    required super.position,
    required super.company,
    required super.department,
    required super.role,
  });
}
