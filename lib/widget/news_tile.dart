import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:news_app/providers/single_news.dart';
import 'package:news_app/screens/news_detail_screen.dart';
import 'package:news_app/widget/bookmark_icon.dart';
import 'package:provider/provider.dart';

class NewsTile extends StatelessWidget {
  final SingleNews newsItem;
  const NewsTile(this.newsItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10.0), // adjust the value as per your need
        ),
        elevation: 5,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(NewsDetailScreen.routeName, arguments: newsItem);
          },
          child: Column(
            children: [
              newsItem.imageUrl == null
                  ? Container()
                  : ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: Image.network(
                        newsItem.imageUrl!,
                        fit: BoxFit.contain,
                      ),
                    ),
              Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  newsItem.title,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Container(
                  padding: EdgeInsets.all(0),
                  width: double.infinity,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Category: ${newsItem.category![0]}',
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              ChangeNotifierProvider.value(
                                value: newsItem,
                                child: BookmarkIcon(),
                              ),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.share)),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
