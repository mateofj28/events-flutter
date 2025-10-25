// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evento.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventoImpl _$$EventoImplFromJson(Map<String, dynamic> json) => _$EventoImpl(
      id: json['id'] as String,
      titulo: json['titulo'] as String,
      descripcion: json['descripcion'] as String,
      fechaInicio: DateTime.parse(json['fechaInicio'] as String),
      fechaFin: DateTime.parse(json['fechaFin'] as String),
      ubicacion: json['ubicacion'] as String,
      organizador: json['organizador'] as String,
      esMiEvento: json['esMiEvento'] as bool? ?? false,
      participantes: (json['participantes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      imagenUrl: json['imagenUrl'] as String?,
    );

Map<String, dynamic> _$$EventoImplToJson(_$EventoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titulo': instance.titulo,
      'descripcion': instance.descripcion,
      'fechaInicio': instance.fechaInicio.toIso8601String(),
      'fechaFin': instance.fechaFin.toIso8601String(),
      'ubicacion': instance.ubicacion,
      'organizador': instance.organizador,
      'esMiEvento': instance.esMiEvento,
      'participantes': instance.participantes,
      'imagenUrl': instance.imagenUrl,
    };
