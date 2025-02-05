import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

class CountdownLocaled extends StatelessWidget {
  final VoidCallback onDone;
  final Duration duration;
  const CountdownLocaled({
    super.key,
    required this.onDone,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SlideCountdown(
        onDone: onDone,
        padding: EdgeInsets.zero,
        separatorStyle: const TextStyle(color: Colors.black),
        style: const TextStyle(color: Colors.black),
        decoration: const BoxDecoration(color: Colors.transparent),
        duration: duration,
      ),
    );
  }
}
