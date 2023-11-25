import 'package:flutter/cupertino.dart';
import 'package:weather_app/screen/home_screen.dart';
import 'package:weather_app/screen/login_screen.dart';
import 'package:weather_app/screen/signup_screen.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return _buildSlideTransition(const LoginScreen());
    case SignUpScreen.routeName:
      return _buildSlideTransition(const SignUpScreen());
    case HomeScreen.routeName:
      return _buildSlideTransition(const HomeScreen());
    default:
      null;
    // we can throw error if we don't find any RouteName in switch case currently i'm returning HomeScreen
  }
  return null;
}

PageRouteBuilder _buildSlideTransition(Widget child) {
  return PageRouteBuilder(
      transitionDuration: const Duration(seconds: 1),
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween =
            Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
                .chain(CurveTween(curve: Curves.ease))
                .animate(animation);
        return SlideTransition(
          position: tween,
          child: child,
        );
      });
}
