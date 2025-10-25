// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TicketImpl _$$TicketImplFromJson(Map<String, dynamic> json) => _$TicketImpl(
      id: json['id'] as String,
      numero: json['numero'] as String,
      eventoId: json['eventoId'] as String,
      usuarioId: json['usuarioId'] as String,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      validatedAt: json['validatedAt'] == null
          ? null
          : DateTime.parse(json['validatedAt'] as String),
      validatedBy: json['validatedBy'] as String?,
      isValidated: json['isValidated'] as bool? ?? false,
      ubicacion: json['ubicacion'] as String?,
      seccion: json['seccion'] as String?,
      fila: json['fila'] as String?,
      asiento: json['asiento'] as String?,
      precio: (json['precio'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$TicketImplToJson(_$TicketImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'numero': instance.numero,
      'eventoId': instance.eventoId,
      'usuarioId': instance.usuarioId,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'validatedAt': instance.validatedAt?.toIso8601String(),
      'validatedBy': instance.validatedBy,
      'isValidated': instance.isValidated,
      'ubicacion': instance.ubicacion,
      'seccion': instance.seccion,
      'fila': instance.fila,
      'asiento': instance.asiento,
      'precio': instance.precio,
    };
