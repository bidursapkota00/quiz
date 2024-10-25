import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/auth/viewmodel.dart';
import 'features/auth/view_login.dart';
import 'features/auth/view_register.dart';
import 'features/home/view_home.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) {
          return FutureBuilder(
            future:
                Provider.of<AuthViewModel>(context, listen: false).loadToken(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              } else {
                final token =
                    Provider.of<AuthViewModel>(context, listen: false).token;
                if (token != null) {
                  return const HomeView();
                } else {
                  return const LoginView();
                }
              }
            },
          );
        });
      case '/login':
        return MaterialPageRoute(builder: (context) => const LoginView());
      case '/register':
        return MaterialPageRoute(builder: (context) => const RegisterView());
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomeView());
      default:
        return MaterialPageRoute(builder: (context) => const LoginView());
    }
  }
}
