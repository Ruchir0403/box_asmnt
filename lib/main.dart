import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Padding(
        padding: EdgeInsets.all(32.0),
        child: SquareAnimation(),
      ),
    );
  }
}

class SquareAnimation extends StatefulWidget {
  const SquareAnimation({super.key});

  @override
  State<SquareAnimation> createState() {
    return SquareAnimationState();
  }
}

class SquareAnimationState extends State<SquareAnimation> {
  static const _squareSize = 50.0;
  double _position = 0.0;
  bool _isMoving = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _position = MediaQuery.of(context).size.width / 2 - _squareSize / 2;
      });
    });
  }

  void _moveRight() {
    setState(() {
      _isMoving = true;
      _position = MediaQuery.of(context).size.width - _squareSize - 32;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() => _isMoving = false);
    });
  }

  void _moveLeft() {
    setState(() {
      _isMoving = true;
      _position = 0.0;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() => _isMoving = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final maxRight = MediaQuery.of(context).size.width - _squareSize - 32;
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          width: _squareSize,
          height: _squareSize,
          margin: EdgeInsets.only(left: _position),
          decoration: BoxDecoration(
            color: Colors.red,
            border: Border.all(),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: !_isMoving && _position < maxRight ? _moveRight : null,
              child: const Text('Right'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: !_isMoving && _position > 0 ? _moveLeft : null,
              child: const Text('Left'),
            ),
          ],
        ),
      ],
    );
  }
}
