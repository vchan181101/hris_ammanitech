import 'package:dio/dio.dart';
import 'jwt_interceptor.dart';
import '../security/secure_storage_service.dart';

class ApiClient {
  late final Dio dio;
  final SecureStorageService storageService = SecureStorageService();

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.ammanitech.com/v1',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // Registrasi Interceptor
    dio.interceptors.add(
      JwtInterceptor(dio: dio, storageService: storageService),
    );
  }

  // Helper methods
  Future<Response<T>> get<T>(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    return await dio.get<T>(endpoint, queryParameters: queryParameters);
  }

  Future<Response<T>> post<T>(String endpoint, {dynamic data}) async {
    return await dio.post<T>(endpoint, data: data);
  }
}
