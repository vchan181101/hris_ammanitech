import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../dashboard/presentation/screens/executive_dashboard_screen.dart';
import '../../../dashboard/presentation/screens/manager_dashboard_screen.dart';
import '../../../dashboard/presentation/screens/employee_dashboard_screen.dart';
import 'package:hris_ammanitech/screens/karyawan_staff/divisi_finance/finance_staff_main_screen.dart';
import 'package:hris_ammanitech/screens/karyawan_staff/divisi_finance/finance_head_main_screen.dart';
import 'package:hris_ammanitech/screens/chief/chief_main_screen.dart';
import 'package:hris_ammanitech/screens/direktur/direktur_main_screen.dart';
import 'package:hris_ammanitech/screens/karyawan_staff/divisi_hr/hr_staff_main_screen.dart';
import 'package:hris_ammanitech/screens/karyawan_staff/divisi_hr/hr_head_main_screen.dart';
import 'package:hris_ammanitech/screens/karyawan_staff/ess_attendance_tab.dart';
import 'package:hris_ammanitech/screens/karyawan_staff/ess_inbox_tab.dart';
import 'package:hris_ammanitech/screens/karyawan_staff/ess_profile_tab.dart';
import '../../../approval/presentation/screens/approval_center_screen.dart';
import '../widgets/bottom_nav_bar.dart';

class MainNavigationScreen extends StatefulWidget {
  final UserModel user;

  const MainNavigationScreen({super.key, required this.user});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  Widget _buildRoleDashboard() {
    final role = widget.user.role.toLowerCase();
    final nik = widget.user.nik;

    if (nik == 'AMI-005') {
      return FinanceStaffMainScreen(user: widget.user);
    } else if (nik == 'AMI-004') {
      return FinanceHeadMainScreen(user: widget.user);
    } else if (nik == 'AMI-003') {
      return HrStaffMainScreen(user: widget.user);
    } else if (nik == 'AMI-002') {
      return HrHeadMainScreen(user: widget.user);
    } else if (role.contains('direktur') || role.contains('chief') || role.contains('c-level')) {
      return ExecutiveDashboardScreen(user: widget.user);
    } else if (role.contains('head') || role.contains('manager')) {
      return ManagerDashboardScreen(user: widget.user);
    } else {
      return EmployeeDashboardScreen(user: widget.user);
    }
  }

  @override
  Widget build(BuildContext context) {
    // If division screens handle their own full bottom navbar shell
    if (widget.user.nik == 'AMI-001' || widget.user.role.toLowerCase() == 'direktur utama' || widget.user.position.toLowerCase() == 'direktur utama') {
      return DirekturMainScreen(user: widget.user);
    }
    if (widget.user.nik == 'GMT-001' || widget.user.nik == 'HGT-001' || widget.user.nik == 'AMI-006' || widget.user.position.toLowerCase().contains('chief')) {
      return ChiefMainScreen(user: widget.user);
    }
    if (widget.user.nik == 'AMI-005') {
      return FinanceStaffMainScreen(user: widget.user);
    }
    if (widget.user.nik == 'AMI-004') {
      return FinanceHeadMainScreen(user: widget.user);
    }
    if (widget.user.nik == 'AMI-003') {
      return HrStaffMainScreen(user: widget.user);
    }
    if (widget.user.nik == 'AMI-002') {
      return HrHeadMainScreen(user: widget.user);
    }

    final List<Widget> tabs = [
      _buildRoleDashboard(),
      EssAttendanceTab(user: widget.user),
      ApprovalCenterScreen(user: widget.user),
      EssInboxTab(user: widget.user),
      EssProfileTab(user: widget.user),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: tabs,
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
