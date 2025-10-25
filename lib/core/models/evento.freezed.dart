// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'evento.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Evento _$EventoFromJson(Map<String, dynamic> json) {
  return _Evento.fromJson(json);
}

/// @nodoc
mixin _$Evento {
  String get id => throw _privateConstructorUsedError;
  String get titulo => throw _privateConstructorUsedError;
  String get descripcion => throw _privateConstructorUsedError;
  DateTime get fechaInicio => throw _privateConstructorUsedError;
  DateTime get fechaFin => throw _privateConstructorUsedError;
  String get ubicacion => throw _privateConstructorUsedError;
  String get organizador => throw _privateConstructorUsedError;
  bool get esMiEvento => throw _privateConstructorUsedError;
  List<String> get participantes => throw _privateConstructorUsedError;
  String? get imagenUrl => throw _privateConstructorUsedError;

  /// Serializes this Evento to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Evento
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventoCopyWith<Evento> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventoCopyWith<$Res> {
  factory $EventoCopyWith(Evento value, $Res Function(Evento) then) =
      _$EventoCopyWithImpl<$Res, Evento>;
  @useResult
  $Res call(
      {String id,
      String titulo,
      String descripcion,
      DateTime fechaInicio,
      DateTime fechaFin,
      String ubicacion,
      String organizador,
      bool esMiEvento,
      List<String> participantes,
      String? imagenUrl});
}

/// @nodoc
class _$EventoCopyWithImpl<$Res, $Val extends Evento>
    implements $EventoCopyWith<$Res> {
  _$EventoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Evento
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? titulo = null,
    Object? descripcion = null,
    Object? fechaInicio = null,
    Object? fechaFin = null,
    Object? ubicacion = null,
    Object? organizador = null,
    Object? esMiEvento = null,
    Object? participantes = null,
    Object? imagenUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      titulo: null == titulo
          ? _value.titulo
          : titulo // ignore: cast_nullable_to_non_nullable
              as String,
      descripcion: null == descripcion
          ? _value.descripcion
          : descripcion // ignore: cast_nullable_to_non_nullable
              as String,
      fechaInicio: null == fechaInicio
          ? _value.fechaInicio
          : fechaInicio // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fechaFin: null == fechaFin
          ? _value.fechaFin
          : fechaFin // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ubicacion: null == ubicacion
          ? _value.ubicacion
          : ubicacion // ignore: cast_nullable_to_non_nullable
              as String,
      organizador: null == organizador
          ? _value.organizador
          : organizador // ignore: cast_nullable_to_non_nullable
              as String,
      esMiEvento: null == esMiEvento
          ? _value.esMiEvento
          : esMiEvento // ignore: cast_nullable_to_non_nullable
              as bool,
      participantes: null == participantes
          ? _value.participantes
          : participantes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imagenUrl: freezed == imagenUrl
          ? _value.imagenUrl
          : imagenUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventoImplCopyWith<$Res> implements $EventoCopyWith<$Res> {
  factory _$$EventoImplCopyWith(
          _$EventoImpl value, $Res Function(_$EventoImpl) then) =
      __$$EventoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String titulo,
      String descripcion,
      DateTime fechaInicio,
      DateTime fechaFin,
      String ubicacion,
      String organizador,
      bool esMiEvento,
      List<String> participantes,
      String? imagenUrl});
}

/// @nodoc
class __$$EventoImplCopyWithImpl<$Res>
    extends _$EventoCopyWithImpl<$Res, _$EventoImpl>
    implements _$$EventoImplCopyWith<$Res> {
  __$$EventoImplCopyWithImpl(
      _$EventoImpl _value, $Res Function(_$EventoImpl) _then)
      : super(_value, _then);

  /// Create a copy of Evento
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? titulo = null,
    Object? descripcion = null,
    Object? fechaInicio = null,
    Object? fechaFin = null,
    Object? ubicacion = null,
    Object? organizador = null,
    Object? esMiEvento = null,
    Object? participantes = null,
    Object? imagenUrl = freezed,
  }) {
    return _then(_$EventoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      titulo: null == titulo
          ? _value.titulo
          : titulo // ignore: cast_nullable_to_non_nullable
              as String,
      descripcion: null == descripcion
          ? _value.descripcion
          : descripcion // ignore: cast_nullable_to_non_nullable
              as String,
      fechaInicio: null == fechaInicio
          ? _value.fechaInicio
          : fechaInicio // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fechaFin: null == fechaFin
          ? _value.fechaFin
          : fechaFin // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ubicacion: null == ubicacion
          ? _value.ubicacion
          : ubicacion // ignore: cast_nullable_to_non_nullable
              as String,
      organizador: null == organizador
          ? _value.organizador
          : organizador // ignore: cast_nullable_to_non_nullable
              as String,
      esMiEvento: null == esMiEvento
          ? _value.esMiEvento
          : esMiEvento // ignore: cast_nullable_to_non_nullable
              as bool,
      participantes: null == participantes
          ? _value._participantes
          : participantes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imagenUrl: freezed == imagenUrl
          ? _value.imagenUrl
          : imagenUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventoImpl implements _Evento {
  const _$EventoImpl(
      {required this.id,
      required this.titulo,
      required this.descripcion,
      required this.fechaInicio,
      required this.fechaFin,
      required this.ubicacion,
      required this.organizador,
      this.esMiEvento = false,
      final List<String> participantes = const [],
      this.imagenUrl})
      : _participantes = participantes;

  factory _$EventoImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventoImplFromJson(json);

  @override
  final String id;
  @override
  final String titulo;
  @override
  final String descripcion;
  @override
  final DateTime fechaInicio;
  @override
  final DateTime fechaFin;
  @override
  final String ubicacion;
  @override
  final String organizador;
  @override
  @JsonKey()
  final bool esMiEvento;
  final List<String> _participantes;
  @override
  @JsonKey()
  List<String> get participantes {
    if (_participantes is EqualUnmodifiableListView) return _participantes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantes);
  }

  @override
  final String? imagenUrl;

  @override
  String toString() {
    return 'Evento(id: $id, titulo: $titulo, descripcion: $descripcion, fechaInicio: $fechaInicio, fechaFin: $fechaFin, ubicacion: $ubicacion, organizador: $organizador, esMiEvento: $esMiEvento, participantes: $participantes, imagenUrl: $imagenUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.titulo, titulo) || other.titulo == titulo) &&
            (identical(other.descripcion, descripcion) ||
                other.descripcion == descripcion) &&
            (identical(other.fechaInicio, fechaInicio) ||
                other.fechaInicio == fechaInicio) &&
            (identical(other.fechaFin, fechaFin) ||
                other.fechaFin == fechaFin) &&
            (identical(other.ubicacion, ubicacion) ||
                other.ubicacion == ubicacion) &&
            (identical(other.organizador, organizador) ||
                other.organizador == organizador) &&
            (identical(other.esMiEvento, esMiEvento) ||
                other.esMiEvento == esMiEvento) &&
            const DeepCollectionEquality()
                .equals(other._participantes, _participantes) &&
            (identical(other.imagenUrl, imagenUrl) ||
                other.imagenUrl == imagenUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      titulo,
      descripcion,
      fechaInicio,
      fechaFin,
      ubicacion,
      organizador,
      esMiEvento,
      const DeepCollectionEquality().hash(_participantes),
      imagenUrl);

  /// Create a copy of Evento
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventoImplCopyWith<_$EventoImpl> get copyWith =>
      __$$EventoImplCopyWithImpl<_$EventoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventoImplToJson(
      this,
    );
  }
}

abstract class _Evento implements Evento {
  const factory _Evento(
      {required final String id,
      required final String titulo,
      required final String descripcion,
      required final DateTime fechaInicio,
      required final DateTime fechaFin,
      required final String ubicacion,
      required final String organizador,
      final bool esMiEvento,
      final List<String> participantes,
      final String? imagenUrl}) = _$EventoImpl;

  factory _Evento.fromJson(Map<String, dynamic> json) = _$EventoImpl.fromJson;

  @override
  String get id;
  @override
  String get titulo;
  @override
  String get descripcion;
  @override
  DateTime get fechaInicio;
  @override
  DateTime get fechaFin;
  @override
  String get ubicacion;
  @override
  String get organizador;
  @override
  bool get esMiEvento;
  @override
  List<String> get participantes;
  @override
  String? get imagenUrl;

  /// Create a copy of Evento
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventoImplCopyWith<_$EventoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
