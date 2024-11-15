import 'package:flutter/material.dart';

import 'AppTextStyle.dart';
import 'CustomAppBar.dart';
import 'Widgets/sliver_app_bar.dart';
import 'Widgets/sliver_list.dart';
import 'Widgets/sliver_search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: TextTheme(
            // label body title header
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
        home: const MyHomePage(),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ScrollController _scrollController;
  bool _showFAB = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset > 100) {
      if (!_showFAB) setState(() => _showFAB = true);
    } else {
      if (_showFAB) setState(() => _showFAB = false);
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              const SliverAppBarBldr(),
              const SliverSearch(),
              SliverListBldr(),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CommonAppBar(
              title: 'حافظ المتون',
              backgroundColor: Colors.yellow.withOpacity(0.6),
              elevation: 20,
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: AnimatedSlide(
        duration: Duration(milliseconds: 300),
        offset: _showFAB ? Offset.zero : Offset(0, 2),
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: _showFAB ? 1.0 : 0.0,
          child: FloatingActionButton(
            onPressed: _scrollToTop,
            child: Icon(Icons.arrow_upward),
            backgroundColor: Colors.yellow,
          ),
        ),
      ),
    );
  }
}
