import 'package:go_router/go_router.dart';
import 'package:eventos_app/presentation/screens/main_screen.dart';
import 'package:eventos_app/presentation/screens/mis_eventos_screen.dart';
import 'package:eventos_app/presentation/screens/proximos_eventos_screen.dart';
import 'package:eventos_app/presentation/screens/configuraciones_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/mis-eventos',
  routes: [
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
  ],
);
