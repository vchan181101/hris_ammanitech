import 'package:flutter/material.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../../screens/karyawan_staff/ess_home_tab.dart';

class EmployeeDashboardScreen extends StatelessWidget {
  final UserModel user;

  const EmployeeDashboardScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return EssHomeTab(user: user);
  }
}
