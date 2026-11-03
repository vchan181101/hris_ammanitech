class ApiEndpoints {
  static const String baseUrl = 'https://api.amanitech.co.id/v1';

  // Auth Endpoints
  static const String login = '$baseUrl/auth/login';
  static const String verifyPin = '$baseUrl/auth/verify-pin';
  static const String refreshToken = '$baseUrl/auth/refresh';

  // Attendance Endpoints
  static const String clockIn = '$baseUrl/attendance/clock-in';
  static const String clockOut = '$baseUrl/attendance/clock-out';
  static const String attendanceHistory = '$baseUrl/attendance/history';

  // Leave & Permit Endpoints
  static const String leaveRequests = '$baseUrl/leave/requests';
  static const String approveLeave = '$baseUrl/leave/approve';

  // Reimbursement Endpoints
  static const String reimbursementClaims = '$baseUrl/reimbursement/claims';
  static const String verifyClaim = '$baseUrl/reimbursement/verify';

  // Payroll Endpoints
  static const String payslip = '$baseUrl/payroll/payslip';
  static const String payrollDraft = '$baseUrl/payroll/draft';

  // Tasks & Technical Logs
  static const String technicalLogs = '$baseUrl/tasks/logs';

  // Approval Center
  static const String pendingApprovals = '$baseUrl/approvals/pending';
}
