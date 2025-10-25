// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:eventos_app/main.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: EventosApp(),
      ),
    );

    // Wait for the app to settle
    await tester.pumpAndSettle();

    // Verify that the app loads with the bottom navigation
    expect(find.text('Próximos'), findsOneWidget);
    expect(find.text('Configuración'), findsOneWidget);
    
    // Verify the app bar title is present
    expect(find.text('Mis Eventos'), findsWidgets);
  });

  testWidgets('Navigation works correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: EventosApp(),
      ),
    );

    // Wait for initial load
    await tester.pumpAndSettle();

    // Tap on "Configuración" tab
    await tester.tap(find.text('Configuración'));
    await tester.pumpAndSettle();

    // Verify navigation worked
    expect(find.text('Configuraciones'), findsOneWidget);
    expect(find.text('Perfil'), findsOneWidget);
  });
}
