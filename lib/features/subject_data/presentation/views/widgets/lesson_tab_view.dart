// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lms_admin/core/enums/types_enum.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/lesson.dart';
import 'package:lms_admin/features/subject_data/presentation/views/widgets/files_list_view.dart';
import 'package:lms_admin/features/subject_data/presentation/views/widgets/quizzes_list_view.dart';
import 'package:lms_admin/features/subject_data/presentation/views/widgets/videos_list_view.dart';

class LessonTabView extends StatefulWidget {
  final Lesson lesson;
  final TabController tabController;
  final String subjectName;
  final String unitName;
  final String subjectId;

  const LessonTabView({
    super.key,
    required this.lesson,
    required this.tabController,
    required this.subjectName,
    required this.unitName, required this.subjectId,
  });

  @override
  State<LessonTabView> createState() => _LessonTabViewState();
}

class _LessonTabViewState extends State<LessonTabView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.tabController.index == 0)
          VideosListView(
            imageUrl: widget.lesson.imageUrl!,
            videos: widget.lesson.videos!,
            lessonId: widget.lesson.id!,
          ),
        if (widget.tabController.index == 1) 
          FilesListView(
            imageUrl: widget.lesson.imageUrl!,
            files: widget.lesson.files!,
            lessonId: widget.lesson.id!,
            subjectId: null,
          ),
        if (widget.tabController.index == 2)
          QuizzseListView(
            parentId: widget.lesson.id!,
            subjectId: widget.subjectId,
            type: Types.lesson.name,
            
          )
      ],
    );
  }
}
