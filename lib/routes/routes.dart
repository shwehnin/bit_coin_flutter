import 'package:bit_coin/routes/route_name.dart';
import 'package:bit_coin/screen/home_screen.dart';
import 'package:bit_coin/screen/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return _pageRoute(page: const SplashScreen());
      case RouteNames.home:
        return _pageRoute(page: const HomeScreen());
      default:
        return _pageRoute(page: const SplashScreen());
    }
  }

  static _pageRoute({required Widget page}) {
    return MaterialPageRoute(builder: (context) => SafeArea(child: page));
  }
}
