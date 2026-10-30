class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Terjadi kesalahan pada server.']);
}

class CacheException implements Exception {
  final String message;
  CacheException([this.message = 'Gagal mengakses penyimpanan lokal.']);
}

class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = 'Koneksi internet terputus.']);
}

class LocationException implements Exception {
  final String message;
  LocationException([this.message = 'Gagal mengambil koordinat GPS.']);
}
