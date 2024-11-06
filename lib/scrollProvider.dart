import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scrollControllerProvider = Provider<ScrollController>((ref) {
  final controller = ScrollController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final isButtonVisibleProvider = StateNotifierProvider<ScrollButtonNotifier, bool>((ref) {
  final scrollController = ref.watch(scrollControllerProvider);
  return ScrollButtonNotifier(scrollController);
});

class ScrollButtonNotifier extends StateNotifier<bool> {
  final ScrollController _scrollController;

  ScrollButtonNotifier(this._scrollController) : super(false) {
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final shouldBeVisible = _scrollController.offset > 100;
    if (shouldBeVisible != state) {
      state = shouldBeVisible;
    }
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }
}