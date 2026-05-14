import 'package:flutter/material.dart';
import '../../features/splash/views/splash_screen.dart';
import '../../features/detail/views/food_detail_screen.dart';
import '../../features/orders/views/order_tracking_screen.dart';

/// Uygulama rota (route) yönetimi.
/// Tüm named route'lar burada tanımlanır.
class AppRoutes {
  AppRoutes._();

  // ── Route İsimleri ───────────────────────────────────────────
  static const String splash = '/';
  static const String main = '/main';
  static const String foodDetail = '/food-detail';
  static const String orderTracking = '/order-tracking';

  /// Route generator — MaterialApp'te onGenerateRoute olarak kullanılır
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _fadeRoute(const SplashScreen(), settings);

      case foodDetail:
        // Yemek ID'si argüman olarak alınır
        final foodId = settings.arguments as String;
        return _slideRoute(FoodDetailScreen(foodId: foodId), settings);

      case orderTracking:
        final orderId = settings.arguments as String;
        return _slideRoute(OrderTrackingScreen(orderId: orderId), settings);

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Sayfa bulunamadı')),
          ),
        );
    }
  }

  /// Fade geçiş efekti — splash için
  static Route<dynamic> _fadeRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  /// Slide geçiş efekti — detay sayfaları için
  static Route<dynamic> _slideRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: Curves.easeOutCubic),
        );
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 350),
    );
  }
}
