class ApiConstants {
  static const String baseUrl =
      'https://api.live.com'; // ? Update with your live API URL
  // static const String baseUrl = 'https://api.dev.com'; // ? Update with your development API URL
  // static const String apiVersion = '/v1';

  // Headers
  static const String contentType = 'Content-Type';
  static const String authorization = 'Authorization';
  static const String acceptLanguage = 'Accept-Language';

  // Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh';
  static const String logout = '/auth/logout';
  static const String profile = '/user/profile';
}
