class LoginEntity {
  final String token;
  final LoginUserEntity user;

  LoginEntity({
    required this.token,
    required this.user,
  });
}

class LoginUserEntity {
  final int id;
  final String name;
  final String email;
  final String rol;

  LoginUserEntity(
      {required this.id,
      required this.name,
      required this.email,
      required this.rol});
}
