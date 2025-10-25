import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:eventos_app/presentation/widgets/exotic_bottom_nav.dart';
import 'package:eventos_app/presentation/screens/mis_eventos_screen.dart';
import 'package:eventos_app/presentation/screens/proximos_eventos_screen.dart';
import 'package:eventos_app/presentation/screens/configuraciones_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const MisEventosScreen(),
    const ProximosEventosScreen(),
    const ConfiguracionesScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    
    // Sincronizar con la ruta inicial
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentRoute = GoRouterState.of(context).uri.path;
      _updateIndexFromRoute(currentRoute);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _updateIndexFromRoute(String route) {
    int newIndex = 0;
    if (route.startsWith('/proximos-eventos')) {
      newIndex = 1;
    } else if (route.startsWith('/configuraciones')) {
      newIndex = 2;
    }
    
    if (newIndex != _currentIndex) {
      setState(() {
        _currentIndex = newIndex;
      });
      // Usar jumpToPage para navegación instantánea
      _pageController.jumpToPage(newIndex);
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    
    // Actualizar la ruta sin animación del PageView
    switch (index) {
      case 0:
        context.goNamed('mis-eventos');
        break;
      case 1:
        context.goNamed('proximos-eventos');
        break;
      case 2:
        context.goNamed('configuraciones');
        break;
    }
  }

  void _onBottomNavTapped(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
      
      // Saltar directamente sin animación para evitar ver pantallas intermedias
      _pageController.jumpToPage(index);
      
      // Actualizar la ruta
      switch (index) {
        case 0:
          context.goNamed('mis-eventos');
          break;
        case 1:
          context.goNamed('proximos-eventos');
          break;
        case 2:
          context.goNamed('configuraciones');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _screens,
      ),
      extendBody: true,
      bottomNavigationBar: ExoticBottomNav(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTapped,
      ),
    );
  }


}
