import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/read_later_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/providers/news.dart';
import '/providers/single_news.dart';
import '/widget/news_tile.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  bool _isLoading = false;
  bool _isInit = false;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    if (!_isInit) {
      _isLoading = true;

      final ConnectivityResult result =
          await Connectivity().checkConnectivity();

      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        try {
          Provider.of<NewsData>(context, listen: false)
              .fetchNews()
              .then((value) => _isLoading = false);
        } catch (e) {}
        print('Connected to a Wi-Fi network');
      } else {
        final prefs = await SharedPreferences.getInstance();
        final list = json.decode(prefs.getString('news')!);
        List<SingleNews> _extractedNews = [];
        for (var element in list) {
          _extractedNews.add(
            SingleNews(
              pubDate: element['pubDate'],
              category: element['category'],
              title: element['title'],
              link: element['link'],
              creator: element['creator'],
              description: element['description'],
              content: element['content'],
              imageUrl:
                  element['image_url'].toString().startsWith('http') == true
                      ? element['image_url']
                      : null,
              country: element['country'],
              language: element['language'],
              videoUrl: element['video_url'],
              sourceId: element['source_id'],
            ),
          );
        }
        final List<SingleNews> news =
            prefs.containsKey('news') ? _extractedNews : [];

        Provider.of<NewsData>(context, listen: false).setNews(news);
        setState(() {
          _isLoading = false;
        });
        print('Not connected to any network');
      }
    }
    _isInit = true;
    super.didChangeDependencies();
  }

  void handleClick(String value) {
    switch (value) {
      case 'Read Later':
        Navigator.of(context).pushNamed(ReadLaterScreen.routeName);
        break;
      case 'Settings':
        break;
      case 'Share This App':
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final News = Provider.of<NewsData>(context).news;

    ListView listViewBuilder(String text) {
      return ListView.builder(
        itemBuilder: ((context, index) {
          return News[index].category![0] == '$text'
              ? NewsTile(News[index])
              : Container();
        }),
        itemCount: News.length,
      );
    }

    return DefaultTabController(
      length: 7,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            iconTheme: const IconThemeData(color: Colors.black),
            title: Text(
              'News',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            backgroundColor: Colors.white,
            actions: [
              // Image.network(
              //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjRK6mWtRh9OIvzJ1YODARCntQT6t6z9aiiQ',
              //   fit: BoxFit.contain,
              // ),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.subscriptions)),
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {'Read Later', 'Settings', 'Share This App'}
                      .map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
            bottom: const TabBar(isScrollable: true, controller: null, tabs: [
              Tab(child: Text('Home', style: TextStyle(color: Colors.black))),
              Tab(child: Text('Top', style: TextStyle(color: Colors.black))),
              Tab(child: Text('World', style: TextStyle(color: Colors.black))),
              Tab(child: Text('Sports', style: TextStyle(color: Colors.black))),
              Tab(
                  child:
                      Text('Politics', style: TextStyle(color: Colors.black))),
              Tab(
                  child: Text('Entertainment',
                      style: TextStyle(color: Colors.black))),
              Tab(
                  child:
                      Text('Business', style: TextStyle(color: Colors.black))),
            ]),
          ),
          drawer: Drawer(
            child: Column(
              children: [
                // Image.network(
                //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjRK6mWtRh9OIvzJ1YODARCntQT6t6z9aiiQ',
                //   fit: BoxFit.contain,
                // ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.blue[900]),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        'Subscribe to Premium',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // endDrawer: Drawer(),
          body: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : TabBarView(children: [
                  ListView.builder(
                    itemBuilder: ((context, index) {
                      return NewsTile(News[index]);
                    }),
                    itemCount: News.length,
                  ),
                  listViewBuilder('top'),
                  listViewBuilder('world'),
                  listViewBuilder('sports'),
                  listViewBuilder('politics'),
                  listViewBuilder('entertainment'),
                  listViewBuilder('business'),
                ])
          // : Text(News.length.toString()),
          ),
    );
    // : Text('data'));
  }
}
