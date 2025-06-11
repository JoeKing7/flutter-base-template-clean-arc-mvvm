String? validateEmail(String? value) {
  if (value == null || value.isEmpty) return 'Email requerido';
  final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  return regex.hasMatch(value) ? null : 'Email inválido';
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return 'Contraseña requerida';
  return value.length >= 6 ? null : 'Mínimo 6 caracteres';
}
