import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:eventos_app/core/models/evento.dart';
import 'package:eventos_app/core/theme/app_theme.dart';
import 'package:eventos_app/presentation/widgets/gradient_button.dart';

class EventoCard extends StatelessWidget {
  const EventoCard({
    super.key,
    required this.evento,
    this.onTap,
    this.onJoin,
    this.showJoinButton = false,
  });

  final Evento evento;
  final VoidCallback? onTap;
  final VoidCallback? onJoin;
  final bool showJoinButton;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
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
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen del evento
              _buildEventImage(),

              // Contenido del evento
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título y badge
                    _buildHeader(context),

                    const SizedBox(height: 12),

                    // Descripción
                    _buildDescription(context),

                    const SizedBox(height: 16),

                    // Información del evento
                    _buildEventInfo(context),

                    // Botón de unirse (si aplica)
                    if (showJoinButton) ...[
                      const SizedBox(height: 20),
                      _buildJoinButton(),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventImage() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        gradient: _getEventGradient(),
      ),
      child: Stack(
        children: [
          // Patrón de fondo
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
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
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                _getEventIcon(),
                size: 48,
                color: Colors.white,
              ),
            ),
          ),

          // Badge de "Mi Evento" si aplica
          if (evento.esMiEvento)
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                    Text(
                      'Mi Evento',
                      style: TextStyle(
                        color: AppTheme.accentColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            evento.titulo,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,

                ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.successColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${evento.participantes.length} asistentes',
            style: TextStyle(
              color: AppTheme.successColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      evento.descripcion,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontSize: 14,
        height: 1.4,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildEventInfo(BuildContext context) {
    final fechaFormateada =
        '${evento.fechaInicio.day}/${evento.fechaInicio.month}/${evento.fechaInicio.year}';
    final horaFormateada =
        '${evento.fechaInicio.hour.toString().padLeft(2, '0')}:${evento.fechaInicio.minute.toString().padLeft(2, '0')}';

    return Column(
      children: [
        _buildInfoRow(
          context,
          icon: Iconsax.calendar_1,
          text: '$fechaFormateada • $horaFormateada',
          color: AppTheme.primaryColor,
        ),
        const SizedBox(height: 8),
        _buildInfoRow(
          context,
          icon: Iconsax.location,
          text: evento.ubicacion,
          color: AppTheme.accentColor,
        ),
        const SizedBox(height: 8),
        _buildInfoRow(
          context,
          icon: Iconsax.user,
          text: 'Organizado por ${evento.organizador}',
          color: AppTheme.successColor,
        ),
      ],
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 16,
            color: color,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildJoinButton() {
    return GradientButton(
      text: 'Unirse al Evento',
      icon: Iconsax.add_circle,
      gradient: AppTheme.accentGradient,
      width: double.infinity,
      onPressed: onJoin,
    );
  }

  LinearGradient _getEventGradient() {
    // Diferentes gradientes según el tipo de evento
    if (evento.titulo.toLowerCase().contains('flutter') ||
        evento.titulo.toLowerCase().contains('dart')) {
      return const LinearGradient(
        colors: [Color(0xFF0175C2), Color(0xFF13B9FD)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (evento.titulo.toLowerCase().contains('workshop') ||
        evento.titulo.toLowerCase().contains('taller')) {
      return const LinearGradient(
        colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (evento.titulo.toLowerCase().contains('meetup') ||
        evento.titulo.toLowerCase().contains('networking')) {
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
    if (evento.titulo.toLowerCase().contains('flutter') ||
        evento.titulo.toLowerCase().contains('dart')) {
      return Iconsax.code;
    } else if (evento.titulo.toLowerCase().contains('workshop') ||
        evento.titulo.toLowerCase().contains('taller')) {
      return Iconsax.teacher;
    } else if (evento.titulo.toLowerCase().contains('meetup') ||
        evento.titulo.toLowerCase().contains('networking')) {
      return Iconsax.people;
    } else if (evento.titulo.toLowerCase().contains('conferencia')) {
      return Iconsax.microphone;
    }

    return Iconsax.calendar_2;
  }
}
