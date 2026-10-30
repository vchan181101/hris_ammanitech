import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../theme/app_colors.dart';
import 'enterprise_solution/chief_enterprise_home_tab.dart';
import 'enterprise_solution/chief_enterprise_projects_tab.dart';
import 'digital_commerce/chief_commerce_home_tab.dart';
import 'digital_commerce/chief_commerce_projects_tab.dart';
import 'railways_transportation/chief_railways_home_tab.dart';
import 'railways_transportation/chief_railways_projects_tab.dart';
import 'tabs/chief_executive_approvals_tab.dart';
import 'tabs/chief_inbox_tab.dart';
import 'tabs/chief_profile_tab.dart';

class ChiefMainScreen extends StatefulWidget {
  final UserModel user;
  final int initialTab;

  const ChiefMainScreen({
    super.key,
    required this.user,
    this.initialTab = 0,
  });

  @override
  State<ChiefMainScreen> createState() => _ChiefMainScreenState();
}

class _ChiefMainScreenState extends State<ChiefMainScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTab;
  }

  void _onNavigateTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildHomeTab() {
    final nik = widget.user.nik;
    if (nik == 'GMT-001') {
      return ChiefEnterpriseHomeTab(user: widget.user, onNavigateTab: _onNavigateTab);
    } else if (nik == 'HGT-001') {
      return ChiefCommerceHomeTab(user: widget.user, onNavigateTab: _onNavigateTab);
    } else if (nik == 'AMI-006') {
      return ChiefRailwaysHomeTab(user: widget.user, onNavigateTab: _onNavigateTab);
    } else {
      // Fallback berdasarkan role / posisi
      final pos = widget.user.position.toLowerCase();
      if (pos.contains('digital commerce') || pos.contains('hanasta')) {
        return ChiefCommerceHomeTab(user: widget.user, onNavigateTab: _onNavigateTab);
      } else if (pos.contains('railway') || pos.contains('transport')) {
        return ChiefRailwaysHomeTab(user: widget.user, onNavigateTab: _onNavigateTab);
      }
      return ChiefEnterpriseHomeTab(user: widget.user, onNavigateTab: _onNavigateTab);
    }
  }

  Widget _buildProjectsTab() {
    final nik = widget.user.nik;
    if (nik == 'GMT-001') {
      return ChiefEnterpriseProjectsTab(user: widget.user);
    } else if (nik == 'HGT-001') {
      return ChiefCommerceProjectsTab(user: widget.user);
    } else if (nik == 'AMI-006') {
      return ChiefRailwaysProjectsTab(user: widget.user);
    } else {
      final pos = widget.user.position.toLowerCase();
      if (pos.contains('digital commerce') || pos.contains('hanasta')) {
        return ChiefCommerceProjectsTab(user: widget.user);
      } else if (pos.contains('railway') || pos.contains('transport')) {
        return ChiefRailwaysProjectsTab(user: widget.user);
      }
      return ChiefEnterpriseProjectsTab(user: widget.user);
    }
  }

  Color _getSelectedColor() {
    final nik = widget.user.nik;
    if (nik == 'HGT-001') {
      return const Color(0xFF6B21A8);
    } else if (nik == 'AMI-006') {
      return const Color(0xFF0284C7);
    }
    return AppColors.primary;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      _buildHomeTab(),
      _buildProjectsTab(),
      ChiefExecutiveApprovalsTab(user: widget.user),
      ChiefInboxTab(user: widget.user),
      ChiefProfileTab(user: widget.user),
    ];

    final Color activeColor = _getSelectedColor();

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
          selectedItemColor: activeColor,
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
              activeIcon: Icon(Icons.dashboard_rounded),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined),
              activeIcon: Icon(Icons.assignment_rounded),
              label: 'Projects',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined),
              activeIcon: Icon(Icons.fact_check_rounded),
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
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
