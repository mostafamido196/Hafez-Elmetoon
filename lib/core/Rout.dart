import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hafez_elmetoon/features/addAudio/AddAudioScreen.dart';
import 'package:go_router/go_router.dart';

import '../features/home/HomeScreen.dart';
import '../main.dart';

enum AppRoutes {
  home(name: 'home', path: '/home'),
  second(name: 'second', path: '/second/:title'); // Using ':title' parameter

  const AppRoutes({required this.name, required this.path});

  final String name;
  final String path;
}

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.home.path,
    routes: [
      GoRoute(
        name: AppRoutes.home.name,
        path: AppRoutes.home.path,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: AppRoutes.second.name,
        path: AppRoutes.second.path,
        builder: (context, state) {
          // Use 'title' instead of 'message' to match the path parameter
          final String title = state.pathParameters['title'] ?? '';
          return AddAudioScreen(title: title);
        },
      ),
    ],
  );
}