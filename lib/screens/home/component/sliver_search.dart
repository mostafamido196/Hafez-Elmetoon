import 'package:flutter/material.dart';

import '../../../core/constants.dart';




class SliverSearch extends StatelessWidget {
  const SliverSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      pinned: true,
      bottom: const PreferredSize(
          preferredSize: Size.fromHeight(10.0), child: SizedBox()),
      flexibleSpace: const SearchBar(),
    );
  }
}


class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6,horizontal: 12),
        child:Container(
        width: MediaQuery.of(context).size.width,
        height: 60.0,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular((kBorderRadius as BorderRadius).topLeft.x / 2,),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Center(
          child: TextFormField(
            style: Theme.of(context).textTheme.titleMedium,
            decoration: InputDecoration(
              border: InputBorder.none, // Remove default border
              isDense: true, // Reduces the internal padding
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
                size: 24.0,
              ),
              hintText: 'بحث باسم الكتاب',
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ));
  }
}

