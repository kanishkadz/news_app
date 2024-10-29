import 'package:flutter/material.dart';

class NewsContainer extends StatelessWidget {
  final String imgUrl;
  final String newsCnt;
  final String newsHead;
  final String newsDes;
  final String newsUrl;

  const NewsContainer({
    Key? key,
    required this.imgUrl,
    required this.newsCnt,
    required this.newsHead,
    required this.newsDes,
    required this.newsUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(imgUrl), // Ensure this is a valid URL
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              newsHead,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(newsDes),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(newsCnt),
          ),
        ],
      ),
    );
  }
}
