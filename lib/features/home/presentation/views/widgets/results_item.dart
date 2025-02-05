import 'package:flutter/material.dart';

class ResultsItem extends StatelessWidget {
  final Color color;
  final String text;
  final int result;
  const ResultsItem({
    super.key,
    required this.color,
    required this.text,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(children: [
            Text(text),
            const Spacer(),
            CircleAvatar(
              backgroundColor: color,
              foregroundColor: Colors.white,
              child: Text(result.toString()),
            ),
          ]),
        ),
      ),
    );
  }
}
