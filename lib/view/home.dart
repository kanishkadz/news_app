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
  NewsArt? newsArt;

  Future<void> getNews() async {
    try {
      newsArt = await FetchNews.fetchNews();
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
          : PageView.builder(
        controller: PageController(initialPage: 0),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          if (newsArt == null) {
            return Center(child: Text("No news available"));
          }

          return NewsContainer(
            imgUrl: newsArt!.imgUrl,
            newsCnt: newsArt!.newsCnt,
            newsHead: newsArt!.newsHead,
            newsDes: newsArt!.newsDes,
            newsUrl: newsArt!.newsUrl,
          );
        },
      ),
    );
  }
}
