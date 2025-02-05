import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin/core/utils/assets.dart';

class HeaderImage extends StatelessWidget {
  final String imageUrl;
  const HeaderImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 200,
          child: AspectRatio(
              aspectRatio: 16 / 9,
              child:
                  //  CachedNetworkImage(
                  //   fit: BoxFit.fill,
                  //   imageUrl: '$kBaseUrl/get_file/$imageUrl',
                  //   progressIndicatorBuilder: (context, url, progress) {
                  //     return const CustomLoading();
                  //   },
                  //   errorWidget: (context, url, error) {
                  //     return
                  Image.asset(AssetsData.logo)),
        ),
        //   },
        // ),

        Positioned(
          top: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black54),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              onPressed: () {
                context.pop();
              },
              child: const Icon(Icons.arrow_back),
            ),
          ),
        )
      ],
    );
  }
}
