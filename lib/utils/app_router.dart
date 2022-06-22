import 'package:billed/screens/dashboard.dart';
import 'package:billed/screens/login.dart';
import 'package:billed/screens/onboarding.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String home = '/';
  static const String dashboard = '/dashboard';
  static const String login = '/login';

  static Map<String, WidgetBuilder> get routes {
    return {
      home: (context) => const Onboarding(),
      dashboard: (context) => Dashboard(),
      login: (context) => const Login(),
    };
  }
}
