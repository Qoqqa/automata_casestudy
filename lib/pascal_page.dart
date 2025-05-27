import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

const String pascalDescription =
    "Pascal's Triangle is a triangular array of numbers where each number is the sum of the two directly above it. It starts with a single 1 at the top, and each subsequent row represents the coefficients of the binomial expansion (a + b)^n.";

class PascalPage extends StatefulWidget {
  static const routePath = '/pascal';
  const PascalPage({super.key});

  @override
  State<PascalPage> createState() => _PascalPageState();
}

class _PascalPageState extends State<PascalPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<List<int>> _triangle = [];
  String? _error;
  bool _showResult = false;
  late AnimationController _bgAnimController;

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

  void _generateTriangle() {
    setState(() {
      _error = null;
      _triangle = [];
      _showResult = false;
      final input = _controller.text.trim();
      if (input.isEmpty || int.tryParse(input) == null) {
        _error = "Please enter a valid positive number.";
        _showResult = true;
        return;
      }
      final numRows = int.parse(input);
      if (numRows < 0) {
        _error = "Number must be 0 or greater.";
        _showResult = true;
        return;
      }
      for (int i = 0; i <= numRows; i++) {
        _triangle.add(List.filled(i + 1, 1));
        for (int j = 1; j < i; j++) {
          _triangle[i][j] = _triangle[i - 1][j - 1] + _triangle[i - 1][j];
        }
      }
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
    if (_triangle.isNotEmpty) {
      final text = _triangle.map((row) => row.join(' ')).join('\n');
      Clipboard.setData(ClipboardData(text: text));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Triangle copied to clipboard!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Pascal's Triangle Generator",
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
      floatingActionButton: _triangle.isNotEmpty
          ? FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 60, 145, 156),
              onPressed: _scrollToTop,
              child: const Icon(Icons.arrow_upward, color: Colors.white),
              tooltip: 'Scroll to top',
            )
          : null,
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
                          _bgAnimController.value)!,
                      Color.lerp(
                          Colors.cyan[50],
                          Colors.teal[200],
                          1 - _bgAnimController.value)!,
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
                      child: const Icon(
                        Icons.change_history, // triangle for Pascal's Triangle
                        color: Color.fromARGB(255, 60, 145, 156),
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
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      pascalDescription,
                      style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.white),
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
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text(
                          "Generate Pascal's Triangle",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Input number of rows',
                            prefixIcon: const Icon(Icons.format_list_numbered, color: Color.fromARGB(255, 60, 145, 156)),
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
                            onPressed: _generateTriangle,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 60, 145, 156),
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
                  child: _showResult && (_error != null || _triangle.isNotEmpty)
                      ? Card(
                          key: ValueKey(_error ?? _triangle.length),
                          elevation: 4,
                          color: _error != null
                              ? const Color(0xFFd32f2f)
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: _error != null
                                ? Text(
                                    _error!,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                  )
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Expanded(
                                            child: Text(
                                              "Pascal's Triangle:",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.copy_rounded),
                                            tooltip: 'Copy triangle',
                                            onPressed: _copyResult,
                                            color: Colors.teal[400],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      if (_triangle.isNotEmpty)
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: ConstrainedBox(
                                            constraints: const BoxConstraints(minWidth: 400),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: _triangle
                                                  .map((row) => Padding(
                                                        padding: const EdgeInsets.symmetric(vertical: 2),
                                                        child: Text(
                                                          row.join(' '),
                                                          style: const TextStyle(fontSize: 16),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ))
                                                  .toList(),
                                            ),
                                          ),
                                        ),
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
    );
  }
}
