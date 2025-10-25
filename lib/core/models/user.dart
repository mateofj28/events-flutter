import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String nombre,
    required String email,
    required String telefono,
    required String documento,
    required String tipoDocumento,
    required UserRole rol,
    String? eventoAsignado,
    @Default(true) bool isActive,
    DateTime? createdAt,
    DateTime? lastLogin,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

enum UserRole {
  admin,
  validator,
  user,
}

extension UserRoleExtension on UserRole {
  String get displayName {
    switch (this) {
      case UserRole.admin:
        return 'Administrador';
      case UserRole.validator:
        return 'Validador';
      case UserRole.user:
        return 'Usuario';
    }
  }
}
