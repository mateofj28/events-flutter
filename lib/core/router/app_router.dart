import 'package:go_router/go_router.dart';
import 'package:eventos_app/presentation/screens/main_screen.dart';
import 'package:eventos_app/presentation/screens/mis_eventos_screen.dart';
import 'package:eventos_app/presentation/screens/proximos_eventos_screen.dart';
import 'package:eventos_app/presentation/screens/configuraciones_screen.dart';
import 'package:eventos_app/presentation/screens/auth/simple_login_screen.dart';
import 'package:eventos_app/presentation/screens/auth/register_screen.dart';
import 'package:eventos_app/presentation/screens/auth/otp_verification_screen.dart';
import 'package:eventos_app/presentation/screens/validator/validator_main_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    // Rutas de autenticación
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const SimpleLoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/otp-verification',
      name: 'otp-verification',
      builder: (context, state) {
        final email = state.extra as String? ?? '';
        return OTPVerificationScreen(email: email);
      },
    ),
    
    // Rutas principales para usuarios normales
    ShellRoute(
      builder: (context, state, child) => MainScreen(child: child),
      routes: [
        GoRoute(
          path: '/mis-eventos',
          name: 'mis-eventos',
          builder: (context, state) => const MisEventosScreen(),
        ),
        GoRoute(
          path: '/proximos-eventos',
          name: 'proximos-eventos',
          builder: (context, state) => const ProximosEventosScreen(),
        ),
        GoRoute(
          path: '/configuraciones',
          name: 'configuraciones',
          builder: (context, state) => const ConfiguracionesScreen(),
        ),
      ],
    ),
    
    // Rutas para validadores
    GoRoute(
      path: '/validator',
      name: 'validator',
      builder: (context, state) => const ValidatorMainScreen(),
    ),
  ],
);
