import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eventos_app/core/theme/app_theme.dart';
import 'package:eventos_app/presentation/widgets/gradient_button.dart';
import 'package:eventos_app/core/providers/auth_provider.dart';
import 'package:eventos_app/core/models/user.dart';

class OTPVerificationScreen extends ConsumerStatefulWidget {
  final String email;

  const OTPVerificationScreen({
    super.key,
    required this.email,
  });

  @override
  ConsumerState<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends ConsumerState<OTPVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  
  Timer? _timer;
  int _remainingTime = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _remainingTime = 60;
    _canResend = false;
    _timer?.cancel();
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              
              // Header
              _buildHeader(),
              
              const SizedBox(height: 40),
              
              // Información
              _buildInfo(),
              
              const SizedBox(height: 40),
              
              // Campos OTP
              _buildOTPFields(),
              
              const SizedBox(height: 32),
              
              // Botón verificar
              _buildVerifyButton(),
              
              const SizedBox(height: 24),
              
              // Reenviar código
              _buildResendSection(),
              
              const SizedBox(height: 32),
              
              // Información de demo
              _buildDemoInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => context.go('/login'),
              icon: const Icon(Iconsax.arrow_left),
              style: IconButton.styleFrom(
                backgroundColor: AppTheme.successColor.withValues(alpha: 0.1),
                foregroundColor: AppTheme.successColor,
              ),
            ),
            const Spacer(),
          ],
        ),
        
        const SizedBox(height: 16),
        
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.successColor, Color(0xFF55A3FF)],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Icon(
            Iconsax.sms,
            color: Colors.white,
            size: 40,
          ),
        ),
        
        const SizedBox(height: 24),
        
        Text(
          'Verificar tu cuenta',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildInfo() {
    return Column(
      children: [
        Text(
          'Hemos enviado un código de verificación de 6 dígitos a:',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppTheme.textSecondaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 8),
        
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            widget.email,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOTPFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 50,
          height: 60,
          child: TextFormField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimaryColor,
              fontSize: 20,
            ),
            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppTheme.textSecondaryColor.withValues(alpha: 0.5),
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppTheme.textSecondaryColor.withValues(alpha: 0.5),
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppTheme.primaryColor,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppTheme.errorColor,
                  width: 1.5,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) {
              if (value.isNotEmpty) {
                if (index < 5) {
                  _focusNodes[index + 1].requestFocus();
                } else {
                  _focusNodes[index].unfocus();
                  _verifyOTP();
                }
              } else if (value.isEmpty && index > 0) {
                _focusNodes[index - 1].requestFocus();
              }
            },
          ),
        );
      }),
    );
  }

  Widget _buildVerifyButton() {
    final otp = _controllers.map((c) => c.text).join();
    final isComplete = otp.length == 6;

    return GradientButton(
      text: 'Verificar Código',
      icon: Iconsax.tick_circle,
      gradient: const LinearGradient(
        colors: [AppTheme.successColor, Color(0xFF55A3FF)],
      ),
      width: double.infinity,
      isLoading: false,
      onPressed: !isComplete ? null : _verifyOTP,
    );
  }

  Widget _buildResendSection() {
    return Column(
      children: [
        if (!_canResend) ...[
          Text(
            'Reenviar código en ${_remainingTime}s',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondaryColor,
            ),
          ),
        ] else ...[
          Text(
            '¿No recibiste el código?',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondaryColor,
            ),
          ),
          
          const SizedBox(height: 8),
          
          TextButton(
            onPressed: _resendOTP,
            child: Text(
              'Reenviar código',
              style: TextStyle(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDemoInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.warningColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.warningColor.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Iconsax.info_circle,
                color: AppTheme.warningColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Código de Demo',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppTheme.warningColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          Text(
            'Para esta demo, usa el código: 123456',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.warningColor,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _verifyOTP() async {
    final otp = _controllers.map((c) => c.text).join();
    
    if (otp.length == 6) {
      final authNotifier = ref.read(authProvider.notifier);
      
      final success = await authNotifier.verifyOTP(otp);
      
      if (success) {
        // OTP verificado correctamente, el usuario ya está autenticado
        final user = ref.read(authProvider).user;
        if (user != null) {
          // Navegar según el rol del usuario
          switch (user.rol) {
            case UserRole.validator:
              context.go('/validator');
              break;
            case UserRole.admin:
            case UserRole.user:
              context.go('/mis-eventos');
              break;
          }
        }
      } else {
        // Mostrar error de OTP incorrecto
        final error = ref.read(authProvider).error;
        if (error != null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
          
          // Limpiar campos OTP
          for (var controller in _controllers) {
            controller.clear();
          }
          _focusNodes[0].requestFocus();
        }
      }
    }
  }

  void _resendOTP() async {
    final authNotifier = ref.read(authProvider.notifier);
    
    await authNotifier.sendOTP(widget.email);
    
    // Limpiar campos
    for (var controller in _controllers) {
      controller.clear();
    }
    
    // Enfocar primer campo
    _focusNodes[0].requestFocus();
    
    // Reiniciar timer
    _startTimer();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Iconsax.tick_circle, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text('Código reenviado exitosamente'),
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
}
