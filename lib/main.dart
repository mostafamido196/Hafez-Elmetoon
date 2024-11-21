import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/AppTextStyle.dart';
import 'Widgets/CustomAppBar.dart';
import 'core/Rout.dart';
import 'features/addAudio/AddAudioScreen.dart';
import 'Widgets/drawer.dart';
import 'Widgets/sliver_app_bar.dart';
import 'Widgets/sliver_list.dart';
import 'Widgets/sliver_search.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'حافظ المتون',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: TextTheme(
          headlineLarge: AppTextStyles.extraLarge,
          headlineMedium: AppTextStyles.extraMedium,
          titleLarge: AppTextStyles.titleLarge,
          titleMedium: AppTextStyles.titleMedium,
          titleSmall: AppTextStyles.titleSmall,
          bodyLarge: AppTextStyles.titleLarge,
          bodyMedium: AppTextStyles.titleMedium,
          bodySmall: AppTextStyles.titleSmall,
        ),
      ),
      locale: const Locale('ar', ''),
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('ar', ''), // Arabic
      ],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routerDelegate: AppRouter.router.routerDelegate,
      routeInformationProvider: AppRouter.router.routeInformationProvider,
    );
  }
}
