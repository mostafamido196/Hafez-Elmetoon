import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hafez_elmetoon/SecondScreen.dart';

import 'main.dart';

class RouteNames {
  static const String home = '/home';
  static const String second = '/details';
}

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case RouteNames.second:
        final args = settings.arguments as SecondScreen;
        return MaterialPageRoute(
                builder: (_) => SecondScreen(title: args.title),
        );

      default:
        return MaterialPageRoute(
                builder: (_) => Scaffold(
              body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
