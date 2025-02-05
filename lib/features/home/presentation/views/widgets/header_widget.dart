// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/header_image.dart';

class HeaderWidget extends StatelessWidget {
  final String lessonName;
  final String imageUrl;

  const HeaderWidget(
      {super.key, required this.lessonName, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          HeaderImage(imageUrl: imageUrl),
          const SizedBox(height: 10),
          Padding(
            padding:
                const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
            child: Row(
              children: [
                Text(
                  lessonName,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Divider(height: 10, thickness: 1),
        ],
      ),
    );
  }
}
