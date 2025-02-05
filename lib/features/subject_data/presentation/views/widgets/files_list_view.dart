import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/utils/assets.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/file.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/video.dart';
import 'package:lms_admin/features/subject_data/presentation/views/widgets/new_file.dart';
import 'package:lms_admin/features/subject_data/presentation/views/widgets/new_video.dart';

class FilesListView extends StatefulWidget {
  // final String lessonName;
  final String? lessonId;
  final String? subjectId;
  // final String unitName;

  final List<Filee> files;
  final String imageUrl;

  const FilesListView({
    super.key,
    required this.files,
    required this.lessonId,
    required this.imageUrl,
    required this.subjectId,
    // required this.subjectName,
    // required this.unitName,
  });

  @override
  State<FilesListView> createState() => _FilesListViewState();
}

class _FilesListViewState extends State<FilesListView> {
  late List<Filee> files;

  @override
  void initState() {
    files = widget.files;
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.files.length,
                itemBuilder: (context, index) {
                  return widget.files.isEmpty
                      ? const Text('لا يوجد مرفقات')
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: Colors.grey, width: 2)),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                '$kBaseUrlAsset/${widget.imageUrl}',
                                            progressIndicatorBuilder:
                                                (context, url, progress) {
                                              return const CustomLoading();
                                            },
                                            errorWidget: (context, url, error) {
                                              return Image.asset(
                                                  AssetsData.logo);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      widget.files[index].name!,
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
              NewFile(
                onAdd: (file) {
                  setState(() {
                    files.add(file);
                  });
                },
                lessonId: widget.lessonId,
                subjectId: widget.subjectId,
              ),
            ],
          ),
        ));
  }
}
