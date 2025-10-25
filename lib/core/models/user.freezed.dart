// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get nombre => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get telefono => throw _privateConstructorUsedError;
  String get documento => throw _privateConstructorUsedError;
  String get tipoDocumento => throw _privateConstructorUsedError;
  UserRole get rol => throw _privateConstructorUsedError;
  String? get eventoAsignado => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastLogin => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String id,
      String nombre,
      String email,
      String telefono,
      String documento,
      String tipoDocumento,
      UserRole rol,
      String? eventoAsignado,
      bool isActive,
      DateTime? createdAt,
      DateTime? lastLogin});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nombre = null,
    Object? email = null,
    Object? telefono = null,
    Object? documento = null,
    Object? tipoDocumento = null,
    Object? rol = null,
    Object? eventoAsignado = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? lastLogin = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nombre: null == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      telefono: null == telefono
          ? _value.telefono
          : telefono // ignore: cast_nullable_to_non_nullable
              as String,
      documento: null == documento
          ? _value.documento
          : documento // ignore: cast_nullable_to_non_nullable
              as String,
      tipoDocumento: null == tipoDocumento
          ? _value.tipoDocumento
          : tipoDocumento // ignore: cast_nullable_to_non_nullable
              as String,
      rol: null == rol
          ? _value.rol
          : rol // ignore: cast_nullable_to_non_nullable
              as UserRole,
      eventoAsignado: freezed == eventoAsignado
          ? _value.eventoAsignado
          : eventoAsignado // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLogin: freezed == lastLogin
          ? _value.lastLogin
          : lastLogin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String nombre,
      String email,
      String telefono,
      String documento,
      String tipoDocumento,
      UserRole rol,
      String? eventoAsignado,
      bool isActive,
      DateTime? createdAt,
      DateTime? lastLogin});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nombre = null,
    Object? email = null,
    Object? telefono = null,
    Object? documento = null,
    Object? tipoDocumento = null,
    Object? rol = null,
    Object? eventoAsignado = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? lastLogin = freezed,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nombre: null == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      telefono: null == telefono
          ? _value.telefono
          : telefono // ignore: cast_nullable_to_non_nullable
              as String,
      documento: null == documento
          ? _value.documento
          : documento // ignore: cast_nullable_to_non_nullable
              as String,
      tipoDocumento: null == tipoDocumento
          ? _value.tipoDocumento
          : tipoDocumento // ignore: cast_nullable_to_non_nullable
              as String,
      rol: null == rol
          ? _value.rol
          : rol // ignore: cast_nullable_to_non_nullable
              as UserRole,
      eventoAsignado: freezed == eventoAsignado
          ? _value.eventoAsignado
          : eventoAsignado // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLogin: freezed == lastLogin
          ? _value.lastLogin
          : lastLogin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {required this.id,
      required this.nombre,
      required this.email,
      required this.telefono,
      required this.documento,
      required this.tipoDocumento,
      required this.rol,
      this.eventoAsignado,
      this.isActive = true,
      this.createdAt,
      this.lastLogin});

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String id;
  @override
  final String nombre;
  @override
  final String email;
  @override
  final String telefono;
  @override
  final String documento;
  @override
  final String tipoDocumento;
  @override
  final UserRole rol;
  @override
  final String? eventoAsignado;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? lastLogin;

  @override
  String toString() {
    return 'User(id: $id, nombre: $nombre, email: $email, telefono: $telefono, documento: $documento, tipoDocumento: $tipoDocumento, rol: $rol, eventoAsignado: $eventoAsignado, isActive: $isActive, createdAt: $createdAt, lastLogin: $lastLogin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nombre, nombre) || other.nombre == nombre) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.telefono, telefono) ||
                other.telefono == telefono) &&
            (identical(other.documento, documento) ||
                other.documento == documento) &&
            (identical(other.tipoDocumento, tipoDocumento) ||
                other.tipoDocumento == tipoDocumento) &&
            (identical(other.rol, rol) || other.rol == rol) &&
            (identical(other.eventoAsignado, eventoAsignado) ||
                other.eventoAsignado == eventoAsignado) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastLogin, lastLogin) ||
                other.lastLogin == lastLogin));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      nombre,
      email,
      telefono,
      documento,
      tipoDocumento,
      rol,
      eventoAsignado,
      isActive,
      createdAt,
      lastLogin);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {required final String id,
      required final String nombre,
      required final String email,
      required final String telefono,
      required final String documento,
      required final String tipoDocumento,
      required final UserRole rol,
      final String? eventoAsignado,
      final bool isActive,
      final DateTime? createdAt,
      final DateTime? lastLogin}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get id;
  @override
  String get nombre;
  @override
  String get email;
  @override
  String get telefono;
  @override
  String get documento;
  @override
  String get tipoDocumento;
  @override
  UserRole get rol;
  @override
  String? get eventoAsignado;
  @override
  bool get isActive;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get lastLogin;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
