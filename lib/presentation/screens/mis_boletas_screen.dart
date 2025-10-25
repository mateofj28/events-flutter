import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:eventos_app/core/models/evento.dart';
import 'package:eventos_app/core/theme/app_theme.dart';
import 'package:eventos_app/core/providers/theme_provider.dart';

class MisBoletasScreen extends ConsumerStatefulWidget {
  final Evento evento;

  const MisBoletasScreen({
    super.key,
    required this.evento,
  });

  @override
  ConsumerState<MisBoletasScreen> createState() => _MisBoletasScreenState();
}

class _MisBoletasScreenState extends ConsumerState<MisBoletasScreen> {
  Timer? _qrTimer;
  String _currentQrCode = '';
  int _qrTimeRemaining = 60;

  // Datos de ejemplo de boletas
  final List<Map<String, dynamic>> _boletas = [
    {
      'numero': 'BOL-001-2024',
      'boletaNumero': 1,
      'totalBoletas': 100,
      'ubicacion': 'Platea A',
      'seccion': 'Sección 1',
      'fila': 'Fila 5',
      'asiento': 'Asiento 12',
      'precio': 25000,
      'estado': 'Activa',
    },
    {
      'numero': 'BOL-002-2024',
      'boletaNumero': 2,
      'totalBoletas': 100,
      'ubicacion': 'Platea A',
      'seccion': 'Sección 1',
      'fila': 'Fila 5',
      'asiento': 'Asiento 13',
      'precio': 25000,
      'estado': 'Activa',
    },
  ];

  @override
  void initState() {
    super.initState();
    _generateQrCode();
    _startQrTimer();
  }

  @override
  void dispose() {
    _qrTimer?.cancel();
    super.dispose();
  }

  void _generateQrCode() {
    final random = Random();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final eventId = widget.evento.titulo.hashCode.abs();
    final userId = 'USER123'; // En una app real, esto vendría del usuario autenticado
    
    // Generar un código QR más realista con información del evento
    _currentQrCode = 'EVT-$eventId-$userId-$timestamp-${random.nextInt(9999).toString().padLeft(4, '0')}';
  }

  void _startQrTimer() {
    _qrTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _qrTimeRemaining--;
        if (_qrTimeRemaining <= 0) {
          _qrTimeRemaining = 60;
          _generateQrCode();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeProvider);
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar con gradiente
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: _getEventGradient(),
              ),
              child: FlexibleSpaceBar(
                title: Text(
                  'Mis Boletas',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
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
          ),
          
          // Contenido
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Información del evento
                  _buildEventInfo(isDarkMode),
                  
                  const SizedBox(height: 24),
                  
                  // Lista de boletas
                  ..._boletas.asMap().entries.map((entry) {
                    final index = entry.key;
                    final boleta = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: _buildTicketCard(boleta, index, isDarkMode),
                    );
                  }).toList(),
                  
                  const SizedBox(height: 100), // Espacio para bottom nav
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventInfo(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? AppTheme.darkCardColor : Colors.white,
        borderRadius: BorderRadius.circular(16),
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
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: _getEventGradient(),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getEventIcon(),
              color: Colors.white,
              size: 28,
            ),
          ),
          
          const SizedBox(width: 16),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.evento.titulo,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.evento.ubicacion,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${widget.evento.fechaInicio.day}/${widget.evento.fechaInicio.month}/${widget.evento.fechaInicio.year}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketCard(Map<String, dynamic> boleta, int index, bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: isDarkMode 
                ? Colors.black.withValues(alpha: 0.4)
                : Colors.grey.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipPath(
        clipper: TicketClipper(),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDarkMode 
                  ? [AppTheme.darkCardColor, AppTheme.darkSurfaceColor]
                  : [Colors.white, const Color(0xFFFAFAFA)],
            ),
          ),
          child: Column(
            children: [
              // Parte superior de la boleta
              _buildTicketHeader(boleta, isDarkMode),
              
              // Línea punteada
              _buildDottedLine(isDarkMode),
              
              // Parte inferior de la boleta
              _buildTicketBody(boleta, isDarkMode),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketHeader(Map<String, dynamic> boleta, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Número de boleta y progreso
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BOLETA #${boleta['numero']}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Boleta ${boleta['boletaNumero']} de ${boleta['totalBoletas']}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                ],
              ),
              
              // Progreso circular
              SizedBox(
                width: 60,
                height: 60,
                child: Stack(
                  children: [
                    CircularProgressIndicator(
                      value: boleta['boletaNumero'] / boleta['totalBoletas'],
                      strokeWidth: 4,
                      backgroundColor: AppTheme.textSecondaryColor.withValues(alpha: 0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getEventGradient().colors.first,
                      ),
                    ),
                    Center(
                      child: Text(
                        '${((boleta['boletaNumero'] / boleta['totalBoletas']) * 100).round()}%',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // QR Code y datos del usuario
          Row(
            children: [
              // QR Code
              GestureDetector(
                onTap: () => _showFullScreenQR(context),
                child: Container(
                  width: 80,
                  height: 80,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: QrImageView(
                    data: _currentQrCode,
                    version: QrVersions.auto,
                    size: 72,
                    backgroundColor: Colors.white,
                    eyeStyle: const QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: Colors.black,
                    ),
                    dataModuleStyle: const QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: Colors.black,
                    ),
                    errorCorrectionLevel: QrErrorCorrectLevel.M,
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Datos del usuario y timer
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Usuario Demo',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'CC: 12345678901',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _qrTimeRemaining <= 10 
                            ? AppTheme.errorColor.withValues(alpha: 0.1)
                            : AppTheme.successColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Iconsax.timer_1,
                            size: 14,
                            color: _qrTimeRemaining <= 10 
                                ? AppTheme.errorColor
                                : AppTheme.successColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'QR: ${_qrTimeRemaining}s',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _qrTimeRemaining <= 10 
                                  ? AppTheme.errorColor
                                  : AppTheme.successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID: ${_currentQrCode.substring(_currentQrCode.length - 8)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondaryColor,
                        fontFamily: 'monospace',
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

  Widget _buildDottedLine(bool isDarkMode) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomPaint(
        painter: DottedLinePainter(
          color: isDarkMode 
              ? AppTheme.textSecondaryColor.withValues(alpha: 0.3)
              : AppTheme.textSecondaryColor.withValues(alpha: 0.5),
        ),
        size: const Size(double.infinity, 1),
      ),
    );
  }

  Widget _buildTicketBody(Map<String, dynamic> boleta, bool isDarkMode) {
    final fechaFormateada = '${widget.evento.fechaInicio.day}/${widget.evento.fechaInicio.month}/${widget.evento.fechaInicio.year}';
    final horaFormateada = '${widget.evento.fechaInicio.hour.toString().padLeft(2, '0')}:${widget.evento.fechaInicio.minute.toString().padLeft(2, '0')}';
    
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Información del evento
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: _getEventGradient(),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getEventIcon(),
                  color: Colors.white,
                  size: 24,
                ),
              ),
              
              const SizedBox(width: 12),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.evento.titulo,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.evento.ubicacion,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondaryColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$fechaFormateada • $horaFormateada',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Detalles de ubicación
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkMode 
                  ? AppTheme.darkSurfaceColor.withValues(alpha: 0.5)
                  : AppTheme.lightBackgroundColor.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildLocationDetail(
                      'Ubicación',
                      boleta['ubicacion'],
                      Iconsax.location,
                    ),
                    const SizedBox(width: 16),
                    _buildLocationDetail(
                      'Sección',
                      boleta['seccion'],
                      Iconsax.category,
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                Row(
                  children: [
                    _buildLocationDetail(
                      'Fila',
                      boleta['fila'],
                      Iconsax.row_vertical,
                    ),
                    const SizedBox(width: 16),
                    _buildLocationDetail(
                      'Asiento',
                      boleta['asiento'],
                      Iconsax.personalcard,
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Precio y estado
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PRECIO',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondaryColor,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${boleta['precio'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')} COP',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.successColor,
                    ),
                  ),
                ],
              ),
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.successColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Iconsax.tick_circle,
                      size: 16,
                      color: AppTheme.successColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      boleta['estado'],
                      style: TextStyle(
                        color: AppTheme.successColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
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

  Widget _buildLocationDetail(String label, String value, IconData icon) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: AppTheme.textSecondaryColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
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

  void _showFullScreenQR(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Código QR de Acceso',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              
              const SizedBox(height: 20),
              
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: QrImageView(
                  data: _currentQrCode,
                  version: QrVersions.auto,
                  size: 250,
                  backgroundColor: Colors.white,
                  eyeStyle: const QrEyeStyle(
                    eyeShape: QrEyeShape.square,
                    color: Colors.black,
                  ),
                  dataModuleStyle: const QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.square,
                    color: Colors.black,
                  ),
                  errorCorrectionLevel: QrErrorCorrectLevel.H,
                ),
              ),
              
              const SizedBox(height: 16),
              
              Text(
                'Presenta este código en la entrada',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 8),
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _qrTimeRemaining <= 10 
                      ? AppTheme.errorColor.withValues(alpha: 0.1)
                      : AppTheme.successColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Iconsax.timer_1,
                      size: 16,
                      color: _qrTimeRemaining <= 10 
                          ? AppTheme.errorColor
                          : AppTheme.successColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Se renueva en ${_qrTimeRemaining}s',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _qrTimeRemaining <= 10 
                            ? AppTheme.errorColor
                            : AppTheme.successColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cerrar',
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Clipper personalizado para dar forma de boleta
class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const radius = 12.0;
    const notchRadius = 8.0;
    const notchPosition = 0.6; // 60% desde arriba
    
    // Comenzar desde la esquina superior izquierda
    path.moveTo(radius, 0);
    
    // Línea superior
    path.lineTo(size.width - radius, 0);
    path.arcToPoint(
      Offset(size.width, radius),
      radius: const Radius.circular(radius),
    );
    
    // Lado derecho hasta el notch
    final notchY = size.height * notchPosition;
    path.lineTo(size.width, notchY - notchRadius);
    
    // Notch derecho
    path.arcToPoint(
      Offset(size.width, notchY + notchRadius),
      radius: const Radius.circular(notchRadius),
      clockwise: false,
    );
    
    // Continuar lado derecho
    path.lineTo(size.width, size.height - radius);
    path.arcToPoint(
      Offset(size.width - radius, size.height),
      radius: const Radius.circular(radius),
    );
    
    // Línea inferior
    path.lineTo(radius, size.height);
    path.arcToPoint(
      Offset(0, size.height - radius),
      radius: const Radius.circular(radius),
    );
    
    // Lado izquierdo hasta el notch
    path.lineTo(0, notchY + notchRadius);
    
    // Notch izquierdo
    path.arcToPoint(
      Offset(0, notchY - notchRadius),
      radius: const Radius.circular(notchRadius),
      clockwise: false,
    );
    
    // Continuar lado izquierdo
    path.lineTo(0, radius);
    path.arcToPoint(
      Offset(radius, 0),
      radius: const Radius.circular(radius),
    );
    
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Painter para línea punteada
class DottedLinePainter extends CustomPainter {
  final Color color;
  
  DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    const dashWidth = 4.0;
    const dashSpace = 4.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
