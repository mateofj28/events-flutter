class Ticket {
  final String id;
  final String numero;
  final String eventoId;
  final String usuarioId;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? validatedAt;
  final String? validatedBy;
  final bool isValidated;
  final String? ubicacion;
  final String? seccion;
  final String? fila;
  final String? asiento;
  final double? precio;

  const Ticket({
    required this.id,
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
    this.precio,
  });

  Ticket copyWith({
    String? id,
    String? numero,
    String? eventoId,
    String? usuarioId,
    bool? isActive,
    DateTime? createdAt,
    DateTime? validatedAt,
    String? validatedBy,
    bool? isValidated,
    String? ubicacion,
    String? seccion,
    String? fila,
    String? asiento,
    double? precio,
  }) {
    return Ticket(
      id: id ?? this.id,
      numero: numero ?? this.numero,
      eventoId: eventoId ?? this.eventoId,
      usuarioId: usuarioId ?? this.usuarioId,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      validatedAt: validatedAt ?? this.validatedAt,
      validatedBy: validatedBy ?? this.validatedBy,
      isValidated: isValidated ?? this.isValidated,
      ubicacion: ubicacion ?? this.ubicacion,
      seccion: seccion ?? this.seccion,
      fila: fila ?? this.fila,
      asiento: asiento ?? this.asiento,
      precio: precio ?? this.precio,
    );
  }

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      numero: json['numero'],
      eventoId: json['eventoId'],
      usuarioId: json['usuarioId'],
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt']),
      validatedAt: json['validatedAt'] != null ? DateTime.parse(json['validatedAt']) : null,
      validatedBy: json['validatedBy'],
      isValidated: json['isValidated'] ?? false,
      ubicacion: json['ubicacion'],
      seccion: json['seccion'],
      fila: json['fila'],
      asiento: json['asiento'],
      precio: json['precio']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numero': numero,
      'eventoId': eventoId,
      'usuarioId': usuarioId,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'validatedAt': validatedAt?.toIso8601String(),
      'validatedBy': validatedBy,
      'isValidated': isValidated,
      'ubicacion': ubicacion,
      'seccion': seccion,
      'fila': fila,
      'asiento': asiento,
      'precio': precio,
    };
  }
}
