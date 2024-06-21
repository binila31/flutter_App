import 'package:flutter/material.dart';
import '../models/news_article.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsArticle article;

  NewsDetailScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title ?? 'No Title'), // Use ?? to provide a default value if article.title is null
      ),

      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            // User swiped Left
          } else if (details.primaryVelocity! > 0) {
            // User swiped Right
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              article.urlToImage != null
                  ? Hero(
                tag: article.urlToImage?? '',
                child: CachedNetworkImage(imageUrl: article.urlToImage?? '',)
              )
                  : Container(),
              SizedBox(height: 10),
              Text(article.title ?? 'No Title', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(article.description?? 'No Description'),
            ],
          ),
        ),
      ),
    );
  }
}
