class ApiEndpoints {
  static String auth(AuthEndpoint endpoint) {
    const path = '/auth';
    switch (endpoint) {
      case AuthEndpoint.LOGIN:
        return '/login';
      case AuthEndpoint.REGISTER:
        return '/register';
      case AuthEndpoint.REFRESH_TOKEN:
        return '$path/refresh-token';
    }
  }
}

enum AuthEndpoint {
  /// An endpoint for registration requests.
  REGISTER,

  /// An endpoint for login requests.
  LOGIN,

  /// An endpoint for token refresh requests.
  REFRESH_TOKEN,
}
