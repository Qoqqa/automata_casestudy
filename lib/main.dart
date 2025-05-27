import 'package:flutter/material.dart';
import 'homepage.dart';
import 'fibonacci_page.dart';
import 'lucas_page.dart';
import 'tribonacci_page.dart';
import 'collatz_page.dart';
import 'euclidean_page.dart';
import 'pascal_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sequences and Algorithms',
      theme: ThemeData(primarySwatch: Colors.teal),
      initialRoute: HomepageWidget.routePath,
      routes: {
        HomepageWidget.routePath: (context) => const HomepageWidget(),
        '/fibonacci': (context) => const FibonacciPage(),
        '/lucas': (context) => const LucasPage(),
        '/tribacci': (context) => const TribonacciPage(),
        '/collatz': (context) => const CollatzPage(),
        '/euclidean': (context) => const EuclideanPage(),
        PascalPage.routePath: (context) => const PascalPage(),
      },
    );
  }
}
