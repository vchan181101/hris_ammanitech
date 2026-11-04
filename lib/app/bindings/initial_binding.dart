import '../../core/network/api_client.dart';
import '../../core/network/network_info.dart';
import '../../core/services/gps_service.dart';
import '../../core/services/local_storage_service.dart';
import '../../core/services/notification_service.dart';

/// Class `InitialBinding` bertanggung jawab menginisialisasi modul layanan utama (Core Services),
/// koneksi jaringan, GPS Geofencing, dan penyimpanan lokal saat aplikasi HRIS AMMANI Tech pertama kali booting.
class InitialBinding {
  static final ApiClient _apiClient = ApiClient();
  static final NetworkInfo _networkInfo = NetworkInfoImpl();

  static ApiClient get apiClient => _apiClient;
  static NetworkInfo get networkInfo => _networkInfo;

  /// Inisialisasi awal seluruh layanan async sebelum UI aplikasi ditampilkan
  static Future<void> init() async {
    // 1. Inisialisasi Local Storage
    await LocalStorageService.saveString('app_name', 'HRIS AMMANI Tech Group');
    await LocalStorageService.saveString('app_version', '1.0.0');

    // 2. Inisialisasi Layanan Notifikasi Lokal
    await NotificationService.showNotification(
      title: 'Selamat Datang di HRIS AMMANI Tech Group',
      body: 'Sistem Manajemen SDM & ESS Siap Digunakan.',
    );

    // 3. Pengecekan Awal Layanan GPS & Lokasi Geofence Kantor
    GpsService.getCurrentLocationName();
  }
}
