class LoginRequestDTO {
  final String username;
  final String password;
  final String macAddress;

  LoginRequestDTO({
    required this.username,
    required this.password,
    this.macAddress = 'MAC',
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'macAddress': macAddress,
      };

  // final String token;
  // final int userId;
  // final String email;

  // LoginRequestDTO ({required this.token, required this.userId, required this.email});

  // factory LoginRequestDTO .fromJson(Map<String, dynamic> json) {
  //   return LoginRequestDTO (
  //     token: json['token'],
  //     userId: json['user']['id'],
  //     email: json['user']['email'],
  //   );
  // }

  // Map<String, dynamic> toJson() => {
  //       'user': userId,
  //       'email': email,
  //       'token': token,
  //     };
}
