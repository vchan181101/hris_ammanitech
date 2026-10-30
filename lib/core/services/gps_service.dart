class GpsService {
  static const double officeLat = -6.2235;
  static const double officeLng = 106.8315; // Cyber 2 Tower Kuningan

  static Future<bool> isWithinGeofenceZone(double currentLat, double currentLng, {double maxDistanceMeters = 50}) async {
    // Simulated GPS distance check
    return true;
  }

  static String getCurrentLocationName() {
    return 'Cyber 2 Tower, Kuningan - Jakarta (Head Office)';
  }
}
