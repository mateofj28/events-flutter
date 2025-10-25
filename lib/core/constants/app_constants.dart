class AppConstants {
  // Información de la aplicación
  static const String appName = 'Eventos App';
  static const String appVersion = '1.0.0';
  
  // Configuración de UI
  static const double defaultPadding = 16.0;
  static const double cardBorderRadius = 16.0;
  static const double buttonBorderRadius = 12.0;
  
  // Configuración de animaciones
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  
  // Configuración de fechas
  static const String dateFormat = 'dd MMM yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'dd MMM yyyy • HH:mm';
  
  // Límites
  static const int maxEventosEnLista = 50;
  static const int maxCaracteresDescripcion = 200;
  
  // Claves de almacenamiento local
  static const String keyConfiguracionNotificaciones = 'notificaciones_config';
  static const String keyPerfilUsuario = 'perfil_usuario';
}
