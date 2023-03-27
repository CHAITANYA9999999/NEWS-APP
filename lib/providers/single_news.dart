import 'package:flutter/cupertino.dart';

class SingleNews with ChangeNotifier {
  final String title;
  final String? link;
  final List<dynamic>? creator;
  final String? description;
  final String? content;
  final String? pubDate;
  final List<dynamic>? category;
  final String? imageUrl;
  final String language;
  final List<dynamic> country;
  final String? sourceId;
  final String? videoUrl;
  bool bookmark = false;

  SingleNews({
    required this.language,
    required this.country,
    required this.imageUrl,
    required this.pubDate,
    required this.category,
    required this.title,
    required this.link,
    required this.creator,
    required this.description,
    required this.content,
    required this.videoUrl,
    required this.sourceId,
  });

  void toggleBookmark() {
    bookmark = !bookmark;
    notifyListeners();
  }

  Map toJson() {
    return {
      'language': this.language,
      'imageUrl': this.imageUrl,
      'country': this.country,
      'pubDate': this.pubDate,
      'category': this.category,
      'title': this.title,
      'link': this.link,
      'creator': this.creator,
      'description': this.description,
      'content': this.content,
      'videoUrl': this.videoUrl,
      'sourceId': this.sourceId,
    };
  }
}
