import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Paleta de colores moderna y vibrante
  static const Color primaryColor = Color(0xFF6C5CE7);      // Púrpura vibrante
  static const Color secondaryColor = Color(0xFFA29BFE);    // Púrpura claro
  static const Color accentColor = Color(0xFFFF6B6B);       // Coral vibrante
  static const Color successColor = Color(0xFF00B894);      // Verde esmeralda
  static const Color warningColor = Color(0xFFFDCB6E);      // Amarillo dorado
  static const Color errorColor = Color(0xFFE17055);        // Rojo suave
  
  // Colores de fondo - Modo Claro
  static const Color lightBackgroundColor = Color(0xFFF8F9FA);
  static const Color lightSurfaceColor = Colors.white;
  static const Color lightCardColor = Colors.white;
  
  // Colores de fondo - Modo Oscuro
  static const Color darkBackgroundColor = Color(0xFF1A1A1A);
  static const Color darkSurfaceColor = Color(0xFF2D2D2D);
  static const Color darkCardColor = Color(0xFF3A3A3A);
  
  // Colores de texto - Modo Claro
  static const Color lightTextPrimaryColor = Color(0xFF2D3436);
  static const Color lightTextSecondaryColor = Color(0xFF636E72);
  static const Color lightTextLightColor = Color(0xFFB2BEC3);
  
  // Colores de texto - Modo Oscuro
  static const Color darkTextPrimaryColor = Color(0xFFE8E8E8);
  static const Color darkTextSecondaryColor = Color(0xFFB8B8B8);
  static const Color darkTextLightColor = Color(0xFF888888);
  
  // Gradientes
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [accentColor, Color(0xFFFF7675)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Método para crear tema dinámico
  static ThemeData getTheme(bool isDarkMode) {
    final backgroundColor = isDarkMode ? darkBackgroundColor : lightBackgroundColor;
    final surfaceColor = isDarkMode ? darkSurfaceColor : lightSurfaceColor;
    final cardColor = isDarkMode ? darkCardColor : lightCardColor;
    final textPrimary = isDarkMode ? darkTextPrimaryColor : lightTextPrimaryColor;
    final textSecondary = isDarkMode ? darkTextSecondaryColor : lightTextSecondaryColor;
    final textLight = isDarkMode ? darkTextLightColor : lightTextLightColor;
    
    return ThemeData(
      useMaterial3: true,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        error: errorColor,
      ),
      
      // Tipografía moderna
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        displayLarge: GoogleFonts.poppins(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        headlineLarge: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleMedium: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: textPrimary,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: textSecondary,
        ),
        bodySmall: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: textLight,
        ),
      ),
      
      // AppBar
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: textPrimary,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        iconTheme: IconThemeData(
          color: textPrimary,
          size: 24,
        ),
      ),
      
      // Cards
      cardTheme: CardThemeData(
        elevation: isDarkMode ? 4 : 8,
        shadowColor: isDarkMode 
            ? Colors.black.withValues(alpha: 0.3)
            : primaryColor.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: cardColor,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      
      // Botones
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 4,
          shadowColor: primaryColor.withValues(alpha: 0.3),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: backgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      
      // Scaffold
      scaffoldBackgroundColor: backgroundColor,
    );
  }
  
  // Getters para compatibilidad
  static ThemeData get lightTheme => getTheme(false);
  static ThemeData get darkTheme => getTheme(true);
  
  // Getters estáticos para compatibilidad con código existente (modo claro por defecto)
  static Color get backgroundColor => lightBackgroundColor;
  static Color get surfaceColor => lightSurfaceColor;
  static Color get cardColor => lightCardColor;
  static Color get textPrimaryColor => lightTextPrimaryColor;
  static Color get textSecondaryColor => lightTextSecondaryColor;
  static Color get textLightColor => lightTextLightColor;
}
