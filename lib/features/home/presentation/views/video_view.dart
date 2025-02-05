import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final String path;
  // final Video video;
  const VideoView({
    super.key,
    required this.path,
    //  requiredthis.video
  });

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  final Map<int, ValueNotifier<bool>> imageShown = {}; // Change this line

  @override
  void initState() {
    super.initState();

    _videoPlayerController =
        VideoPlayerController.file(File.fromUri(Uri.file(widget.path)));
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      zoomAndPan: true,
    );
    // initVideoQuiz(
    //     context: context,
    //     imageShown: imageShown,
    //     videoPlayerController: _videoPlayerController,
    //     setState: setState,
    //     video: widget.video);
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Chewie(
            controller: _chewieController!,
          ),
        ),
      ),
    );
  }
}
