import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitPouringHourGlass(
        duration: Duration(seconds: 1),
        color: Color.fromARGB(255, 13, 47, 75),
      ),
    );
  }
}
