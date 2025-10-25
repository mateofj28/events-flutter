import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eventos_app/core/models/ticket.dart';

class TicketsNotifier extends StateNotifier<List<Ticket>> {
  TicketsNotifier() : super(_generateSampleTickets());

  // Generar tickets de ejemplo
  static List<Ticket> _generateSampleTickets() {
    final tickets = <Ticket>[];
    final now = DateTime.now();
    
    for (int i = 1; i <= 150; i++) {
      tickets.add(
        Ticket(
          id: 'ticket-$i',
          numero: 'BOL-${i.toString().padLeft(3, '0')}-2024',
          eventoId: 'evento-1',
          usuarioId: 'user-${(i % 10) + 1}',
          isActive: i % 7 != 0, // Algunos tickets inactivos
          createdAt: now.subtract(Duration(days: i % 30)),
          isValidated: i % 5 == 0, // Algunos ya validados
          validatedAt: i % 5 == 0 ? now.subtract(Duration(hours: i % 24)) : null,
          validatedBy: i % 5 == 0 ? 'validator-1' : null,
          ubicacion: 'Platea ${String.fromCharCode(65 + (i % 3))}',
          seccion: 'Sección ${(i % 5) + 1}',
          fila: 'Fila ${(i % 10) + 1}',
          asiento: 'Asiento ${(i % 20) + 1}',
          precio: 25000 + (i % 3) * 10000,
        ),
      );
    }
    
    return tickets;
  }

  // Filtrar tickets por búsqueda
  List<Ticket> searchTickets(String query) {
    if (query.isEmpty) return state;
    
    return state.where((ticket) {
      return ticket.numero.toLowerCase().contains(query.toLowerCase()) ||
             ticket.id.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  // Obtener tickets paginados
  List<Ticket> getPaginatedTickets(int page, int pageSize, {String? searchQuery}) {
    List<Ticket> filteredTickets = searchQuery != null && searchQuery.isNotEmpty
        ? searchTickets(searchQuery)
        : state;
    
    final startIndex = page * pageSize;
    final endIndex = (startIndex + pageSize).clamp(0, filteredTickets.length);
    
    if (startIndex >= filteredTickets.length) return [];
    
    return filteredTickets.sublist(startIndex, endIndex);
  }

  // Validar un ticket
  void validateTicket(String ticketId, String validatorId) {
    state = state.map((ticket) {
      if (ticket.id == ticketId) {
        return ticket.copyWith(
          isValidated: true,
          validatedAt: DateTime.now(),
          validatedBy: validatorId,
        );
      }
      return ticket;
    }).toList();
  }

  // Activar/desactivar ticket
  void toggleTicketStatus(String ticketId) {
    state = state.map((ticket) {
      if (ticket.id == ticketId) {
        return ticket.copyWith(isActive: !ticket.isActive);
      }
      return ticket;
    }).toList();
  }

  // Obtener estadísticas
  Map<String, int> getTicketStats() {
    final total = state.length;
    final active = state.where((t) => t.isActive).length;
    final validated = state.where((t) => t.isValidated).length;
    final inactive = total - active;
    
    return {
      'total': total,
      'active': active,
      'inactive': inactive,
      'validated': validated,
      'pending': active - validated,
    };
  }
}

// Provider principal de tickets
final ticketsProvider = StateNotifierProvider<TicketsNotifier, List<Ticket>>((ref) {
  return TicketsNotifier();
});

// Provider para estadísticas de tickets
final ticketStatsProvider = Provider<Map<String, int>>((ref) {
  final notifier = ref.read(ticketsProvider.notifier);
  return notifier.getTicketStats();
});

// Provider para búsqueda de tickets
final ticketSearchProvider = StateProvider<String>((ref) => '');

// Provider para tickets filtrados
final filteredTicketsProvider = Provider<List<Ticket>>((ref) {
  final tickets = ref.watch(ticketsProvider);
  final searchQuery = ref.watch(ticketSearchProvider);
  
  if (searchQuery.isEmpty) return tickets;
  
  return tickets.where((ticket) {
    return ticket.numero.toLowerCase().contains(searchQuery.toLowerCase()) ||
           ticket.id.toLowerCase().contains(searchQuery.toLowerCase());
  }).toList();
});
