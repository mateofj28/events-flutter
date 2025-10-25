class User {
  final String id;
  final String nombre;
  final String email;
  final String telefono;
  final String documento;
  final String tipoDocumento;
  final UserRole rol;
  final String? eventoAsignado;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? lastLogin;

  const User({
    required this.id,
    required this.nombre,
    required this.email,
    required this.telefono,
    required this.documento,
    required this.tipoDocumento,
    required this.rol,
    this.eventoAsignado,
    this.isActive = true,
    this.createdAt,
    this.lastLogin,
  });

  User copyWith({
    String? id,
    String? nombre,
    String? email,
    String? telefono,
    String? documento,
    String? tipoDocumento,
    UserRole? rol,
    String? eventoAsignado,
    bool? isActive,
    DateTime? createdAt,
    DateTime? lastLogin,
  }) {
    return User(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      email: email ?? this.email,
      telefono: telefono ?? this.telefono,
      documento: documento ?? this.documento,
      tipoDocumento: tipoDocumento ?? this.tipoDocumento,
      rol: rol ?? this.rol,
      eventoAsignado: eventoAsignado ?? this.eventoAsignado,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
      telefono: json['telefono'],
      documento: json['documento'],
      tipoDocumento: json['tipoDocumento'],
      rol: UserRole.values.firstWhere((e) => e.name == json['rol']),
      eventoAsignado: json['eventoAsignado'],
      isActive: json['isActive'] ?? true,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      lastLogin: json['lastLogin'] != null ? DateTime.parse(json['lastLogin']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'email': email,
      'telefono': telefono,
      'documento': documento,
      'tipoDocumento': tipoDocumento,
      'rol': rol.name,
      'eventoAsignado': eventoAsignado,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
    };
  }
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
