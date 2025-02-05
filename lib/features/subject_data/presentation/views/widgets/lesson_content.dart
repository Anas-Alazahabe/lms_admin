// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lms_admin/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_admin/core/enums/types_enum.dart';
import 'package:lms_admin/core/utils/service_locator.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/header_image.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/header_widget.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/home_view_body_header.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/lesson.dart';
import 'package:lms_admin/features/subject_data/presentation/views/widgets/files_list_view.dart';
import 'package:lms_admin/features/subject_data/presentation/views/widgets/lesson_tab_view.dart';
import 'package:lms_admin/features/subject_data/presentation/views/widgets/quizzes_list_view.dart';

class LessonContent extends StatefulWidget {
  final Lesson lesson;
  final String subjectName;
  final String unitName;
  final String subjectId;

  final TabController tabController;
  const LessonContent({
    super.key,
    required this.lesson,
    required this.tabController,
    required this.subjectName,
    required this.unitName,
    required this.subjectId,
  });

  @override
  State<LessonContent> createState() => _LessonContentState();
}

class _LessonContentState extends State<LessonContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeViewBodyHeader(
          action: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const HeaderImage(
                      imageUrl: '', //TODO add an actual image
                    ),

                    // ImageButton(
                    //   courseIndex: widget.courseIndex,
                    //   video: state.courseModel.data!.video!,
                    //   subjectName: widget.datumSubjects.name!,
                    // ),

                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16, left: 16, right: 16, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            // textAlign: TextAlign.center,
                            widget.lesson.name!,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          // const Spacer(),
                        ],
                      ),
                    ),

                    SizedBox(
                      width: 120,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.tabController.animateTo(0);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: widget.tabController.index == 0
                                        ? Colors.red
                                        : Colors.transparent,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Lesson\'s videos ',
                                style: TextStyle(
                                  color: widget.tabController.index == 0
                                      ? Colors.red
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.tabController.animateTo(1);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: widget.tabController.index == 1
                                        ? Colors.red
                                        : Colors.transparent,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Files',
                                style: TextStyle(
                                  color: widget.tabController.index == 1
                                      ? Colors.red
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.tabController.animateTo(2);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: widget.tabController.index == 2
                                        ? Colors.red
                                        : Colors.transparent,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Quizzez',
                                style: TextStyle(
                                  color: widget.tabController.index == 2
                                      ? Colors.red
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // TabBar(
                    //   // tabAlignment: TabBar.secondary(tabs: tabs),
                    //   controller: tabController,
                    //   labelColor: Colors.red, // Active label color
                    //   unselectedLabelColor:
                    //       Colors.grey, // Inactive label color
                    //   indicatorColor: Colors.red, // Indicator color
                    //   tabs: [
                    //     Tab(
                    //       text: 'الوحدات (${state.data.data!.length})',
                    //     ),
                    //     Tab(
                    //       text: 'المرفقات',
                    //     ),
                    //     Tab(
                    //       text: 'الاختبارات',
                    //     ),
                    //   ],
                    // ),

                    //  ShowTeacher(),
                  ],
                ),
              ),

              Expanded(
                flex: 3,
                child: TabBarView(
                  controller: widget.tabController,
                  children: [
                    LessonTabView(
                      unitName: widget.unitName,
                      lesson: widget.lesson,
                      tabController: widget.tabController,
                      subjectName: widget.subjectName,
                      subjectId: widget.subjectId,
                    ),
                    // UnitsListView(
                    //   subjectName: widget.subject.name!,
                    //   units: state.data,
                    //   subjectId: widget.subject.id!,
                    // ),
                    FilesListView(
                      imageUrl: widget.lesson.imageUrl!,
                      files: widget.lesson.files!,
                      lessonId: widget.lesson.id!,
                      subjectId: null,
                    ),
                    // const Center(child: Text('المرفقات')),
                    QuizzseListView(
                      parentId: widget.lesson.id!,
                      subjectId: widget.subjectId,
                      type: Types.lesson.name,
                    )
                  ],
                ),
              ),

              // Expanded(
              //   child: Column(
              //     children: [
              //       Column(
              //         children: [
              //           if (tabController.index == 0)
              //             UnitsListView(
              //               subjectName: widget.subject.name!,
              //               units: state.data,
              //               subjectId: widget.subject.id!,
              //             ),
              //           if (tabController.index == 1) const Text('files'),
              //           if (tabController.index == 2)
              //             const Text('quizzes')
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );

    //  CustomScrollView(
    //   physics: const BouncingScrollPhysics(),
    //   slivers: [
    //     HeaderWidget(
    //       lessonName: lesson.name!,
    //       imageUrl: lesson.imageUrl!,
    //     ),
    //     SliverToBoxAdapter(
    //       child: TabBar(
    //         controller: tabController,
    //         labelColor: Colors.red,
    //         unselectedLabelColor: Colors.grey,
    //         indicatorColor: Colors.red,
    //         tabs: const [
    //           Tab(text: 'مقاطع الدرس'),
    //           Tab(text: 'المرفقات'),
    //           Tab(text: 'الاختبارات'),
    //         ],
    //       ),
    //     ),
    //     SliverToBoxAdapter(
    //       child: LessonTabView(
    //         unitName: unitName,
    //         lesson: lesson,
    //         tabController: tabController,
    //         subjectName: subjectName,
    //         subjectId: subjectId,
    //       ),
    //     ),
    //   ],
    // );
  }
}
