import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';
import 'package:news_pulse/model/newsArt.dart';

class FetchNews {
  static List sourcesId = [
    "abc-news",
    "bbc-news",
    "bbc-sport",
    "business-insider",
    "engadget",
    "entertainment-weekly",
    "espn",
    "espn-cric-info",
    "financial-post",
    "fox-news",
    "fox-sports",
    "globo",
    "google-news",
    "google-news-in",
    "medical-news-today",
    "national-geographic",
    "news24",
    "new-scientist",
    "new-york-magazine",
    "next-big-future",
    "techcrunch",
    "techradar",
    "the-hindu",
    "the-wall-street-journal",
    "the-washington-times",
    "time",
    "usa-today",
  ];

  static Future<List<NewsArt>> fetchNews() async {
    final _random = Random();
    var sourceID = sourcesId[_random.nextInt(sourcesId.length)];

    try {
      Response response = await get(Uri.parse(
          "https://newsapi.org/v2/top-headlines?sources=$sourceID&apiKey=6f34331685cb4486bc5b14b687a3fdef"));

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Map body_data = jsonDecode(response.body);
        List articles = body_data["articles"];
        return articles.map<NewsArt>((article) => NewsArt.fromAPItoApp(article)).toList();
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      print('Error fetching news: $e');
      throw e; // Rethrow the exception
    }
  }
}
