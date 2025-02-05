import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/core/cubits/directory_cubit/directory_cubit.dart';
import 'package:lms_admin/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_admin/core/enums/types_enum.dart';
import 'package:lms_admin/core/utils/service_locator.dart';
import 'package:lms_admin/core/widgets/custom_error.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/subject.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/home_view_body_header.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/unit.dart';
import 'package:lms_admin/features/subject_data/presentation/manager/units_cubit.dart';
import 'package:lms_admin/features/subject_data/presentation/views/widgets/files_list_view.dart';
import 'package:lms_admin/features/subject_data/presentation/views/widgets/quizzes_list_view.dart';
import 'package:lms_admin/features/subject_data/presentation/views/widgets/units_list_view.dart';

import 'header_image.dart';

class SubjectDataViewBody extends StatefulWidget {
  final Subject subject;

  const SubjectDataViewBody({super.key, required this.subject});

  @override
  State<SubjectDataViewBody> createState() => _SubjectDataViewBodyState();
}

class _SubjectDataViewBodyState extends State<SubjectDataViewBody>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final SharedPreferencesCubit sharedPreferencesCubit =
      getIt<SharedPreferencesCubit>();
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(_handleTabSelection);
    BlocProvider.of<UnitsCubit>(context)
        .fetchUnits(subjectId: widget.subject.id.toString());
  }

  void _handleTabSelection() {
    if (tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    tabController.removeListener(_handleTabSelection);
  }

  final dir = getIt<DirectoryCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitsCubit, BaseState>(
      builder: (context, state) {
        if (state is Loading) {
          return const CustomLoading();
        }
        if (state is Failure) {
          return CustomError(errMessage: state.errorMessage);
        }
        if (state is Success<Unitt>) {
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
                        children: [
                          const HeaderImage(
                            imageUrl: '', //TODO add an actual image
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16, left: 16, right: 16, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  // textAlign: TextAlign.center,
                                  widget.subject.name!,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                // const Spacer(),
                              ],
                            ),
                          ),
                          Container(
                            width: 120,
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      tabController.animateTo(0);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: tabController.index == 0
                                              ? Colors.red
                                              : Colors.transparent,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      'Units ',
                                      style: TextStyle(
                                        color: tabController.index == 0
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      tabController.animateTo(1);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: tabController.index == 1
                                              ? Colors.red
                                              : Colors.transparent,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      'Files',
                                      style: TextStyle(
                                        color: tabController.index == 1
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      tabController.animateTo(2);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: tabController.index == 2
                                              ? Colors.red
                                              : Colors.transparent,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      'Quizzez',
                                      style: TextStyle(
                                        color: tabController.index == 2
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        
                        
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          UnitsListView(
                            subjectName: widget.subject.name!,
                            units: state.data,
                            subjectId: widget.subject.id!,
                          ),
                          FilesListView(
                            imageUrl: widget.subject.imageUrl ?? '',
                            files: widget.subject.files!,
                            lessonId: null,
                            subjectId: widget.subject.id,
                          ),
                          QuizzseListView(
                            parentId: widget.subject.id!,
                            subjectId: widget.subject.id!,
                            type: Types.subject.name,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
