import 'package:bloknot/navigation/routes.dart';
import 'package:bloknot/pages/login_screen.dart';
import 'package:bloknot/pages/notes_screen.dart';
import 'package:bloknot/pages/splash_screen.dart';
import 'package:bloknot/pages/todo_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.todo:
        return MaterialPageRoute(builder: (_) => const TodoScreen());
      case Routes.notes:
        return MaterialPageRoute(builder: (_) => const NotesScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
