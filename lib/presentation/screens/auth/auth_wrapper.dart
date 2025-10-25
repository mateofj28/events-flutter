import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eventos_app/core/providers/auth_provider.dart';
import 'package:eventos_app/presentation/screens/auth/login_screen.dart';
import 'package:eventos_app/presentation/screens/main_screen.dart';
import 'package:eventos_app/presentation/screens/validator/validator_main_screen.dart';
import 'package:eventos_app/core/models/user.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final authState = ref.watch(authProvider);

        if (authState.isAuthenticated && authState.user != null) {
          // Navegar según el rol del usuario
          if (authState.user!.rol == UserRole.validator) {
            return const ValidatorMainScreen();
          } else {
            return const MainScreen();
          }
        }

        return const LoginScreen();
      },
    );
  }
}
