# Eventos App 🎉

Una aplicación moderna de Flutter para la gestión de eventos, construida con las mejores prácticas y tecnologías actuales.

## 🚀 Características

- **Gestión de Eventos**: Visualiza y administra tus eventos personales
- **Próximos Eventos**: Descubre eventos futuros y únete a ellos
- **Configuraciones**: Personaliza tu experiencia y preferencias
- **Diseño Moderno**: UI/UX siguiendo Material Design 3
- **Arquitectura Limpia**: Código mantenible y escalable

## 🛠️ Tecnologías Utilizadas

- **Flutter 3.x**: Framework de desarrollo multiplataforma
- **Riverpod**: Gestión de estado reactiva y robusta
- **Go Router**: Navegación declarativa
- **Freezed**: Generación de modelos inmutables
- **Google Fonts**: Tipografías modernas
- **Material Design 3**: Sistema de diseño de Google

## 📱 Pantallas

1. **Mis Eventos**: Lista de eventos donde eres participante u organizador
2. **Próximos Eventos**: Eventos futuros disponibles para unirse
3. **Configuraciones**: Perfil, notificaciones y preferencias

## 🏗️ Arquitectura

```
lib/
├── core/
│   ├── models/          # Modelos de datos (Freezed)
│   ├── providers/       # Providers de Riverpod
│   ├── router/          # Configuración de rutas
│   └── theme/           # Tema de la aplicación
└── presentation/
    ├── screens/         # Pantallas principales
    └── widgets/         # Widgets reutilizables
```

## 🚀 Instalación y Configuración

1. **Clona el repositorio**:
   ```bash
   git clone <tu-repositorio>
   cd eventos_app
   ```

2. **Instala las dependencias**:
   ```bash
   flutter pub get
   ```

3. **Genera el código necesario**:
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Ejecuta la aplicación**:
   ```bash
   flutter run
   ```

## 📦 Dependencias Principales

- `flutter_riverpod`: Gestión de estado
- `riverpod_annotation`: Anotaciones para generación de código
- `go_router`: Navegación
- `freezed`: Generación de modelos
- `google_fonts`: Fuentes personalizadas
- `intl`: Internacionalización y formateo

## 🔧 Comandos Útiles

- **Generar código**: `flutter packages pub run build_runner build`
- **Generar código en modo watch**: `flutter packages pub run build_runner watch`
- **Limpiar y regenerar**: `flutter packages pub run build_runner build --delete-conflicting-outputs`

## 🎨 Personalización

### Colores del Tema
Los colores principales se pueden modificar en `lib/core/theme/app_theme.dart`:

```dart
static const Color primaryColor = Color(0xFF6366F1);
static const Color secondaryColor = Color(0xFF8B5CF6);
```

### Agregar Nuevos Eventos
Los eventos de ejemplo están en `lib/core/providers/eventos_provider.dart`. Puedes modificar o agregar nuevos eventos allí.

## 🚧 Próximas Características

- [ ] Autenticación de usuarios
- [ ] Integración con APIs externas
- [ ] Notificaciones push
- [ ] Modo offline
- [ ] Compartir eventos
- [ ] Filtros y búsqueda avanzada
- [ ] Calendario integrado
- [ ] Mapas y ubicaciones

## 🤝 Contribución

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para más detalles.

## 👨‍💻 Autor

Creado con ❤️ usando Flutter y las mejores prácticas de desarrollo móvil.