import 'package:flutter/material.dart';

import '../constants.dart';



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
      padding: kPadding,
      child: Container(
        margin: EdgeInsets.zero,
        color: Colors.transparent,
        child: Container(
          margin: EdgeInsets.zero,
          width: MediaQuery.of(context).size.width,
          height: 60.0,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: kBorderRadius / 2,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              style: Theme.of(context).textTheme.titleMedium,
              textAlignVertical: TextAlignVertical.center,
              decoration:  InputDecoration(
                contentPadding: EdgeInsets.only(top: 12.0),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
                hintText: 'بحث باسم الكتاب',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

