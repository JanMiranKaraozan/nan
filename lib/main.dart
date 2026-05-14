import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'features/home/providers/home_provider.dart';
import 'features/cart/providers/cart_provider.dart';
import 'features/favorites/providers/favorites_provider.dart';
import 'features/orders/providers/order_provider.dart';
import 'features/profile/providers/profile_provider.dart';

/// Uygulama giriş noktası.
/// Tüm Provider'lar burada tanımlanır ve uygulama ağacına enjekte edilir.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        // Ana sayfa state yönetimi
        ChangeNotifierProvider(create: (_) => HomeProvider()),

        // Sepet state yönetimi (global)
        ChangeNotifierProvider(create: (_) => CartProvider()),

        // Favoriler state yönetimi
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),

        // Sipariş state yönetimi
        ChangeNotifierProvider(create: (_) => OrderProvider()),

        // Profil state yönetimi
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: const NanYiyorumApp(),
    ),
  );
}
