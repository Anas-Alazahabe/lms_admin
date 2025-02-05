import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/utils/assets.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/video.dart';
import 'package:lms_admin/features/subject_data/presentation/views/widgets/new_video.dart';

class VideosListView extends StatefulWidget {
  // final String lessonName;
  final String lessonId;
  // final String unitName;

  final List<Video> videos;
  final String imageUrl;

  const VideosListView({
    super.key,
    required this.videos,
    required this.lessonId,
    required this.imageUrl,
    // required this.subjectName,
    // required this.unitName,
  });

  @override
  State<VideosListView> createState() => _VideosListViewState();
}

class _VideosListViewState extends State<VideosListView> {
  late List<Video> videos;

  @override
  void initState() {
    videos = widget.videos;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.videos.length,
              itemBuilder: (context, index) {
                return widget.videos.isEmpty
                    ? const Text('لا يوجد فيديوهات')
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey, width: 2)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(children: [
                                  SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              '$kBaseUrlAsset/${widget.imageUrl}',
                                          progressIndicatorBuilder:
                                              (context, url, progress) {
                                            return const CustomLoading();
                                          },
                                          errorWidget: (context, url, error) {
                                            return Image.asset(AssetsData.logo);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    widget.videos[index].name!,
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                  const Spacer(),
                                ])
                              ],
                            ),
                          ),
                        ),
                      );
              },
            ),
            NewVideo(
              onAdd: (video) {
                setState(() {
                  videos.add(video);
                });
              },
              lessonId: widget.lessonId,
            ),
          ],
        ));
  }
}
