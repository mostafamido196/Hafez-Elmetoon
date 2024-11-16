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
    return MaterialApp(
      title: 'حافظ المتون',
      debugShowCheckedModeBanner: false,
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
      home: Directionality(
          textDirection: TextDirection.rtl, child: const MyHomePage()),
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
      // drawer: Opacity(
      //     opacity: 0.7,
      //     child: Container(width: 300,color: Colors.yellow,)//DrawerWidget(),
      // ),
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
/*

  Widget DrawerWidget(){
    return Drawer(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(0))),
        width: 260,
        child: Container(
          color: AppColors.c1Drawer,
          child: ListView(padding: EdgeInsets.zero, children: [
            _buildHeader(),
            _buildFirstListTile(
              'assets/images/ic_menu.svg',
              'الأذكار',
              AppColors.c4Actionbar,
            ),
            _buildListTile(
              context,
              'assets/images/baseline_settings_24.svg',
              'الإعدادات',
              AppColors.white,
            ),
            _buildListTile(
              context,
              'assets/images/baseline_error_24_white.svg',
              'عن التطبيق',
              AppColors.white,
            ),
          ]),
        ));
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(left: 14, bottom: 14, top: 14, right: 14),
      decoration: BoxDecoration(color: AppColors.c4Actionbar),
      child: const Text(
        "ۛ ּڝــحۡــۑْۧــحۡ اﻷذڪــٰٱڕ",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'typesetting',
          color: Colors.white,
          fontSize: 40,
        ),
      ),
    );
  }

  Widget _buildFirstListTile(String asset, String title, Color textColor) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        leading: SvgPicture.asset(
          asset,
          width: 16.0,
          height: 16.0,
        ),
        title: Text(title),
        textColor: textColor,
        onTap: () {
          //   Handle onTap
        },
      ),
    );
  }
  Widget _buildListTile(
      BuildContext context, String asset, String title, Color textColor) {
    return ListTile(
      leading: SvgPicture.asset(
        asset,
        width: 24.0,
        height: 24.0,
      ),
      title: Text(title),
      textColor: textColor,
      onTap: () {
        if (Scaffold.of(context).isDrawerOpen) {
          Navigator.of(context).pop();
        }
        switch (title) {
          case 'الإعدادات':
            _gotoSettingPage(context);
            break;
          case 'عن التطبيق':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AboutScreen(),
              ),
            );
            break;
          default:
          // Default code block
        }
      },
    );
  }

  void _gotoSettingPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SettingScreen(),
      ),
    );
  }*/
}
