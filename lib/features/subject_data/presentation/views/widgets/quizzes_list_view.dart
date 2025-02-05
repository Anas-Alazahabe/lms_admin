import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/core/utils/assets.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';
import 'package:lms_admin/features/subject_data/data/models/quizzes_model/quiz.dart';
import 'package:lms_admin/features/subject_data/data/models/quizzes_model/quizzes_model.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/video.dart';
import 'package:lms_admin/features/subject_data/presentation/manager/quizzes/fetch_quizzes_cubit.dart';
import 'package:lms_admin/features/subject_data/presentation/manager/units_cubit.dart';
import 'package:lms_admin/features/subject_data/presentation/views/functions/quiz_dialog.dart';
import 'package:lms_admin/features/subject_data/presentation/views/widgets/new_video.dart';

class QuizzseListView extends StatefulWidget {
  final String subjectId;
  final String type;
  final String parentId;

  // final List<Video> videos;
  // final String imageUrl;

  const QuizzseListView({
    super.key,
    required this.subjectId,
    required this.type,
    required this.parentId,
    // required this.videos,
    // required this.lessonId,
    // required this.imageUrl,
    // required this.subjectName,
    // required this.unitName,
  });

  @override
  State<QuizzseListView> createState() => _QuizzseListViewState();
}

class _QuizzseListViewState extends State<QuizzseListView> {
  List<Quiz> openQuizzes = [];
  List<Quiz> lockQuizzes = [];

  @override
  void initState() {
    // videos = widget.videos;
    super.initState();
    BlocProvider.of<FetchQuizzesCubit>(context).fetchQuizzes(
        subjectId: widget.subjectId,
        type: widget.type,
        typeId: widget.parentId);
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
            BlocConsumer<FetchQuizzesCubit, BaseState>(
              listener: (context, state) {
                if (state is Success<QuizzesModel>) {
                  openQuizzes.addAll(state.data.openQuizzes!);
                  lockQuizzes.addAll(state.data.lockQuizzes!);
                }
              },
              builder: (context, state) {
                if (state is Loading) {
                  return const CustomLoading();
                }
                if (state is Success<QuizzesModel>) {
                  return Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:   lockQuizzes.length,
                        itemBuilder: (context, index) {
                          return lockQuizzes.isEmpty
                              ? const Text('لا يوجد اختبارات')
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: Colors.grey, width: 2)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(children: [
                                            const Icon(Icons.quiz),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              lockQuizzes[index]
                                                  .name!,
                                              style:
                                                  const TextStyle(fontSize: 24),
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
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: openQuizzes.length,
                        itemBuilder: (context, index) {
                          return openQuizzes.isEmpty
                              ? const Text('لا يوجد اختبارات')
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: Colors.grey, width: 2)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(children: [
                                            const Icon(Icons.quiz),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              openQuizzes[index]
                                                  .name!,
                                              style:
                                                  const TextStyle(fontSize: 24),
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
                    ],
                  );
                }
                return Container();
              },
            ),
            GestureDetector(
              onTap: () {
                quizDialog(context, (quiz, isOpen) {
                  if (isOpen) {
                    openQuizzes.add(quiz);
                  } else {
                    lockQuizzes.add(quiz);
                  }
                  setState(() {});
                }, null, widget.parentId, widget.type);
              },
              child: const Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('+'),
                ),
              ),
            )
          ],
        ));
  }
}
