import 'package:flutter/material.dart';
import '../../features/auth/data/models/user_model.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/pin_verification_screen.dart';
import '../../features/navigation/presentation/screens/main_navigation_screen.dart';
import '../../features/approval/presentation/screens/approval_center_screen.dart';
import '../../screens/direktur/direktur_main_screen.dart';
import '../../screens/chief/chief_main_screen.dart';
import '../../screens/karyawan_staff/ess_main_screen.dart';
import '../../screens/karyawan_staff/divisi_finance/finance_staff_main_screen.dart';
import '../../screens/karyawan_staff/divisi_hr/hr_staff_main_screen.dart';

/// Class `AppRoutes` mendefinisikan seluruh rute bernama (named routes)
/// dan logika pemetaan navigasi (`onGenerateRoute`) terpusat untuk aplikasi HRIS AMMANI Tech.
class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String pinVerification = '/pin-verification';
  static const String mainNavigation = '/main';
  static const String approvalCenter = '/approval-center';
  static const String essMain = '/ess-main';
  static const String financeStaffMain = '/finance-staff-main';
  static const String hrStaffMain = '/hr-staff-main';
  static const String direkturMain = '/direktur-main';
  static const String chiefMain = '/chief-main';

  /// Handler pemetaan rute berdasarkan [RouteSettings]
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );

      case pinVerification:
        final onComplete = settings.arguments as Function(bool)?;
        return MaterialPageRoute(
          builder: (_) => PinVerificationScreen(
            onVerificationComplete: onComplete ?? (_) {},
          ),
          settings: settings,
        );

      case mainNavigation:
        final user = settings.arguments as UserModel?;
        if (user != null) {
          return MaterialPageRoute(
            builder: (_) => MainNavigationScreen(user: user),
            settings: settings,
          );
        }
        return _errorRoute('Arguments UserModel wajib diberikan untuk MainNavigationScreen');

      case approvalCenter:
        final user = settings.arguments as UserModel?;
        if (user != null) {
          return MaterialPageRoute(
            builder: (_) => ApprovalCenterScreen(user: user),
            settings: settings,
          );
        }
        return _errorRoute('Arguments UserModel wajib diberikan untuk ApprovalCenterScreen');

      case essMain:
        final user = settings.arguments as UserModel?;
        if (user != null) {
          return MaterialPageRoute(
            builder: (_) => EssMainScreen(user: user),
            settings: settings,
          );
        }
        return _errorRoute('Arguments UserModel wajib diberikan untuk EssMainScreen');

      case financeStaffMain:
        final user = settings.arguments as UserModel?;
        if (user != null) {
          return MaterialPageRoute(
            builder: (_) => FinanceStaffMainScreen(user: user),
            settings: settings,
          );
        }
        return _errorRoute('Arguments UserModel wajib diberikan untuk FinanceStaffMainScreen');

      case hrStaffMain:
        final user = settings.arguments as UserModel?;
        if (user != null) {
          return MaterialPageRoute(
            builder: (_) => HrStaffMainScreen(user: user),
            settings: settings,
          );
        }
        return _errorRoute('Arguments UserModel wajib diberikan untuk HrStaffMainScreen');

      case direkturMain:
        final user = settings.arguments as UserModel?;
        if (user != null) {
          return MaterialPageRoute(
            builder: (_) => DirekturMainScreen(user: user),
            settings: settings,
          );
        }
        return _errorRoute('Arguments UserModel wajib diberikan untuk DirekturMainScreen');

      case chiefMain:
        final user = settings.arguments as UserModel?;
        if (user != null) {
          return MaterialPageRoute(
            builder: (_) => ChiefMainScreen(user: user),
            settings: settings,
          );
        }
        return _errorRoute('Arguments UserModel wajib diberikan untuk ChiefMainScreen');

      default:
        return _errorRoute('Rute "${settings.name}" tidak ditemukan.');
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Rute Tidak Ditemukan')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
