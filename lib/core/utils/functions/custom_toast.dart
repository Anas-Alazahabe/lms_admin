import 'package:flutter/material.dart';

void customToast(BuildContext context, String text) async {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}
