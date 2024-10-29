import 'package:flutter/material.dart';
import 'package:news_pulse/controller/fetchNews.dart';
import 'package:news_pulse/model/newsArt.dart';
import 'package:news_pulse/view/widget/NewsContainer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  List<NewsArt>? newsArticles; // Change to a list

  Future<void> getNews() async {
    try {
      newsArticles = await FetchNews.fetchNews(); // Fetch multiple articles
    } catch (e) {
      print('Error fetching news: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : newsArticles == null || newsArticles!.isEmpty
          ? Center(child: Text("No news available"))
          : PageView.builder(
        controller: PageController(initialPage: 0),
        scrollDirection: Axis.vertical,
        itemCount: newsArticles!.length,
        itemBuilder: (context, index) {
          final newsArt = newsArticles![index];
          return NewsContainer(
            imgUrl: newsArt.imgUrl,
            newsCnt: newsArt.newsCnt,
            newsHead: newsArt.newsHead,
            newsDes: newsArt.newsDes,
            newsUrl: newsArt.newsUrl,
          );
        },
      ),
    );
  }
}
