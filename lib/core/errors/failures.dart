abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Terjadi kesalahan pada server.']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Koneksi internet terputus.']);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'NIK/Email atau kata sandi tidak sesuai.']);
}

class LocationFailure extends Failure {
  const LocationFailure([super.message = 'Di luar area geofencing presensi.']);
}
