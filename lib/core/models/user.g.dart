// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      email: json['email'] as String,
      telefono: json['telefono'] as String,
      documento: json['documento'] as String,
      tipoDocumento: json['tipoDocumento'] as String,
      rol: $enumDecode(_$UserRoleEnumMap, json['rol']),
      eventoAsignado: json['eventoAsignado'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      lastLogin: json['lastLogin'] == null
          ? null
          : DateTime.parse(json['lastLogin'] as String),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'email': instance.email,
      'telefono': instance.telefono,
      'documento': instance.documento,
      'tipoDocumento': instance.tipoDocumento,
      'rol': _$UserRoleEnumMap[instance.rol]!,
      'eventoAsignado': instance.eventoAsignado,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastLogin': instance.lastLogin?.toIso8601String(),
    };

const _$UserRoleEnumMap = {
  UserRole.admin: 'admin',
  UserRole.validator: 'validator',
  UserRole.user: 'user',
};
