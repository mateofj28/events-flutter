import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:go_router/go_router.dart';
import 'package:eventos_app/core/theme/app_theme.dart';
import 'package:eventos_app/core/providers/auth_provider.dart';
import 'package:eventos_app/presentation/widgets/gradient_button.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _documentoController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _tipoDocumento = 'Cédula de Ciudadanía';
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptTerms = false;

  final List<String> _tiposDocumento = [
    'Cédula de Ciudadanía',
    'Pasaporte',
    'Licencia de Conducir',
    'Tarjeta de Identidad',
  ];

  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    _telefonoController.dispose();
    _documentoController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    // Escuchar cambios en el estado de autenticación
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Iconsax.warning_2, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(child: Text(next.error!)),
              ],
            ),
            backgroundColor: AppTheme.errorColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        ref.read(authProvider.notifier).clearError();
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Header con botón de regreso
              _buildHeader(),

              const SizedBox(height: 32),

              // Formulario
              _buildRegisterForm(authState),

              const SizedBox(height: 24),

              // Términos y condiciones
              _buildTermsCheckbox(),

              const SizedBox(height: 24),

              // Botón de registro
              _buildRegisterButton(authState),

              const SizedBox(height: 24),

              // Ya tienes cuenta
              _buildLoginSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => context.go('/login'),
              icon: const Icon(Iconsax.arrow_left),
              style: IconButton.styleFrom(
                backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
                foregroundColor: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: AppTheme.accentGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Iconsax.user_add,
                color: Colors.white,
                size: 32,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'Crear cuenta nueva',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Completa tus datos para comenzar',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
        ),
      ],
    );
  }

  Widget _buildRegisterForm(AuthState authState) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Nombre completo
          TextFormField(
            controller: _nombreController,
            enabled: !authState.isLoading,
            decoration: InputDecoration(
              labelText: 'Nombre Completo',
              prefixIcon: const Icon(Iconsax.user),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppTheme.primaryColor, width: 2),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu nombre';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          // Email
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            enabled: !authState.isLoading,
            decoration: InputDecoration(
              labelText: 'Correo Electrónico',
              prefixIcon: const Icon(Iconsax.sms),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppTheme.primaryColor, width: 2),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu email';
              }
              if (!value.contains('@')) {
                return 'Por favor ingresa un email válido';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          // Teléfono
          TextFormField(
            controller: _telefonoController,
            keyboardType: TextInputType.phone,
            enabled: !authState.isLoading,
            decoration: InputDecoration(
              labelText: 'Número de Teléfono',
              prefixIcon: const Icon(Iconsax.call),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppTheme.primaryColor, width: 2),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu teléfono';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          // Tipo de documento
          DropdownButtonFormField<String>(
            initialValue: _tipoDocumento,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: 'Tipo de Documento',
              prefixIcon: const Icon(Iconsax.card),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppTheme.primaryColor, width: 2),
              ),
            ),
            items: _tiposDocumento.map((String tipo) {
              return DropdownMenuItem<String>(
                value: tipo,
                child: Text(
                  tipo,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            onChanged: authState.isLoading
                ? null
                : (String? newValue) {
                    setState(() {
                      _tipoDocumento = newValue!;
                    });
                  },
          ),

          const SizedBox(height: 16),

          // Número de documento
          TextFormField(
            controller: _documentoController,
            keyboardType: TextInputType.number,
            enabled: !authState.isLoading,
            decoration: InputDecoration(
              labelText: 'Número de Documento',
              prefixIcon: const Icon(Iconsax.card_edit),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppTheme.primaryColor, width: 2),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu número de documento';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          // Contraseña
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            enabled: !authState.isLoading,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              prefixIcon: const Icon(Iconsax.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Iconsax.eye_slash : Iconsax.eye,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppTheme.primaryColor, width: 2),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa una contraseña';
              }
              if (value.length < 6) {
                return 'La contraseña debe tener al menos 6 caracteres';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          // Confirmar contraseña
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            enabled: !authState.isLoading,
            decoration: InputDecoration(
              labelText: 'Confirmar Contraseña',
              prefixIcon: const Icon(Iconsax.lock_1),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword ? Iconsax.eye_slash : Iconsax.eye,
                ),
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppTheme.primaryColor, width: 2),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor confirma tu contraseña';
              }
              if (value != _passwordController.text) {
                return 'Las contraseñas no coinciden';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: _acceptTerms,
          onChanged: (value) {
            setState(() {
              _acceptTerms = value ?? false;
            });
          },
          activeColor: AppTheme.primaryColor,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _acceptTerms = !_acceptTerms;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    const TextSpan(text: 'Acepto los '),
                    TextSpan(
                      text: 'Términos y Condiciones',
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const TextSpan(text: ' y la '),
                    TextSpan(
                      text: 'Política de Privacidad',
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton(AuthState authState) {
    return GradientButton(
      text: 'Crear Cuenta',
      icon: Iconsax.user_add,
      gradient: AppTheme.accentGradient,
      width: double.infinity,
      isLoading: authState.isLoading,
      onPressed: (!_acceptTerms || authState.isLoading) ? null : _register,
    );
  }

  Widget _buildLoginSection() {
    return Center(
      child: Column(
        children: [
          Text(
            '¿Ya tienes una cuenta?',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => context.go('/login'),
            child: Text(
              'Iniciar sesión',
              style: TextStyle(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      final success = await ref.read(authProvider.notifier).register(
            nombre: _nombreController.text.trim(),
            email: _emailController.text.trim(),
            telefono: _telefonoController.text.trim(),
            documento: _documentoController.text.trim(),
            tipoDocumento: _tipoDocumento,
            password: _passwordController.text,
          );

      if (success) {
        // Navegar a verificación OTP
        context.go('/otp-verification', extra: _emailController.text.trim());
      } else {
        // Mostrar error
        final error = ref.read(authProvider).error;
        if (error != null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
