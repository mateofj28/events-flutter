import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eventos_app/core/models/user.dart';

// Estado de autenticación
class AuthState {
  final User? user;
  final bool isLoading;
  final String? error;
  final bool isAuthenticated;
  final User? pendingUser; // Usuario pendiente de verificación OTP

  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
    this.isAuthenticated = false,
    this.pendingUser,
  });

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? error,
    bool? isAuthenticated,
    User? pendingUser,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      pendingUser: pendingUser ?? this.pendingUser,
    );
  }
}

// Notifier de autenticación
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  // Datos de ejemplo para demo
  final List<User> _users = [
    User(
      id: '1',
      nombre: 'Admin Demo',
      email: 'admin@eventos.com',
      telefono: '+57 300 123 4567',
      documento: '12345678',
      tipoDocumento: 'Cédula de Ciudadanía',
      rol: UserRole.admin,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    User(
      id: '2',
      nombre: 'Validator Demo',
      email: 'validator@eventos.com',
      telefono: '+57 300 987 6543',
      documento: '87654321',
      tipoDocumento: 'Cédula de Ciudadanía',
      rol: UserRole.validator,
      eventoAsignado: 'evento-1',
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
  ];

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Simular delay de red
      await Future.delayed(const Duration(seconds: 2));
      
      // Buscar usuario por email
      final user = _users.where((u) => u.email == email).firstOrNull;
      
      if (user == null) {
        state = state.copyWith(
          isLoading: false,
          error: 'Usuario no encontrado',
        );
        return false;
      }
      
      // Simular validación de contraseña (en producción usar hash)
      if (password != '123456') {
        state = state.copyWith(
          isLoading: false,
          error: 'Contraseña incorrecta',
        );
        return false;
      }
      
      // Login exitoso
      final updatedUser = user.copyWith(lastLogin: DateTime.now());
      state = state.copyWith(
        user: updatedUser,
        isLoading: false,
        isAuthenticated: true,
        error: null,
      );
      
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error de conexión',
      );
      return false;
    }
  }

  Future<bool> register({
    required String nombre,
    required String email,
    required String telefono,
    required String documento,
    required String tipoDocumento,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Simular delay de red
      await Future.delayed(const Duration(seconds: 2));
      
      // Verificar si el email ya existe
      final existingUser = _users.where((u) => u.email == email).firstOrNull;
      if (existingUser != null) {
        state = state.copyWith(
          isLoading: false,
          error: 'El email ya está registrado',
        );
        return false;
      }
      
      // Crear nuevo usuario (pendiente de verificación)
      final newUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        nombre: nombre,
        email: email,
        telefono: telefono,
        documento: documento,
        tipoDocumento: tipoDocumento,
        rol: UserRole.user, // Por defecto es usuario normal
        createdAt: DateTime.now(),
      );
      
      // No agregar a la lista aún, esperar verificación OTP
      state = state.copyWith(
        pendingUser: newUser,
        isLoading: false,
        error: null,
      );
      
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al crear la cuenta',
      );
      return false;
    }
  }

  Future<bool> verifyOTP(String otp) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Simular delay de red
      await Future.delayed(const Duration(seconds: 1));
      
      // Simular validación de OTP
      if (otp != '123456') {
        state = state.copyWith(
          isLoading: false,
          error: 'Código OTP incorrecto',
        );
        return false;
      }
      
      // OTP válido - completar registro si hay usuario pendiente
      if (state.pendingUser != null) {
        _users.add(state.pendingUser!);
        final authenticatedUser = state.pendingUser!.copyWith(lastLogin: DateTime.now());
        state = state.copyWith(
          user: authenticatedUser,
          isLoading: false,
          isAuthenticated: true,
          error: null,
          pendingUser: null,
        );
      } else {
        // Solo verificación OTP sin registro
        state = state.copyWith(
          isLoading: false,
          error: null,
        );
      }
      
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al verificar el código',
      );
      return false;
    }
  }

  Future<void> sendOTP(String email) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Simular envío de OTP
      await Future.delayed(const Duration(seconds: 1));
      
      state = state.copyWith(
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al enviar el código',
      );
    }
  }

  void logout() {
    state = const AuthState();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Provider de autenticación
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

// Provider para obtener el usuario actual
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authProvider).user;
});

// Provider para verificar si está autenticado
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isAuthenticated;
});
