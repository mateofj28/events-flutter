import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eventos_app/core/providers/auth_provider.dart';
import 'package:eventos_app/presentation/screens/auth/simple_login_screen.dart';
import 'package:eventos_app/presentation/screens/main_screen.dart';
import 'package:eventos_app/presentation/screens/validator/validator_main_screen.dart';
import 'package:eventos_app/core/models/user.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    // Mostrar loading si está cargando
    if (authState.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Si no está autenticado, mostrar login
    if (!authState.isAuthenticated || authState.user == null) {
      return const SimpleLoginScreen();
    }

    // Si está autenticado, navegar según el rol del usuario
    final user = authState.user!;
    switch (user.rol) {
      case UserRole.validator:
        return const ValidatorMainScreen();
      case UserRole.admin:
      case UserRole.user:
        return const MainScreen(
          child: SizedBox(), // Placeholder, se manejará con el router
        );
    }
  }
}
