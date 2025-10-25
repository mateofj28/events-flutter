import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket.freezed.dart';
part 'ticket.g.dart';

@freezed
class Ticket with _$Ticket {
  const factory Ticket({
    required String id,
    required String numero,
    required String eventoId,
    required String usuarioId,
    required bool isActive,
    required DateTime createdAt,
    DateTime? validatedAt,
    String? validatedBy,
    @Default(false) bool isValidated,
    String? ubicacion,
    String? seccion,
    String? fila,
    String? asiento,
    double? precio,
  }) = _Ticket;

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);
}
