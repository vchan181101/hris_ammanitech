import 'package:flutter/material.dart';
import '../../../models/user_model.dart';
import '../../../theme/app_colors.dart';
import '../ess_profile_tab.dart';
import '../ess_inbox_tab.dart';
import 'hr_home_tab.dart';
import 'hr_verifikasi_cuti_tab.dart';
import 'hr_presensi_monitor_tab.dart';

class HrStaffMainScreen extends StatefulWidget {
  final UserModel user;
  final int initialTab;

  const HrStaffMainScreen({
    super.key,
    required this.user,
    this.initialTab = 0,
  });

  @override
  State<HrStaffMainScreen> createState() => _HrStaffMainScreenState();
}

class _HrStaffMainScreenState extends State<HrStaffMainScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    // 5 Tab Sesuai Spesifikasi Menu Navigasi
    final List<Widget> tabs = [
      HrHomeTab(
        user: widget.user,
        onNavigateTab: (index) {
          setState(() => _currentIndex = index);
        },
      ),
      HrPresensiMonitorTab(user: widget.user),
      HrVerifikasiCutiTab(user: widget.user),
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF7C3AED),
          unselectedItemColor: AppColors.textSecondary,
          selectedLabelStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.my_location_outlined),
              activeIcon: Icon(Icons.my_location_rounded),
              label: 'Attendance',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event_note_outlined),
              activeIcon: Icon(Icons.event_note_rounded),
              label: 'Approvals',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail_outline_rounded),
              activeIcon: Icon(Icons.mail_rounded),
              label: 'Inbox',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
