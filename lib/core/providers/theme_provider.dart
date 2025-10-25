import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Provider para el modo oscuro
final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false) {
    _loadTheme();
  }

  static const String _themeKey = 'isDarkMode';

  // Cargar tema guardado
  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDarkMode = prefs.getBool(_themeKey) ?? false;
      state = isDarkMode;
    } catch (e) {
      // Si hay error, usar tema claro por defecto
      state = false;
    }
  }

  // Cambiar tema
  Future<void> toggleTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      state = !state;
      await prefs.setBool(_themeKey, state);
    } catch (e) {
      // Si hay error al guardar, revertir el cambio
      state = !state;
    }
  }

  // Establecer tema específico
  Future<void> setTheme(bool isDarkMode) async {
    if (state != isDarkMode) {
      try {
        final prefs = await SharedPreferences.getInstance();
        state = isDarkMode;
        await prefs.setBool(_themeKey, isDarkMode);
      } catch (e) {
        // Si hay error al guardar, revertir el cambio
        state = !isDarkMode;
      }
    }
  }
}
