// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Ticket _$TicketFromJson(Map<String, dynamic> json) {
  return _Ticket.fromJson(json);
}

/// @nodoc
mixin _$Ticket {
  String get id => throw _privateConstructorUsedError;
  String get numero => throw _privateConstructorUsedError;
  String get eventoId => throw _privateConstructorUsedError;
  String get usuarioId => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get validatedAt => throw _privateConstructorUsedError;
  String? get validatedBy => throw _privateConstructorUsedError;
  bool get isValidated => throw _privateConstructorUsedError;
  String? get ubicacion => throw _privateConstructorUsedError;
  String? get seccion => throw _privateConstructorUsedError;
  String? get fila => throw _privateConstructorUsedError;
  String? get asiento => throw _privateConstructorUsedError;
  double? get precio => throw _privateConstructorUsedError;

  /// Serializes this Ticket to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TicketCopyWith<Ticket> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketCopyWith<$Res> {
  factory $TicketCopyWith(Ticket value, $Res Function(Ticket) then) =
      _$TicketCopyWithImpl<$Res, Ticket>;
  @useResult
  $Res call(
      {String id,
      String numero,
      String eventoId,
      String usuarioId,
      bool isActive,
      DateTime createdAt,
      DateTime? validatedAt,
      String? validatedBy,
      bool isValidated,
      String? ubicacion,
      String? seccion,
      String? fila,
      String? asiento,
      double? precio});
}

/// @nodoc
class _$TicketCopyWithImpl<$Res, $Val extends Ticket>
    implements $TicketCopyWith<$Res> {
  _$TicketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? numero = null,
    Object? eventoId = null,
    Object? usuarioId = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? validatedAt = freezed,
    Object? validatedBy = freezed,
    Object? isValidated = null,
    Object? ubicacion = freezed,
    Object? seccion = freezed,
    Object? fila = freezed,
    Object? asiento = freezed,
    Object? precio = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      numero: null == numero
          ? _value.numero
          : numero // ignore: cast_nullable_to_non_nullable
              as String,
      eventoId: null == eventoId
          ? _value.eventoId
          : eventoId // ignore: cast_nullable_to_non_nullable
              as String,
      usuarioId: null == usuarioId
          ? _value.usuarioId
          : usuarioId // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      validatedAt: freezed == validatedAt
          ? _value.validatedAt
          : validatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      validatedBy: freezed == validatedBy
          ? _value.validatedBy
          : validatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      isValidated: null == isValidated
          ? _value.isValidated
          : isValidated // ignore: cast_nullable_to_non_nullable
              as bool,
      ubicacion: freezed == ubicacion
          ? _value.ubicacion
          : ubicacion // ignore: cast_nullable_to_non_nullable
              as String?,
      seccion: freezed == seccion
          ? _value.seccion
          : seccion // ignore: cast_nullable_to_non_nullable
              as String?,
      fila: freezed == fila
          ? _value.fila
          : fila // ignore: cast_nullable_to_non_nullable
              as String?,
      asiento: freezed == asiento
          ? _value.asiento
          : asiento // ignore: cast_nullable_to_non_nullable
              as String?,
      precio: freezed == precio
          ? _value.precio
          : precio // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TicketImplCopyWith<$Res> implements $TicketCopyWith<$Res> {
  factory _$$TicketImplCopyWith(
          _$TicketImpl value, $Res Function(_$TicketImpl) then) =
      __$$TicketImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String numero,
      String eventoId,
      String usuarioId,
      bool isActive,
      DateTime createdAt,
      DateTime? validatedAt,
      String? validatedBy,
      bool isValidated,
      String? ubicacion,
      String? seccion,
      String? fila,
      String? asiento,
      double? precio});
}

/// @nodoc
class __$$TicketImplCopyWithImpl<$Res>
    extends _$TicketCopyWithImpl<$Res, _$TicketImpl>
    implements _$$TicketImplCopyWith<$Res> {
  __$$TicketImplCopyWithImpl(
      _$TicketImpl _value, $Res Function(_$TicketImpl) _then)
      : super(_value, _then);

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? numero = null,
    Object? eventoId = null,
    Object? usuarioId = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? validatedAt = freezed,
    Object? validatedBy = freezed,
    Object? isValidated = null,
    Object? ubicacion = freezed,
    Object? seccion = freezed,
    Object? fila = freezed,
    Object? asiento = freezed,
    Object? precio = freezed,
  }) {
    return _then(_$TicketImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      numero: null == numero
          ? _value.numero
          : numero // ignore: cast_nullable_to_non_nullable
              as String,
      eventoId: null == eventoId
          ? _value.eventoId
          : eventoId // ignore: cast_nullable_to_non_nullable
              as String,
      usuarioId: null == usuarioId
          ? _value.usuarioId
          : usuarioId // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      validatedAt: freezed == validatedAt
          ? _value.validatedAt
          : validatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      validatedBy: freezed == validatedBy
          ? _value.validatedBy
          : validatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      isValidated: null == isValidated
          ? _value.isValidated
          : isValidated // ignore: cast_nullable_to_non_nullable
              as bool,
      ubicacion: freezed == ubicacion
          ? _value.ubicacion
          : ubicacion // ignore: cast_nullable_to_non_nullable
              as String?,
      seccion: freezed == seccion
          ? _value.seccion
          : seccion // ignore: cast_nullable_to_non_nullable
              as String?,
      fila: freezed == fila
          ? _value.fila
          : fila // ignore: cast_nullable_to_non_nullable
              as String?,
      asiento: freezed == asiento
          ? _value.asiento
          : asiento // ignore: cast_nullable_to_non_nullable
              as String?,
      precio: freezed == precio
          ? _value.precio
          : precio // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TicketImpl implements _Ticket {
  const _$TicketImpl(
      {required this.id,
      required this.numero,
      required this.eventoId,
      required this.usuarioId,
      required this.isActive,
      required this.createdAt,
      this.validatedAt,
      this.validatedBy,
      this.isValidated = false,
      this.ubicacion,
      this.seccion,
      this.fila,
      this.asiento,
      this.precio});

  factory _$TicketImpl.fromJson(Map<String, dynamic> json) =>
      _$$TicketImplFromJson(json);

  @override
  final String id;
  @override
  final String numero;
  @override
  final String eventoId;
  @override
  final String usuarioId;
  @override
  final bool isActive;
  @override
  final DateTime createdAt;
  @override
  final DateTime? validatedAt;
  @override
  final String? validatedBy;
  @override
  @JsonKey()
  final bool isValidated;
  @override
  final String? ubicacion;
  @override
  final String? seccion;
  @override
  final String? fila;
  @override
  final String? asiento;
  @override
  final double? precio;

  @override
  String toString() {
    return 'Ticket(id: $id, numero: $numero, eventoId: $eventoId, usuarioId: $usuarioId, isActive: $isActive, createdAt: $createdAt, validatedAt: $validatedAt, validatedBy: $validatedBy, isValidated: $isValidated, ubicacion: $ubicacion, seccion: $seccion, fila: $fila, asiento: $asiento, precio: $precio)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.numero, numero) || other.numero == numero) &&
            (identical(other.eventoId, eventoId) ||
                other.eventoId == eventoId) &&
            (identical(other.usuarioId, usuarioId) ||
                other.usuarioId == usuarioId) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.validatedAt, validatedAt) ||
                other.validatedAt == validatedAt) &&
            (identical(other.validatedBy, validatedBy) ||
                other.validatedBy == validatedBy) &&
            (identical(other.isValidated, isValidated) ||
                other.isValidated == isValidated) &&
            (identical(other.ubicacion, ubicacion) ||
                other.ubicacion == ubicacion) &&
            (identical(other.seccion, seccion) || other.seccion == seccion) &&
            (identical(other.fila, fila) || other.fila == fila) &&
            (identical(other.asiento, asiento) || other.asiento == asiento) &&
            (identical(other.precio, precio) || other.precio == precio));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      numero,
      eventoId,
      usuarioId,
      isActive,
      createdAt,
      validatedAt,
      validatedBy,
      isValidated,
      ubicacion,
      seccion,
      fila,
      asiento,
      precio);

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketImplCopyWith<_$TicketImpl> get copyWith =>
      __$$TicketImplCopyWithImpl<_$TicketImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TicketImplToJson(
      this,
    );
  }
}

abstract class _Ticket implements Ticket {
  const factory _Ticket(
      {required final String id,
      required final String numero,
      required final String eventoId,
      required final String usuarioId,
      required final bool isActive,
      required final DateTime createdAt,
      final DateTime? validatedAt,
      final String? validatedBy,
      final bool isValidated,
      final String? ubicacion,
      final String? seccion,
      final String? fila,
      final String? asiento,
      final double? precio}) = _$TicketImpl;

  factory _Ticket.fromJson(Map<String, dynamic> json) = _$TicketImpl.fromJson;

  @override
  String get id;
  @override
  String get numero;
  @override
  String get eventoId;
  @override
  String get usuarioId;
  @override
  bool get isActive;
  @override
  DateTime get createdAt;
  @override
  DateTime? get validatedAt;
  @override
  String? get validatedBy;
  @override
  bool get isValidated;
  @override
  String? get ubicacion;
  @override
  String? get seccion;
  @override
  String? get fila;
  @override
  String? get asiento;
  @override
  double? get precio;

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TicketImplCopyWith<_$TicketImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
