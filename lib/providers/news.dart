import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/providers/single_news.dart';
import 'package:shared_preferences/shared_preferences.dart';

final String apiKey = 'pub_195210aeeaf77392c56349cf3b858e83710df';
final String apiUrl =
    'https://newsdata.io/api/1/news?apikey=$apiKey&language=en';
// final String apiUrl =
//     'https://newsdata.io/api/1/news?apikey=pub_195210aeeaf77392c56349cf3b858e83710df&q=pizza';

class NewsData with ChangeNotifier {
  List<SingleNews> _news = [];

  List<SingleNews> get news {
    return [..._news];
  }

  void setNews(List<SingleNews> list) {
    _news = list;
    notifyListeners();
  }

  Future<void> fetchNews() async {
    final url = Uri.parse(apiUrl);
    try {
      final response = await http.get(url);
      print(response.statusCode);
      final extracedData = json.decode(response.body) as Map<String, dynamic>;
      // print(extracedData.containsKey('results'))
      print(extracedData["results"]);
      final results = extracedData['results'] as List<dynamic>;
      // final results = List<Map<String, dynamic>>.from(extracedData['results']);
      // final extracedNews = results as List<Map<String, dynamic>>;
      List<SingleNews> _extractedNews = [];

      for (var element in results) {
        print(element['title']);
        // print('hello');
        _extractedNews.add(
          SingleNews(
            pubDate: element['pubDate'],
            category: element['category'],
            title: element['title'],
            link: element['link'],
            creator: element['creator'],
            description: element['description'],
            content: element['content'],
            imageUrl: element['image_url'].toString().startsWith('http') == true
                ? element['image_url']
                : null,
            country: element['country'],
            language: element['language'],
            videoUrl: element['video_url'],
            sourceId: element['source_id'],
          ),
        );
      }
      // print(_extractedNews.length);
      _news = _extractedNews;
      final prefs = await SharedPreferences.getInstance();
      print('object');
      String storeData = jsonEncode(_extractedNews);
      // _extractedNews.
      // print('object2');
      prefs.setString('news', storeData);

      // print(_extractedNews[1]);
      // print(_news[1]);

      // _news
      if (response.statusCode == 200) {
        // Handle the successful response here
        // print(response.body.toString());
      } else {
        // Handle the error response here
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString() + 'hello');
    }
    notifyListeners();
  }

  void removeAllAsBookmark() {
    List<SingleNews> list = _news;
    list.forEach((element) {
      if (element.bookmark == true) {
        element.bookmark = false;
      }
    });
    _news = list;
    notifyListeners();
  }
}
