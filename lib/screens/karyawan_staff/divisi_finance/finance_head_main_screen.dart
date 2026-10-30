import 'package:flutter/material.dart';
import '../../../models/user_model.dart';
import '../../../theme/app_colors.dart';
import '../../../features/approval/presentation/screens/approval_center_screen.dart';
import '../ess_profile_tab.dart';
import '../ess_inbox_tab.dart';
import 'finance_head_home_tab.dart';
import 'finance_reimbursement_tab.dart';

class FinanceHeadMainScreen extends StatefulWidget {
  final UserModel user;
  final int initialTab;

  const FinanceHeadMainScreen({
    super.key,
    required this.user,
    this.initialTab = 0,
  });

  @override
  State<FinanceHeadMainScreen> createState() => _FinanceHeadMainScreenState();
}

class _FinanceHeadMainScreenState extends State<FinanceHeadMainScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    // 5 Tab Sesuai Spesifikasi Menu Navigasi Head of Finance
    final List<Widget> tabs = [
      FinanceHeadHomeTab(
        user: widget.user,
        onNavigateTab: (index) {
          setState(() => _currentIndex = index);
        },
      ),
      FinanceReimbursementTab(user: widget.user),
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
          selectedItemColor: const Color(0xFF047857),
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
              icon: Icon(Icons.receipt_long_outlined),
              activeIcon: Icon(Icons.receipt_long_rounded),
              label: 'Claims & Audit',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_turned_in_outlined),
              activeIcon: Icon(Icons.assignment_turned_in_rounded),
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
