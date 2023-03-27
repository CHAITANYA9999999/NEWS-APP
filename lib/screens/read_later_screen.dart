import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:news_app/providers/news.dart';
import 'package:provider/provider.dart';

import '../widget/news_tile.dart';

class ReadLaterScreen extends StatelessWidget {
  static const routeName = '/read-later';
  const ReadLaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final News = Provider.of<NewsData>(context)
        .news
        .where(((element) => element.bookmark == true))
        .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Read Later',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          PopupMenuButton(onSelected: (value) {
            print(value);
            if (value == 'remove') {
              Provider.of<NewsData>(context, listen: false)
                  .removeAllAsBookmark();
            }
          }, itemBuilder: ((context) {
            return [
              PopupMenuItem(
                child: Text('Remove All'),
                value: 'remove',
              )
            ];
          }))
        ],
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) {
          return NewsTile(News[index]);
        }),
        itemCount: News.length,
      ),
    );
  }
}
