import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:eventos_app/core/models/evento.dart';
import 'package:eventos_app/core/theme/app_theme.dart';
import 'package:eventos_app/core/providers/theme_provider.dart';
import 'package:eventos_app/presentation/widgets/gradient_button.dart';

class DetalleEventoScreen extends ConsumerStatefulWidget {
  final Evento evento;

  const DetalleEventoScreen({
    super.key,
    required this.evento,
  });

  @override
  ConsumerState<DetalleEventoScreen> createState() => _DetalleEventoScreenState();
}

class _DetalleEventoScreenState extends ConsumerState<DetalleEventoScreen> {
  bool _isDescriptionExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeProvider);
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar con imagen del evento
          _buildSliverAppBar(),
          
          // Contenido
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Información básica del evento
                  _buildEventBasicInfo(isDarkMode),
                  
                  const SizedBox(height: 24),
                  
                  // Información de fecha, hora y precio
                  _buildEventDetails(isDarkMode),
                  
                  const SizedBox(height: 24),
                  
                  // Botón para conseguir boletas
                  _buildTicketButton(),
                  
                  const SizedBox(height: 24),
                  
                  // Acordeón de descripción
                  _buildDescriptionAccordion(isDarkMode),
                  
                  const SizedBox(height: 24),
                  
                  // Sección de ubicación con mapa
                  _buildLocationSection(isDarkMode),
                  
                  const SizedBox(height: 100), // Espacio para bottom nav
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 300,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: _getEventGradient(),
        ),
        child: FlexibleSpaceBar(
          background: Stack(
            children: [
              // Patrón de fondo
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              
              // Icono del evento
              Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(
                    _getEventIcon(),
                    size: 64,
                    color: Colors.white,
                  ),
                ),
              ),
              
              // Badge de "Mi Evento" si aplica
              if (widget.evento.esMiEvento)
                Positioned(
                  top: 100,
                  right: 20,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 120),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Iconsax.crown,
                          size: 14,
                          color: AppTheme.accentColor,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            'Mi Evento',
                            style: TextStyle(
                              color: AppTheme.accentColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: const Icon(Iconsax.arrow_left, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Iconsax.heart, color: Colors.white),
            onPressed: _toggleFavorite,
          ),
        ),
      ],
    );
  }

  Widget _buildEventBasicInfo(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDarkMode ? AppTheme.darkCardColor : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDarkMode 
                ? Colors.black.withValues(alpha: 0.3)
                : AppTheme.primaryColor.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.evento.titulo,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 12),
          
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.successColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Iconsax.people,
                      size: 16,
                      color: AppTheme.successColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${widget.evento.participantes.length} asistentes',
                      style: TextStyle(
                        color: AppTheme.successColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Iconsax.user,
                      size: 16,
                      color: AppTheme.accentColor,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        widget.evento.organizador,
                        style: TextStyle(
                          color: AppTheme.accentColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEventDetails(bool isDarkMode) {
    final fechaFormateada = '${widget.evento.fechaInicio.day}/${widget.evento.fechaInicio.month}/${widget.evento.fechaInicio.year}';
    final horaFormateada = '${widget.evento.fechaInicio.hour.toString().padLeft(2, '0')}:${widget.evento.fechaInicio.minute.toString().padLeft(2, '0')}';
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDarkMode ? AppTheme.darkCardColor : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDarkMode 
                ? Colors.black.withValues(alpha: 0.3)
                : AppTheme.accentColor.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDetailRow(
            icon: Iconsax.calendar_1,
            title: 'Fecha',
            value: fechaFormateada,
            gradient: AppTheme.primaryGradient,
          ),
          
          const SizedBox(height: 16),
          
          _buildDetailRow(
            icon: Iconsax.clock,
            title: 'Hora',
            value: horaFormateada,
            gradient: const LinearGradient(
              colors: [AppTheme.warningColor, Color(0xFFFFB347)],
            ),
          ),
          
          const SizedBox(height: 16),
          
          _buildDetailRow(
            icon: Iconsax.location,
            title: 'Lugar',
            value: widget.evento.ubicacion,
            gradient: const LinearGradient(
              colors: [AppTheme.successColor, Color(0xFF55A3FF)],
            ),
          ),
          
          const SizedBox(height: 16),
          
          _buildDetailRow(
            icon: Iconsax.ticket,
            title: 'Preventa',
            value: '\$25.000 COP',
            gradient: AppTheme.accentGradient,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String value,
    required LinearGradient gradient,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        
        const SizedBox(width: 16),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTicketButton() {
    return GradientButton(
      text: 'Conseguir Boletas',
      icon: Iconsax.ticket,
      gradient: _getEventGradient(),
      width: double.infinity,
      height: 60,
      onPressed: _buyTickets,
    );
  }

  Widget _buildDescriptionAccordion(bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? AppTheme.darkCardColor : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDarkMode 
                ? Colors.black.withValues(alpha: 0.3)
                : AppTheme.primaryColor.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          initiallyExpanded: _isDescriptionExpanded,
          onExpansionChanged: (expanded) {
            setState(() {
              _isDescriptionExpanded = expanded;
            });
          },
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Iconsax.document_text,
              color: Colors.white,
              size: 20,
            ),
          ),
          title: Text(
            'Acerca del Evento',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.evento.descripcion,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.6,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Text(
                    'Detalles adicionales:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  _buildDetailItem('• Duración: 3 horas'),
                  _buildDetailItem('• Incluye: Material de trabajo y refrigerio'),
                  _buildDetailItem('• Requisitos: Conocimientos básicos de programación'),
                  _buildDetailItem('• Certificado de participación'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppTheme.textSecondaryColor,
        ),
      ),
    );
  }

  Widget _buildLocationSection(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDarkMode ? AppTheme.darkCardColor : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDarkMode 
                ? Colors.black.withValues(alpha: 0.3)
                : AppTheme.successColor.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.successColor, Color(0xFF55A3FF)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Iconsax.location,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Ubicación del Evento',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          Text(
            widget.evento.ubicacion,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Mapa placeholder
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.successColor, Color(0xFF55A3FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                // Patrón de fondo
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withValues(alpha: 0.1),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Contenido del mapa
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Iconsax.map,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Mapa del Evento',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Toca para ver en Google Maps',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Botones de acción para ubicación
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _openInMaps,
                  icon: const Icon(Iconsax.location, size: 16),
                  label: const Flexible(
                    child: Text(
                      'Ver en Mapa',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: const BorderSide(color: AppTheme.successColor),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _getDirections,
                  icon: const Icon(Iconsax.routing, size: 16),
                  label: const Flexible(
                    child: Text(
                      'Cómo llegar',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: const BorderSide(color: AppTheme.primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  LinearGradient _getEventGradient() {
    // Diferentes gradientes según el tipo de evento
    if (widget.evento.titulo.toLowerCase().contains('flutter') ||
        widget.evento.titulo.toLowerCase().contains('dart')) {
      return const LinearGradient(
        colors: [Color(0xFF0175C2), Color(0xFF13B9FD)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (widget.evento.titulo.toLowerCase().contains('workshop') ||
        widget.evento.titulo.toLowerCase().contains('taller')) {
      return const LinearGradient(
        colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (widget.evento.titulo.toLowerCase().contains('meetup') ||
        widget.evento.titulo.toLowerCase().contains('networking')) {
      return const LinearGradient(
        colors: [Color(0xFF00B894), Color(0xFF55A3FF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }

    return AppTheme.primaryGradient;
  }

  IconData _getEventIcon() {
    // Diferentes iconos según el tipo de evento
    if (widget.evento.titulo.toLowerCase().contains('flutter') ||
        widget.evento.titulo.toLowerCase().contains('dart')) {
      return Iconsax.code;
    } else if (widget.evento.titulo.toLowerCase().contains('workshop') ||
        widget.evento.titulo.toLowerCase().contains('taller')) {
      return Iconsax.teacher;
    } else if (widget.evento.titulo.toLowerCase().contains('meetup') ||
        widget.evento.titulo.toLowerCase().contains('networking')) {
      return Iconsax.people;
    } else if (widget.evento.titulo.toLowerCase().contains('conferencia')) {
      return Iconsax.microphone;
    }

    return Iconsax.calendar_2;
  }

  // Métodos de acción
  void _toggleFavorite() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Iconsax.heart, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text('Evento agregado a favoritos'),
            ),
          ],
        ),
        backgroundColor: AppTheme.accentColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _buyTickets() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Iconsax.ticket, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text('Redirigiendo a la compra de boletas...'),
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
  }

  void _openInMaps() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Iconsax.location, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text('Abriendo en Google Maps...'),
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
  }

  void _getDirections() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Iconsax.routing, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text('Obteniendo direcciones...'),
            ),
          ],
        ),
        backgroundColor: AppTheme.primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
