import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_strings.dart';
import 'core/routes/app_routes.dart';
import 'main_screen.dart';

/// Uygulama kök widget'ı.
/// Tema, rota ve provider konfigürasyonu burada yapılır.
class NanYiyorumApp extends StatelessWidget {
  const NanYiyorumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.generateRoute,
      routes: {
        '/main': (context) => const MainScreen(),
      },
    );
  }
}
