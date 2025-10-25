import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:eventos_app/core/theme/app_theme.dart';
import 'package:eventos_app/core/providers/theme_provider.dart';
import 'package:eventos_app/presentation/widgets/gradient_button.dart';

class EditarUbicacionScreen extends ConsumerStatefulWidget {
  const EditarUbicacionScreen({super.key});

  @override
  ConsumerState<EditarUbicacionScreen> createState() => _EditarUbicacionScreenState();
}

class _EditarUbicacionScreenState extends ConsumerState<EditarUbicacionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _direccionController = TextEditingController(text: 'Av. Reforma 123, Col. Centro');
  final _ciudadController = TextEditingController(text: 'Ciudad de México');
  final _codigoPostalController = TextEditingController(text: '06000');
  
  String _pais = 'México';
  String _estado = 'Ciudad de México';
  
  final List<String> _paises = [
    'México',
    'Estados Unidos',
    'Canadá',
    'España',
    'Argentina',
    'Colombia',
    'Chile',
    'Perú',
  ];
  
  final Map<String, List<String>> _estadosPorPais = {
    'México': [
      'Ciudad de México',
      'Jalisco',
      'Nuevo León',
      'Estado de México',
      'Puebla',
      'Guanajuato',
      'Veracruz',
      'Yucatán',
    ],
    'Estados Unidos': [
      'California',
      'Texas',
      'Florida',
      'New York',
      'Illinois',
    ],
    'España': [
      'Madrid',
      'Barcelona',
      'Valencia',
      'Sevilla',
      'Bilbao',
    ],
  };

  @override
  void dispose() {
    _direccionController.dispose();
    _ciudadController.dispose();
    _codigoPostalController.dispose();
    super.dispose();
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
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.successColor, Color(0xFF55A3FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: FlexibleSpaceBar(
                title: Text(
                  'Editar Ubicación',
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Mapa placeholder
                    _buildMapSection(isDarkMode),
                    
                    const SizedBox(height: 24),
                    
                    // Información de ubicación
                    _buildLocationInfoSection(isDarkMode),
                    
                    const SizedBox(height: 24),
                    
                    // Dirección detallada
                    _buildAddressSection(isDarkMode),
                    
                    const SizedBox(height: 32),
                    
                    // Botones
                    _buildActionButtons(),
                    
                    const SizedBox(height: 100), // Espacio para bottom nav
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection(bool isDarkMode) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.successColor, Color(0xFF55A3FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.successColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Patrón de fondo
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
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
                    Iconsax.location,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Mapa Interactivo',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Toca para seleccionar ubicación',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          
          // Botón de ubicación actual
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: _getCurrentLocation,
                icon: const Icon(
                  Iconsax.gps,
                  color: Colors.white,
                ),
                tooltip: 'Usar ubicación actual',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInfoSection(bool isDarkMode) {
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
                  Iconsax.global,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'País y Estado',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // País
          _buildDropdownField(
            value: _pais,
            label: 'País',
            icon: Iconsax.flag,
            items: _paises,
            onChanged: (value) {
              setState(() {
                _pais = value!;
                // Resetear estado cuando cambia el país
                if (_estadosPorPais.containsKey(_pais)) {
                  _estado = _estadosPorPais[_pais]!.first;
                }
              });
            },
          ),
          
          const SizedBox(height: 16),
          
          // Estado/Provincia
          _buildDropdownField(
            value: _estado,
            label: 'Estado/Provincia',
            icon: Iconsax.map,
            items: _estadosPorPais[_pais] ?? [_estado],
            onChanged: (value) {
              setState(() {
                _estado = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSection(bool isDarkMode) {
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Iconsax.location_add,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Dirección Detallada',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Dirección
          _buildTextField(
            controller: _direccionController,
            label: 'Dirección Completa',
            icon: Iconsax.location,
            maxLines: 2,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu dirección';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 16),
          
          // Ciudad
          _buildTextField(
            controller: _ciudadController,
            label: 'Ciudad',
            icon: Iconsax.buildings,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu ciudad';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 16),
          
          // Código postal
          _buildTextField(
            controller: _codigoPostalController,
            label: 'Código Postal',
            icon: Iconsax.code,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu código postal';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int? maxLines,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String value,
    required String label,
    required IconData icon,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      onChanged: onChanged,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
        ),
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: const BorderSide(color: AppTheme.primaryColor),
            ),
            child: const Text(
              'Cancelar',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GradientButton(
            text: 'Guardar Ubicación',
            icon: Iconsax.location_tick,
            gradient: const LinearGradient(
              colors: [AppTheme.successColor, Color(0xFF55A3FF)],
            ),
            onPressed: _saveLocation,
          ),
        ),
      ],
    );
  }

  void _getCurrentLocation() {
    // TODO: Implementar obtención de ubicación actual
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Iconsax.gps, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text('Obteniendo ubicación actual...'),
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

  void _saveLocation() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implementar guardado de ubicación
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Iconsax.location_tick, color: Colors.white),
              SizedBox(width: 12),
              Expanded(
                child: Text('Ubicación actualizada exitosamente'),
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
      Navigator.pop(context);
    }
  }
}
