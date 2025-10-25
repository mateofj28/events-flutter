import 'package:freezed_annotation/freezed_annotation.dart';

part 'evento.freezed.dart';
part 'evento.g.dart';

@freezed
class Evento with _$Evento {
  const factory Evento({
    required String id,
    required String titulo,
    required String descripcion,
    required DateTime fechaInicio,
    required DateTime fechaFin,
    required String ubicacion,
    required String organizador,
    @Default(false) bool esMiEvento,
    @Default([]) List<String> participantes,
    String? imagenUrl,
  }) = _Evento;

  factory Evento.fromJson(Map<String, dynamic> json) => _$EventoFromJson(json);
}
