class Validators {
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName wajib diisi.';
    }
    return null;
  }

  static String? validateEmailOrNik(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email atau NIK wajib diisi.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Kata sandi wajib diisi.';
    }
    if (value.length < 6) {
      return 'Kata sandi minimal 6 karakter.';
    }
    return null;
  }
}
