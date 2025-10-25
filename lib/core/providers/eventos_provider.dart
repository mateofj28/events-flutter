import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eventos_app/core/models/evento.dart';

part 'eventos_provider.g.dart';

@riverpod
class EventosNotifier extends _$EventosNotifier {
  @override
  List<Evento> build() {
    return _eventosEjemplo;
  }

  void agregarEvento(Evento evento) {
    state = [...state, evento];
  }

  void eliminarEvento(String id) {
    state = state.where((evento) => evento.id != id).toList();
  }

  void actualizarEvento(Evento eventoActualizado) {
    state = state.map((evento) {
      return evento.id == eventoActualizado.id ? eventoActualizado : evento;
    }).toList();
  }
}

@riverpod
List<Evento> misEventos(Ref ref) {
  final eventos = ref.watch(eventosNotifierProvider);
  return eventos.where((evento) => evento.esMiEvento).toList();
}

@riverpod
List<Evento> proximosEventos(Ref ref) {
  final eventos = ref.watch(eventosNotifierProvider);
  final ahora = DateTime.now();
  
  return eventos
      .where((evento) => evento.fechaInicio.isAfter(ahora))
      .toList()
    ..sort((a, b) => a.fechaInicio.compareTo(b.fechaInicio));
}

// Datos de ejemplo
final _eventosEjemplo = [
  Evento(
    id: '1',
    titulo: 'Conferencia Flutter 2024',
    descripcion: 'La conferencia más importante de Flutter en Latinoamérica',
    fechaInicio: DateTime.now().add(const Duration(days: 5)),
    fechaFin: DateTime.now().add(const Duration(days: 6)),
    ubicacion: 'Centro de Convenciones, Ciudad de México',
    organizador: 'Flutter Community',
    esMiEvento: true,
  ),
  Evento(
    id: '2',
    titulo: 'Workshop de Dart',
    descripcion: 'Aprende las últimas características de Dart 3.0',
    fechaInicio: DateTime.now().add(const Duration(days: 12)),
    fechaFin: DateTime.now().add(const Duration(days: 12)),
    ubicacion: 'Universidad Tecnológica',
    organizador: 'Dart Team',
    esMiEvento: false,
  ),
  Evento(
    id: '3',
    titulo: 'Meetup de Desarrolladores',
    descripcion: 'Networking y charlas técnicas',
    fechaInicio: DateTime.now().add(const Duration(days: 20)),
    fechaFin: DateTime.now().add(const Duration(days: 20)),
    ubicacion: 'Coworking Space Tech Hub',
    organizador: 'Dev Community',
    esMiEvento: true,
  ),
];
