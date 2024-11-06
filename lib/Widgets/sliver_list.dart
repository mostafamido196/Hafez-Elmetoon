import 'package:flutter/material.dart';

import '../constants.dart';

class SliverListBldr extends StatelessWidget {
  SliverListBldr({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      sliver: _SliverGrid(context),
    );
  }
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


  Widget _SliverGrid(BuildContext context) {
    return SliverToBoxAdapter(
      child: Align(
        alignment: Alignment.center,
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 6,
          runSpacing: 4,
          children: titles.map((title) {
            return _ItemBookName(context, title); // Pass the title parameter
          }).toList(),
        ),
      ),
    );
  }

  Widget _ItemBookName(BuildContext context, String title) {
    return IntrinsicWidth(
      // This helps with wrapping content width
      child: Card(
        child: Container(
          constraints: BoxConstraints(
            minWidth: 120, // Minimum width to prevent too narrow items
            maxWidth: 200, // Maximum width to prevent too wide items
          ),
          decoration: BoxDecoration(
            borderRadius: kBorderRadius,
            color: Colors.amber[100]?.withOpacity(0.3),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 6.0),
                child: Expanded(
                    child: Text(
                  title,
                  // maxLines: 1,
                  // overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center, // Center text alignment
                  style: TextStyle(
                      fontFamily: 'mtnTitle_aldahabi',
                      fontWeight: FontWeight.bold,
                      fontSize: 32),
                )),
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  // Center widget added here
                  child: Text(
                    title,
                    softWrap: true,
                    textAlign: TextAlign.center, // Center text alignment
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
