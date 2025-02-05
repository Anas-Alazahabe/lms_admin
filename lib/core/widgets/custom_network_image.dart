import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lms_admin/core/utils/assets.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: url,
      progressIndicatorBuilder: (context, url, progress) {
        return const CustomLoading();
      },
      errorWidget: (context, url, error) {
        return Image.asset(AssetsData.logo);
      },
    );
  }
}
