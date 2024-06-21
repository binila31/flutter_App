import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/news_service.dart';
import 'screens/news_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
       MaterialApp(
        title: 'News App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NewsListScreen(),
      );
  }
}
