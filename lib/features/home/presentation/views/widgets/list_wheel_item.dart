import 'package:flutter/material.dart';
import 'package:lms_admin/constants.dart';

class ListWheelItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isMistake;
  final VoidCallback onTap;

  const ListWheelItem({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    required this.isMistake,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isMistake && !isSelected
                ? Colors.red
                : (isSelected ? Colors.black : Colors.transparent),
            border: Border.all(color: kAppColor),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
