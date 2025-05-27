import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

const String euclideanDescription =
    'The Euclidean algorithm finds the greatest common divisor (GCD) of two integers by repeatedly applying the division algorithm.';

class EuclideanPage extends StatefulWidget {
  const EuclideanPage({super.key});

  @override
  State<EuclideanPage> createState() => _EuclideanPageState();
}

class _EuclideanPageState extends State<EuclideanPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controllerA = TextEditingController();
  final TextEditingController _controllerB = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _result = '';
  String _steps = '';
  String? _error;
  bool _showResult = false;
  late AnimationController _bgAnimController;

  int _gcd(int a, int b, List<String> steps) {
    while (b != 0) {
      steps.add('$a = $b × ${a ~/ b} + ${a % b}');
      int temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }

  @override
  void initState() {
    super.initState();
    _bgAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controllerA.dispose();
    _controllerB.dispose();
    _scrollController.dispose();
    _bgAnimController.dispose();
    super.dispose();
  }

  void _calculateGCD() {
    int? a = int.tryParse(_controllerA.text);
    int? b = int.tryParse(_controllerB.text);
    if (a == null || b == null || a <= 0 || b <= 0) {
      setState(() {
        _error = 'Please enter two valid positive integers.';
        _result = '';
        _steps = '';
        _showResult = true;
      });
      return;
    }
    // Ensure a is the larger number
    if (b > a) {
      final temp = a;
      a = b;
      b = temp;
    }
    List<String> steps = [];
    final gcd = _gcd(a, b, steps);
    setState(() {
      _steps = steps.join('\n');
      _result = 'The GCD of $a and $b is $gcd.';
      _error = null;
      _showResult = true;
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  void _copyResult() {
    if (_result.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: '$_result\n$_steps'));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Result copied to clipboard!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Euclidean Algorithm',
          style: TextStyle(
            fontFamily: 'Inter Tight',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _bgAnimController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.lerp(
                        Colors.cyan[200],
                        Colors.teal[100],
                        _bgAnimController.value,
                      )!,
                      Color.lerp(
                        Colors.cyan[50],
                        Colors.teal[200],
                        1 - _bgAnimController.value,
                      )!,
                    ],
                  ),
                ),
              );
            },
          ),
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Animated header icon
                AnimatedBuilder(
                  animation: _bgAnimController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: math.pi * 2 * _bgAnimController.value,
                      child: Icon(
                        Icons.compare_arrows, // arrows for Euclidean
                        color: Colors.teal.withOpacity(0.8),
                        size: 64,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 24),
                  color: const Color.fromARGB(255, 60, 145, 156),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      euclideanDescription,
                      style: TextStyle(
                        fontFamily: 'Inter Tight',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                // Decorative divider
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.teal[200],
                        thickness: 2,
                        endIndent: 12,
                      ),
                    ),
                    const Icon(Icons.arrow_downward, color: Colors.teal, size: 24),
                    Expanded(
                      child: Divider(
                        color: Colors.teal[200],
                        thickness: 2,
                        indent: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextField(
                          controller: _controllerA,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'First Number',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _controllerB,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Second Number',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _calculateGCD,
                            icon: const Icon(Icons.search),
                            label: const Text(
                              'Find GCD',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _showResult && (_error != null || _result.isNotEmpty)
                      ? Card(
                          key: ValueKey(_error ?? _result),
                          elevation: 4,
                          color: _error != null
                              ? Colors.red[100]
                              : Colors.teal[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_error != null)
                                  Text(
                                    _error!,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  )
                                else ...[
                                  Text(
                                    _result,
                                    style: const TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    _steps,
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.copy, color: Colors.teal),
                                        tooltip: 'Copy result',
                                        onPressed: _copyResult,
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _showResult
          ? FloatingActionButton(
              onPressed: _scrollToTop,
              backgroundColor: Colors.teal[400],
              child: const Icon(Icons.arrow_upward, color: Colors.white),
              tooltip: 'Scroll to top',
            )
          : null,
    );
  }
}
