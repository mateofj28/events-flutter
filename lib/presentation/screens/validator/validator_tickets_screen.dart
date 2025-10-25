import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:eventos_app/core/theme/app_theme.dart';
import 'package:eventos_app/core/providers/tickets_provider.dart';
import 'package:eventos_app/core/models/ticket.dart';

class ValidatorTicketsScreen extends ConsumerStatefulWidget {
  const ValidatorTicketsScreen({super.key});

  @override
  ConsumerState<ValidatorTicketsScreen> createState() => _ValidatorTicketsScreenState();
}

class _ValidatorTicketsScreenState extends ConsumerState<ValidatorTicketsScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  
  int _currentPage = 0;
  final int _pageSize = 20;
  bool _isLoadingMore = false;
  List<Ticket> _displayedTickets = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialTickets();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreTickets();
    }
  }

  void _loadInitialTickets() {
    final searchQuery = ref.read(ticketSearchProvider);
    final tickets = ref.read(ticketsProvider.notifier)
        .getPaginatedTickets(0, _pageSize, searchQuery: searchQuery);
    
    setState(() {
      _displayedTickets = tickets;
      _currentPage = 0;
    });
  }

  void _loadMoreTickets() {
    if (_isLoadingMore) return;
    
    setState(() {
      _isLoadingMore = true;
    });

    // Simular delay de carga
    Future.delayed(const Duration(milliseconds: 500), () {
      final searchQuery = ref.read(ticketSearchProvider);
      final newTickets = ref.read(ticketsProvider.notifier)
          .getPaginatedTickets(_currentPage + 1, _pageSize, searchQuery: searchQuery);
      
      if (newTickets.isNotEmpty) {
        setState(() {
          _displayedTickets.addAll(newTickets);
          _currentPage++;
          _isLoadingMore = false;
        });
      } else {
        setState(() {
          _isLoadingMore = false;
        });
      }
    });
  }

  void _onSearchChanged(String query) {
    ref.read(ticketSearchProvider.notifier).state = query;
    _loadInitialTickets();
  }

  @override
  Widget build(BuildContext context) {
    final ticketStats = ref.watch(ticketStatsProvider);

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // AppBar con gradiente
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.accentColor, Color(0xFFFF8E53)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: FlexibleSpaceBar(
                title: Text(
                  'Lista de Tickets',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              ),
            ),
          ),
          
          // Contenido
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Estadísticas resumidas
                  _buildStatsHeader(ticketStats),
                  
                  const SizedBox(height: 20),
                  
                  // Buscador
                  _buildSearchBar(),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          
          // Lista de tickets
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index < _displayedTickets.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    child: _buildTicketCard(_displayedTickets[index]),
                  );
                } else if (_isLoadingMore) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
              childCount: _displayedTickets.length + (_isLoadingMore ? 1 : 0),
            ),
          ),
          
          // Espacio para bottom nav
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsHeader(Map<String, int> stats) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.accentColor.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              'Total',
              stats['total'].toString(),
              AppTheme.primaryColor,
              Iconsax.ticket,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppTheme.textSecondaryColor.withValues(alpha: 0.2),
          ),
          Expanded(
            child: _buildStatItem(
              'Activos',
              stats['active'].toString(),
              AppTheme.successColor,
              Iconsax.tick_circle,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppTheme.textSecondaryColor.withValues(alpha: 0.2),
          ),
          Expanded(
            child: _buildStatItem(
              'Validados',
              stats['validated'].toString(),
              AppTheme.accentColor,
              Iconsax.scan_barcode,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppTheme.textSecondaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        decoration: InputDecoration(
          hintText: 'Buscar por número de ticket...',
          prefixIcon: const Icon(Iconsax.search_normal),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Iconsax.close_circle),
                  onPressed: () {
                    _searchController.clear();
                    _onSearchChanged('');
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildTicketCard(Ticket ticket) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showTicketDetails(ticket),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Header del ticket
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ticket.isActive 
                            ? AppTheme.successColor.withValues(alpha: 0.1)
                            : AppTheme.errorColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        ticket.isActive ? Iconsax.tick_circle : Iconsax.close_circle,
                        color: ticket.isActive ? AppTheme.successColor : AppTheme.errorColor,
                        size: 16,
                      ),
                    ),
                    
                    const SizedBox(width: 12),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ticket.numero,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'ID: ${ticket.id}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textSecondaryColor,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Estado de validación
                    if (ticket.isValidated)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.accentColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Iconsax.scan_barcode,
                              size: 12,
                              color: AppTheme.accentColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Validado',
                              style: TextStyle(
                                color: AppTheme.accentColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Información del ticket
                Row(
                  children: [
                    Expanded(
                      child: _buildTicketInfo(
                        'Ubicación',
                        ticket.ubicacion ?? 'N/A',
                        Iconsax.location,
                      ),
                    ),
                    Expanded(
                      child: _buildTicketInfo(
                        'Sección',
                        ticket.seccion ?? 'N/A',
                        Iconsax.category,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 8),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildTicketInfo(
                        'Precio',
                        ticket.precio != null 
                            ? '\$${ticket.precio!.toStringAsFixed(0)}'
                            : 'N/A',
                        Iconsax.money,
                      ),
                    ),
                    Expanded(
                      child: _buildTicketInfo(
                        'Estado',
                        ticket.isActive ? 'Activo' : 'Inactivo',
                        ticket.isActive ? Iconsax.tick_circle : Iconsax.close_circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTicketInfo(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: AppTheme.textSecondaryColor,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondaryColor,
                  fontSize: 10,
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showTicketDetails(Ticket ticket) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.textSecondaryColor.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: AppTheme.accentGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Iconsax.ticket,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Detalles del Ticket',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ticket.numero,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Iconsax.close_circle),
                  ),
                ],
              ),
            ),
            
            // Contenido
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildDetailRow('ID del Ticket', ticket.id),
                    _buildDetailRow('Número', ticket.numero),
                    _buildDetailRow('Estado', ticket.isActive ? 'Activo' : 'Inactivo'),
                    _buildDetailRow('Validado', ticket.isValidated ? 'Sí' : 'No'),
                    if (ticket.validatedAt != null)
                      _buildDetailRow('Fecha de Validación', 
                          '${ticket.validatedAt!.day}/${ticket.validatedAt!.month}/${ticket.validatedAt!.year}'),
                    _buildDetailRow('Ubicación', ticket.ubicacion ?? 'N/A'),
                    _buildDetailRow('Sección', ticket.seccion ?? 'N/A'),
                    _buildDetailRow('Fila', ticket.fila ?? 'N/A'),
                    _buildDetailRow('Asiento', ticket.asiento ?? 'N/A'),
                    if (ticket.precio != null)
                      _buildDetailRow('Precio', '\$${ticket.precio!.toStringAsFixed(0)} COP'),
                    
                    const SizedBox(height: 20),
                    
                    // Botones de acción
                    if (!ticket.isValidated && ticket.isActive) ...[
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => _validateTicket(ticket),
                          icon: const Icon(Iconsax.scan_barcode),
                          label: const Text('Validar Ticket'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.successColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => _toggleTicketStatus(ticket),
                        icon: Icon(ticket.isActive ? Iconsax.close_circle : Iconsax.tick_circle),
                        label: Text(ticket.isActive ? 'Desactivar' : 'Activar'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: ticket.isActive ? AppTheme.errorColor : AppTheme.successColor,
                          side: BorderSide(
                            color: ticket.isActive ? AppTheme.errorColor : AppTheme.successColor,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _validateTicket(Ticket ticket) {
    ref.read(ticketsProvider.notifier).validateTicket(ticket.id, 'validator-1');
    Navigator.pop(context);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Iconsax.tick_circle, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text('Ticket ${ticket.numero} validado exitosamente'),
            ),
          ],
        ),
        backgroundColor: AppTheme.successColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
    
    _loadInitialTickets();
  }

  void _toggleTicketStatus(Ticket ticket) {
    ref.read(ticketsProvider.notifier).toggleTicketStatus(ticket.id);
    Navigator.pop(context);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              ticket.isActive ? Iconsax.close_circle : Iconsax.tick_circle,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Ticket ${ticket.isActive ? 'desactivado' : 'activado'} exitosamente',
              ),
            ),
          ],
        ),
        backgroundColor: ticket.isActive ? AppTheme.errorColor : AppTheme.successColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
    
    _loadInitialTickets();
  }
}
