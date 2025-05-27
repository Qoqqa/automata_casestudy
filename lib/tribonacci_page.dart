import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

const String tribonacciDescription =
    'The Tribonacci sequence is a generalization of the Fibonacci sequence where each term is the sum of the three preceding terms, starting with 0, 1, 1.';

class TribonacciPage extends StatefulWidget {
  const TribonacciPage({super.key});

  @override
  State<TribonacciPage> createState() => _TribonacciPageState();
}

class _TribonacciPageState extends State<TribonacciPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _result = '';
  String _sequence = '';
  String? _error;
  bool _showResult = false;
  late AnimationController _bgAnimController;

  List<int> _generateTribonacciSequence(int n) {
    if (n <= 0) return [];
    if (n == 1) return [0];
    if (n == 2) return [0, 1];
    if (n == 3) return [0, 1, 1];
    List<int> sequence = [0, 1, 1];
    for (int i = 3; i < n; i++) {
      sequence.add(sequence[i - 1] + sequence[i - 2] + sequence[i - 3]);
    }
    return sequence;
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
    _controller.dispose();
    _scrollController.dispose();
    _bgAnimController.dispose();
    super.dispose();
  }

  void _calculateTribonacci() {
    final input = int.tryParse(_controller.text);
    if (input == null || input <= 3) {
      setState(() {
        _error = 'Please enter a valid positive integer not lower than 4.';
        _result = '';
        _sequence = '';
        _showResult = true;
      });
      return;
    }
    final sequence = _generateTribonacciSequence(input);
    setState(() {
      _sequence = sequence.join(', ');
      _result = 'The Tribonacci sequence up to $input terms is:';
      _error = null;
      _showResult = true;
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void _copyResult() {
    if (_sequence.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: _sequence));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sequence copied to clipboard!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Tribonacci Sequence',
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
                        Icons.looks_3, // 3 for Tribonacci
                        color: const Color.fromARGB(255, 60, 145, 156),
                        size: 48,
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
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: const [
                        Text(
                          tribonacciDescription,
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
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
                    Icon(Icons.arrow_downward, color: Colors.teal[400]),
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
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text(
                          'Generate Tribonacci Sequence',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Custom input field
                        TextField(
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Enter the number of terms',
                            prefixIcon: Icon(
                              Icons.format_list_numbered,
                              color: Colors.teal[400],
                            ),
                            filled: true,
                            fillColor: Colors.teal[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.calculate_rounded, color: Colors.white),
                            onPressed: _calculateTribonacci,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                60,
                                145,
                                156,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              foregroundColor: Colors.white,
                              textStyle: const TextStyle(color: Colors.white),
                            ),
                            label: const Text(
                              'Generate',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
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
                  child:
                      _showResult && (_error != null || _result.isNotEmpty)
                          ? Card(
                            key: ValueKey(_error ?? _result),
                            elevation: 4,
                            color:
                                _error != null
                                    ? const Color(0xFFd32f2f)
                                    : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (_error != null)
                                    Text(
                                      _error!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  else ...[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            _result,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.copy_rounded),
                                          tooltip: 'Copy sequence',
                                          onPressed: _copyResult,
                                          color: Colors.teal[400],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    if (_sequence.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          _sequence,
                                          style: const TextStyle(fontSize: 16),
                                          textAlign: TextAlign.left,
                                          softWrap: true,
                                          overflow: TextOverflow.visible,
                                        ),
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
      floatingActionButton:
          _showResult
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
