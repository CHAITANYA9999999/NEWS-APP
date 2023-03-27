import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:news_app/providers/single_news.dart';
import 'package:provider/provider.dart';

class NewsDetailScreen extends StatefulWidget {
  static const routeName = '/news-detail-screen';

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  // final SingleNews newsItem;
  @override
  Widget build(BuildContext context) {
    final newsItem = ModalRoute.of(context)!.settings.arguments as SingleNews;
    print(newsItem.title);
    print(newsItem.bookmark);
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.volume_up),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.message),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              newsItem.toggleBookmark();
            });
          },
          icon:
              Icon(newsItem.bookmark ? Icons.bookmark : Icons.bookmark_outline),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.share),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.subscriptions),
        ),
      ]),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Text(
            newsItem.title,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: double.infinity,
            child: Text(
              'Published On: ${newsItem.pubDate}',
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.start,
            ),
          ),
          newsItem.country == null
              ? Container()
              : Container(
                  width: double.infinity,
                  child: Text(
                    'Country: ${newsItem.country[0].toString().toUpperCase()}',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.start,
                  ),
                ),
          newsItem.sourceId == null
              ? Container()
              : Container(
                  width: double.infinity,
                  child: Text(
                    'Source Id: ${newsItem.sourceId.toString().toUpperCase()}',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.start,
                  ),
                ),
          newsItem.creator == null
              ? Container()
              : Container(
                  width: double.infinity,
                  child: Text(
                    'Creator: ${newsItem.creator![0]}',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.start,
                  ),
                ),
          SizedBox(
            height: 10,
          ),
          newsItem.link == null
              ? Container()
              : Container(
                  width: double.infinity,
                  child: Text(
                    'Link: ${newsItem.link}',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.start,
                  ),
                ),
          SizedBox(
            height: 10,
          ),
          newsItem.videoUrl == null
              ? Container()
              : Container(
                  width: double.infinity,
                  child: Text(
                    'Video: ${newsItem.videoUrl}',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.start,
                  ),
                ),
          SizedBox(
            height: 10,
          ),
          newsItem.imageUrl == null
              ? Container()
              : Container(
                  child: Image.network(newsItem.imageUrl!),
                ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              newsItem.content!,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          )
        ],
      )),
    );
  }
}
