import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../model/NewsModel.dart';
import 'package:http/http.dart' as http;

class NewsProvider with ChangeNotifier {
  NewsModel? _news;
  List<Datum> filteredNews = [];
  NewsModel? get news => _news;
  Future<void> fetchNewsData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=2655fb40e23e447f8de5688207c6bf5c'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        _news = NewsModel.fromJson(data);
        notifyListeners();
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  void filterNews(String searchTerm) {
    if (_news != null) {
      // Assuming _news.data is a List<Datum>
      filteredNews = _news!.data
          .where((article) =>
              article.title!.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }

  void sortNewsByTitle() {
    if (_news != null) {
      _news!.data.sort((a, b) => a.title!.compareTo(b.title!));
      notifyListeners();
    }
  }

  void sortNewsByDate() {
    if (_news != null) {
      _news!.data.sort((a, b) => a.publishedAt!.compareTo(b.publishedAt!));
      notifyListeners();
    }
  }
}
