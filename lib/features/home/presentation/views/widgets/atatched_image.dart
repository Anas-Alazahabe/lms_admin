import 'package:flutter/material.dart';

class AtatchedImage extends StatefulWidget {
  final Image attatchedImage;
  const AtatchedImage({super.key, required this.attatchedImage});

  @override
  State<StatefulWidget> createState() => AtatchedImageState();
}

class AtatchedImageState extends State<AtatchedImage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: InteractiveViewer(
                  boundaryMargin: const EdgeInsets.all(20),
                  minScale: 0.1,
                  maxScale: 2,
                  child: AspectRatio(
                      aspectRatio: 1, child: widget.attatchedImage)),
            ),
          ),
        ),
      ),
    );
  }
}
