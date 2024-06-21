import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/news_article.dart';

class NewsService {
  static final NewsService _instance = NewsService._internal();

  factory NewsService() {
    return _instance;
  }

  NewsService._internal();

  static final String apiKey = 'e982fb3a237b4b528f8ca4da4cb939ed';
  final String apiUrl =
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

  List<NewsArticle> _articles = [];

  List<NewsArticle> get articles => _articles;

  Future<List<NewsArticle>> fetchArticles() async {
    final response = await http.get(Uri.parse(apiUrl));
    log(response.body.toString(), name: "API response");
    log(response.statusCode.toString(), name: "API response");
    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['articles'];
      _articles = json.map((data) => NewsArticle.fromJson(data)).toList();
      // notifyListeners(); // Notify listeners when articles are fetched
      return _articles;
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<String> test() async {
    return "";
  }
}
