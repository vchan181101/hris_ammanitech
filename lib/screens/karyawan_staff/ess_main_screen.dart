import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../theme/app_colors.dart';
import 'ess_home_tab.dart';
import 'ess_attendance_tab.dart';
import 'pages/pengajuan_page.dart';
import 'ess_inbox_tab.dart';
import 'ess_profile_tab.dart';

class EssMainScreen extends StatefulWidget {
  final UserModel user;
  final int initialTab;

  const EssMainScreen({
    super.key,
    required this.user,
    this.initialTab = 0,
  });

  @override
  State<EssMainScreen> createState() => _EssMainScreenState();
}

class _EssMainScreenState extends State<EssMainScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      EssHomeTab(user: widget.user),
      EssAttendanceTab(user: widget.user),
      PengajuanPage(user: widget.user, isTab: true),
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
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          selectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded, color: AppColors.primary),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              activeIcon: Icon(Icons.calendar_month_rounded, color: AppColors.primary),
              label: 'Presensi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined),
              activeIcon: Icon(Icons.assignment_rounded, color: AppColors.primary),
              label: 'Pengajuan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined),
              activeIcon: Icon(Icons.notifications_rounded, color: AppColors.primary),
              label: 'Notifikasi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded, color: AppColors.primary),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
