import 'package:flutter/material.dart';
import 'features/home/views/home_screen.dart';
import 'features/favorites/views/favorites_screen.dart';
import 'features/cart/views/cart_screen.dart';
import 'features/orders/views/order_history_screen.dart';
import 'features/profile/views/profile_screen.dart';
import 'shared/widgets/custom_bottom_nav.dart';

/// Ana ekran — alt navigasyon barı ile 5 tab yönetimi.
/// Her tab bağımsız bir ekranı gösterir.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  /// Aktif tab indeksi
  int _currentIndex = 0;

  /// Tab ekranları (lazy loading için late kullanılmıyor, doğrudan build)
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(onCartTap: () => _onTabChanged(2)),
      const FavoritesScreen(),
      const CartScreen(),
      const OrderHistoryScreen(),
      const ProfileScreen(),
    ];
  }

  /// Tab değiştirme
  void _onTabChanged(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Aktif ekranı göster (IndexedStack ile state korunur)
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      // Alt navigasyon barı
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: _onTabChanged,
      ),
    );
  }
}
