import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/news_service.dart';
import '../models/news_article.dart';
import 'news_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News App')),
      body: FutureBuilder(
        future: NewsService().fetchArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final articles = snapshot.data;
            if(articles==null){
              return SizedBox.shrink();
            }
            return ListView.builder(
              itemCount: articles!.length,
              itemBuilder: (context, index) {
                final article = articles![index];
                return NewsCard(article: article);
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final NewsArticle article;

  NewsCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => NewsDetailScreen(article: article),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              var begin = Offset(1.0, 0.0); // Slide from right
              var end = Offset.zero;
              var curve = Curves.ease;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        );
      },
      child: Card(
        child: Column(
          children: [
            article.urlToImage != null
                ? Hero(
                    tag: article.urlToImage!,
                    child: CachedNetworkImage(imageUrl: article.urlToImage!),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                article.title ?? 'No Title',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(article.description ?? 'No Description'),
            ),
          ],
        ),
      ),
    );
  }
}
