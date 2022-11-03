import 'package:flutter/material.dart';
import 'package:flutter_google_book/features/book/presentation/screen/book_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const BookScreen(),
    );
  }
}
