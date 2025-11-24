import 'package:fiteats/src/core/config/app_config.dart';
import 'package:fiteats/src/core/config/router.dart';
import 'package:fiteats/src/core/theme/app_theme.dart';
import 'package:fiteats/src/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Initialize app configuration from .env
  await AppConfig.initialize();

  // Initialize dependency injection
  await configureDependencies();

  runApp(const FitEatsApp());
}

class FitEatsApp extends StatelessWidget {
  const FitEatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,

      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      // Router
      routerConfig: AppRouter.router,
    );
  }
}
