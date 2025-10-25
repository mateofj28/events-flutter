import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eventos_app/core/router/app_router.dart';
import 'package:eventos_app/core/theme/app_theme.dart';
import 'package:eventos_app/core/providers/theme_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: EventosApp(),
    ),
  );
}

class EventosApp extends ConsumerWidget {
  const EventosApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);
    
    return MaterialApp.router(
      title: 'Eventos App',
      theme: AppTheme.getTheme(isDarkMode),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
