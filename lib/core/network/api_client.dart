class ApiClient {
  Future<Map<String, dynamic>> get(String endpoint) async {
    // Simulated network GET request response
    return {'status': 200, 'message': 'Success'};
  }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    // Simulated network POST request response
    return {'status': 201, 'message': 'Created'};
  }
}
