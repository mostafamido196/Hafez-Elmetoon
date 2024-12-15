
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/CustomAppBar.dart';
import '../../Widgets/home/drawer.dart';
import '../../Widgets/home/sliver_app_bar.dart';
import '../../Widgets/home/sliver_list.dart';
import '../../Widgets/home/sliver_search.dart';
import '../../core/Rout.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _drawerController;
  bool _showFAB = true;
  bool _isDrawerOpen = false;
  double _dragStartX = 0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    _drawerController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  void toggleDrawer() {
    if (_isDrawerOpen) {
      _drawerController.reverse();
    } else {
      _drawerController.forward();
    }
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
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
    _drawerController.dispose();
    super.dispose();
  }

  // Add this method to handle back button
  Future<bool> _onWillPop() async {
    if (_isDrawerOpen) {
      toggleDrawer();
      return false; // Don't exit the app
    }
    return true; // Allow app exit
  }

  @override
  Widget build(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    return PopScope(
        // Using PopScope instead of WillPopScope
        canPop: !_isDrawerOpen, // Only allow pop when drawer is closed
        onPopInvoked: (didPop) {
          if (!didPop) {
            toggleDrawer();
          }
        },
        child: Scaffold(
          appBar: CommonAppBar(
            title: 'حافظ المتون',
            backgroundColor: Colors.yellow,
            elevation: 20,
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: toggleDrawer,
            ),
          ),
          body: Stack(
            children: [
              // The main content
              GestureDetector(
                onTap: () {
                  // Close drawer when tapping the main content
                  if (_isDrawerOpen) {
                    toggleDrawer();
                  }
                },
                onHorizontalDragStart: (details) {
                  _dragStartX = details.globalPosition.dx;
                  _isDragging = true;
                },
                onHorizontalDragUpdate: (details) {
                  if (!_isDragging) return;

                  final currentX = details.globalPosition.dx;
                  final dragDistance = currentX - _dragStartX;
                  final screenWidth = MediaQuery.of(context).size.width;

                  if (isRTL) {
                    // For RTL: check right edge drag
                    if (_dragStartX > (screenWidth - 60) &&
                        dragDistance < -50 &&
                        !_isDrawerOpen) {
                      _isDragging = false;
                      toggleDrawer();
                    } else if (_isDrawerOpen && dragDistance > 50) {
                      _isDragging = false;
                      toggleDrawer();
                    }
                  } else {
                    // For LTR: check left edge drag
                    if (_dragStartX < 60 &&
                        dragDistance > 50 &&
                        !_isDrawerOpen) {
                      _isDragging = false;
                      toggleDrawer();
                    } else if (_isDrawerOpen && dragDistance < -50) {
                      _isDragging = false;
                      toggleDrawer();
                    }
                  }
                },
                onHorizontalDragEnd: (details) {
                  _isDragging = false;
                },
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    const SliverAppBarBldr(),
                    const SliverSearch(),
                    SliverListBldr(),
                  ],
                ),
              ),

              // The Drawer
              AnimatedBuilder(
                animation: _drawerController,
                builder: (context, child) {
                  final double drawerWidth = 250.0;
                  double translateX;

                  if (isRTL) {
                    // RTL translation
                    translateX = (1.0 - _drawerController.value) * drawerWidth;
                  } else {
                    // LTR translation
                    translateX = (_drawerController.value - 1.0) * drawerWidth;
                  }

                  return Transform(
                    transform: Matrix4.identity()..translate(translateX),
                    child: Align(
                      alignment:
                          isRTL ? Alignment.centerRight : Alignment.centerLeft,
                      child: DrawerWidget(
                        drawerWidth: drawerWidth,
                        closeDrawer: toggleDrawer,
                        gotoAddScreen: gotoAddScreen,
                      ),
                    ),
                  );
                },
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
        ));
  }

  gotoAddScreen() {
    // Close the drawer before navigating
    if (_isDrawerOpen) {
      toggleDrawer();
    }
    _scrollToTop();
    GoRouter.of(context).pushNamed(
      AppRoutes.addAudio.name,
      pathParameters: {'title': 'Hello from Home!'},  // passing the parameter
    );
  }
}
