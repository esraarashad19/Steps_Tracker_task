import 'package:flutter/material.dart';

 final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class NavigationService {


  static Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return appNavigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> pushReplacementNamed(String routeName,
      {Object? arguments}) {
    return appNavigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  static void pop() {
    appNavigatorKey.currentState!.pop();
  }
}
