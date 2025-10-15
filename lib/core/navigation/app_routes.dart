import 'package:flutter/material.dart';
import 'package:steps_tracker/features/setting/presentation/setting_screen.dart';
import 'package:steps_tracker/features/setup_profile/presentation/setup_profile_screen.dart';
import 'package:steps_tracker/features/splash/presentation/splash_screen.dart';
import 'package:steps_tracker/navigation_bar.dart';




/// Route names used throughout the app
class AppRoutes {
  static const splash = '/';
  static const setupProfile = '/setup-profile';
  static const navigationBar = '/navigation-bar';
  static const setting = '/setting';
}

/// Generates routes based on name
class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) =>  SplashScreen(),
          settings: settings,
        );

      case AppRoutes.setupProfile:
        return MaterialPageRoute(
          builder: (_) => SetupProfileScreen(),
          settings: settings,
        );

      case AppRoutes.navigationBar:
        return MaterialPageRoute(
          builder: (_) => const NavigationBarScreen(),
          settings: settings,
        );
        case AppRoutes.setting:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 | Page Not Found')),
          ),
        );
    }
  }
}
