import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class SliverListBldr extends StatefulWidget {
  SliverListBldr({Key? key}) : super(key: key);

  @override
  _SliverListBldrState createState() => _SliverListBldrState();
}

class _SliverListBldrState extends State<SliverListBldr>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final List<String> titles = [
    "صحيح البخاري",
    "صحيح مسلم",
    "الأربعون النووية",
    "سنن الترمذي",
    "سنن النسائي",
    "سنن أبي داود",
    "سنن ابن ماجه",
    "مسند الإمام أحمد",
    "موطأ الإمام مالك",
    "رياض الصالحين",
    "الشمائل المحمدية",
    "الأذكار للإمام النووي",
    "صحيح ابن حبان",
    "صحيح ابن خزيمة",
    "المستدرك على الصحيحين",
    "الجامع الصغير للسيوطي",
    "شرح السنة للبغوي",
    "الأدب المفرد للبخاري",
    "الترغيب والترهيب للمنذري",
    "المصنف لعبد الرزاق",
  ];

  final List<Color> bookBackgrounds = [
    const Color(0xFFFFF8E1),
    const Color(0xFFFFECB3),
    const Color(0xFFFFE0B2),
    const Color(0xFFFFE082),
    const Color(0xFFFFD54F),
    const Color(0xFFF0F4C3),
    const Color(0xFFF8BBD0),
    const Color(0xFFE1BEE7),
    const Color(0xFFB2EBF2),
    const Color(0xFFB3E5FC),
    const Color(0xFFBBDEFB),
    const Color(0xFFC8E6C9),
    const Color(0xFFDCEDC8),
    const Color(0xFFFFF3E0),
    const Color(0xFFFFE5E5),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    Future.delayed(Duration(milliseconds: 200), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int noRowItems;
    if (screenWidth < 400) {
      noRowItems = 3;  // Very small screens (small phones)
    } else if (screenWidth < 600) {
      noRowItems = 4;  // Medium screens (regular phones)
    } else if (screenWidth < 900) {
      noRowItems = 5;  // Large screens (tablets)
    } else {
      noRowItems = 7;  // Very large screens
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: noRowItems,
          childAspectRatio: 0.55,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            // Calculate staggered animation delay based on index
            final Animation<double> animation = CurvedAnimation(
              parent: _animationController,
              curve: Interval(
                (index / titles.length) * 0.5,
                // Stagger over first 50% of total duration
                (index / titles.length) * 0.5 + 0.5, // End at different times
                curve: Curves.easeOutCubic,
              ),
            );

            return AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, 50 * (1 - animation.value)),
                  child: Opacity(
                    opacity: animation.value,
                    child: child,
                  ),
                );
              },
              child: _ItemBookName(
                context,
                titles[index],
                bookBackgrounds[index % bookBackgrounds.length],
              ),
            );
          },
          childCount: titles.length,
        ),
      ),
    );
  }

  Widget _ItemBookName(BuildContext context, String title,
      Color bookBackground) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: kBorderRadius,
          color: bookBackground,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 2.0),
                child: Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineLarge,
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0,),
                child: Center(
                  child: Text(
                    title,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

