import 'package:flutter/material.dart';
import 'fibonacci_page.dart';
import 'lucas_page.dart';
import 'tribonacci_page.dart';
import 'collatz_page.dart';
import 'euclidean_page.dart';
import 'pascal_page.dart';

class HomepageWidget extends StatefulWidget {
  const HomepageWidget({super.key});

  static String routeName = 'HOMEPAGE';
  static String routePath = '/homepage';

  @override
  State<HomepageWidget> createState() => _HomepageWidgetState();
}

class _HomepageWidgetState extends State<HomepageWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.cyan[50], // Light cyan background
        appBar: AppBar(
          backgroundColor: Colors.cyan[700], // Cyan app bar
          automaticallyImplyLeading: false,
          title: const Text(
            'Automata Case Study',
            style: TextStyle(
              fontFamily: 'Inter Tight',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 4,
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.cyan[100],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Explore Sequences and Algorithms',
                    style: TextStyle(
                      fontFamily: 'Inter Tight',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.cyan,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Buttons Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton(context, 'Fibonacci Sequence', '/fibonacci'),
                      const SizedBox(height: 20),
                      _buildButton(context, 'Lucas Sequence', '/lucas'),
                      const SizedBox(height: 20),
                      _buildButton(context, 'Tribonacci Sequence', '/tribacci'),
                      const SizedBox(height: 20),
                      _buildButton(context, 'Collatz Sequence', '/collatz'),
                      const SizedBox(height: 20),
                      _buildButton(
                        context,
                        'Euclidean Algorithm',
                        '/euclidean',
                      ),
                      const SizedBox(height: 20),
                      _buildButton(context, "Pascal's Triangle", '/pascal'),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
              // Footer Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Colors.cyan[100],
                child: const Text(
                  'Created by:\nCaasi, Asilito\nColarina, Ricardo Jose',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter Tight',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.cyan,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label, String route) {
    Widget iconWidget;
    switch (route) {
      case '/fibonacci':
        iconWidget = Image.asset(
          'lib/icons/fibonacci.png',
          width: 32,
          height: 32,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
          color: Colors.white,
          colorBlendMode: BlendMode.srcIn,
        );
        break;
      case '/lucas':
        iconWidget = const Icon(Icons.star, color: Colors.white, size: 32);
        break;
      case '/tribacci':
        iconWidget = const Icon(Icons.looks_3, color: Colors.white, size: 32);
        break;
      case '/collatz':
        iconWidget = const Icon(Icons.alt_route, color: Colors.white, size: 32);
        break;
      case '/euclidean':
        iconWidget = const Icon(Icons.compare_arrows, color: Colors.white, size: 32);
        break;
      case '/pascal':
        iconWidget = const Icon(Icons.change_history, color: Colors.white, size: 32);
        break;
      default:
        iconWidget = const Icon(Icons.functions, color: Colors.white, size: 32);
    }
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(_createRoute(route));
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 60, 145, 156),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 16,
                spreadRadius: 2,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.08),
                blurRadius: 2,
                spreadRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: iconWidget,
              ),
              Expanded(
                child: Text(
                  label,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontFamily: 'Inter Tight',
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        color: Colors.black38,
                        offset: Offset(0, 3),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Route _createRoute(String route) {
    return PageRouteBuilder(
      pageBuilder:
          (context, animation, secondaryAnimation) => _getPageForRoute(route),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
    );
  }

  Widget _getPageForRoute(String route) {
    switch (route) {
      case '/fibonacci':
        return const FibonacciPage();
      case '/lucas':
        return const LucasPage();
      case '/tribacci':
        return const TribonacciPage();
      case '/collatz':
        return const CollatzPage();
      case '/euclidean':
        return const EuclideanPage();
      case '/pascal':
        return const PascalPage();
      default:
        return const HomepageWidget();
    }
  }
}
