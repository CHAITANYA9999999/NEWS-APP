import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/single_news.dart';
import '../screens/news_detail_screen.dart';

class BookmarkIcon extends StatelessWidget {
  const BookmarkIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SingleNews>(builder: ((context, value, child) {
      return IconButton(
          onPressed: value.toggleBookmark,
          icon: value.bookmark
              ? Icon(Icons.bookmark)
              : Icon(Icons.bookmark_outline));
    }));
  }
}
