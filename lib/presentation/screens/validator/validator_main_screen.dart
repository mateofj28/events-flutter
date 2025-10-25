import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:eventos_app/core/theme/app_theme.dart';
import 'package:eventos_app/core/providers/auth_provider.dart';
import 'package:eventos_app/presentation/screens/validator/validator_event_screen.dart';
import 'package:eventos_app/presentation/screens/validator/validator_tickets_screen.dart';
import 'package:eventos_app/presentation/screens/auth/login_screen.dart';

class ValidatorMainScreen extends ConsumerStatefulWidget {
  const ValidatorMainScreen({super.key});

  @override
  ConsumerState<ValidatorMainScreen> createState() => _ValidatorMainScreenState();
}

class _ValidatorMainScreenState extends ConsumerState<ValidatorMainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ValidatorEventScreen(),
    const ValidatorTicketsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: Theme.of(context).colorScheme.surface,
              selectedItemColor: AppTheme.primaryColor,
              unselectedItemColor: AppTheme.textSecondaryColor,
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _currentIndex == 0 
                        ? AppTheme.primaryColor.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _currentIndex == 0 ? Iconsax.calendar_2 : Iconsax.calendar,
                    size: 24,
                  ),
                ),
                label: 'Mi Evento',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _currentIndex == 1 
                        ? AppTheme.primaryColor.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _currentIndex == 1 ? Iconsax.ticket : Iconsax.ticket,
                    size: 24,
                  ),
                ),
                label: 'Tickets',
              ),
            ],
            ),
          ),
        ),
      ),
      drawer: _buildDrawer(user),
    );
  }

  Widget _buildDrawer(user) {
    return Drawer(
      child: Column(
        children: [
          // Header del drawer
          Container(
            height: 200,
            decoration: const BoxDecoration(
              gradient: AppTheme.primaryGradient,
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Iconsax.scan_barcode,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    Text(
                      user?.nombre ?? 'Validator',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    const SizedBox(height: 4),
                    
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Validador',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Opciones del drawer
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildDrawerItem(
                  icon: Iconsax.calendar_2,
                  title: 'Mi Evento',
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _currentIndex = 0;
                    });
                  },
                ),
                
                _buildDrawerItem(
                  icon: Iconsax.ticket,
                  title: 'Lista de Tickets',
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                ),
                
                const Divider(height: 32),
                
                _buildDrawerItem(
                  icon: Iconsax.setting_2,
                  title: 'Configuración',
                  onTap: () {
                    Navigator.pop(context);
                    _showSettings();
                  },
                ),
                
                _buildDrawerItem(
                  icon: Iconsax.info_circle,
                  title: 'Ayuda',
                  onTap: () {
                    Navigator.pop(context);
                    _showHelp();
                  },
                ),
              ],
            ),
          ),
          
          // Botón de cerrar sesión
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.errorColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Iconsax.logout,
                  color: AppTheme.errorColor,
                  size: 20,
                ),
              ),
              title: Text(
                'Cerrar Sesión',
                style: TextStyle(
                  color: AppTheme.errorColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: _logout,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: AppTheme.primaryColor,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  void _showSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Iconsax.setting_2, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text('Configuración próximamente'),
            ),
          ],
        ),
        backgroundColor: AppTheme.primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _showHelp() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Iconsax.info_circle, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text('Centro de ayuda próximamente'),
            ),
          ],
        ),
        backgroundColor: AppTheme.successColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.errorColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Iconsax.logout,
                color: AppTheme.errorColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text('Cerrar Sesión'),
          ],
        ),
        content: const Text(
          '¿Estás seguro de que quieres cerrar sesión?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authProvider.notifier).logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            child: Text(
              'Cerrar Sesión',
              style: TextStyle(color: AppTheme.errorColor),
            ),
          ),
        ],
      ),
    );
  }
}
