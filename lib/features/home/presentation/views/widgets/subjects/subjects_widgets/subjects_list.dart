import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_admin/core/cubits/token_cubit/token_cubit.dart';
import 'package:lms_admin/core/utils/service_locator.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';
import 'package:lms_admin/core/widgets/custom_network_image.dart';
import 'package:lms_admin/features/home/data/models/categories_model/category.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/fetch_data.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/subject.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/subjects_model.dart';
import 'package:lms_admin/features/home/data/repos/subjects_repo/subjects_repo.dart';
import 'package:lms_admin/features/home/data/repos/subjects_repo/subjects_repo_impl.dart';
import 'package:lms_admin/features/home/presentation/manager/subjects_cubits/fetch_subjecct_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/subjects_cubits/post_subject_cubit.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/home_drawer.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/home_view_body_header.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/subjects/subjects_finctions/subject_dialog.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/subjects/subjects_widgets/subject_item.dart';

class SubjectsList extends StatefulWidget {
  final int? yearId;
  final int? categoryId;
  final Categoryy categoryy;

  const SubjectsList(
      {super.key,
      required this.categoryId,
      required this.yearId,
      required this.categoryy});

  @override
  State<SubjectsList> createState() => _SubjectsListState();
}

class _SubjectsListState extends State<SubjectsList> {
  final TextEditingController controller = TextEditingController();
  FilePickerResult? file;
  late Subject subject;
  late List<dynamic> subjects = <Subject>[];
  late List<Data> subjectss = <Data>[];

  // subjects = [Subject(), Subject()];
  // subjects = <Subject>[];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<FetchSubjectsCubit>().fetch(
          categoryId: widget.categoryId,
          yearId: widget.categoryId == 1 ? widget.yearId! : 0,

          // subject: subject
        );
  }

  @override
  Widget build(BuildContext context) {
    final savedData = getIt<SharedPreferencesCubit>();
    return Scaffold(
      drawer: HomeDrawer(sharedPreferencesCubit: savedData),
      body: Builder(builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeViewBodyHeader(
              action: () {
                Scaffold.of(context).openDrawer();
              },
              // Scaffold.of(context).openDrawer(),
            ),
            // addSubjectItem(context),

            BlocConsumer<FetchSubjectsCubit, BaseState>(
              listener: (context, state) {
                if (state is Success<SubjectsModel>) {
                  subjectss = state.data.dataa!;

                  subjectss
                      .where((data) => data.category!.id == widget.categoryId)
                      .map((data) => subjects = data.subjects!)
                      .toList();
                }
              },
              builder: (context, state) {
                if (state is Loading) {
                  // print('object loading');
                  return const CustomLoading();
                }
                if (state is Success<SubjectsModel>) {
                  return Expanded(
                    child: Row(
                      // mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black54),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      context.pop();
                                    },
                                    child: const Icon(Icons.arrow_back),
                                  ),
                                ),
                                SizedBox(height: 100),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 250,
                                      childAspectRatio: 6 / 7,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                    ),
                                    itemCount: subjects!.length + 1,
                                    itemBuilder: (context, index) {
                                      if (index < subjects!.length) {
                                        return SubjectItem(
                                          subject: subjects[index],
                                          categoryId: widget.categoryId,
                                          yearId: widget.yearId,
                                          // categoryId: categories![index].id!,
                                          // categoryy: categories![index],
                                          onDelete: () {
                                            deleteSubject(subjects[index]);
                                          },
                                          onUpdate: (e) {
                                            updateSubject(e, index);
                                          },
                                        );
                                      } else {
                                        return addSubjectItem(context);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, bottom: 16.0, right: 16.0),
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  // margin: EdgeInsets.only(top: 100),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    elevation: 4,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 100),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.195,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.195,
                                            child: ClipRRect(
                                              child: Image.asset(
                                                'assets/images/catimage.png',
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            widget.categoryy.category!,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          // const SizedBox(height: 8),
                                          // Text(
                                          //   'Birthdate: January 1, 1990',
                                          //   style: TextStyle(
                                          //     fontSize: 16,
                                          //     color: Colors.grey[700],
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom:
                                      20, // Adjust the value as needed to position the image
                                  left: 0,
                                  right: 0,
                                  child: Image.asset(
                                    'assets/images/educater1.png', // Replace with your image asset
                                    // width: 50, // Adjust the size as needed
                                    height: 180,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );

                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(children: [
                  //     ...subjects!
                  //         .asMap()
                  //         .map(
                  //           (index, e) => MapEntry(
                  //           index,

                  //           SubjectItem(
                  //               subject: e,
                  //               categoryId: widget.categoryId,
                  //               yearId: widget.yearId,

                  //               onDelete: deleteSubject,
                  //               onUpdate: (e) {
                  //                 updateSubject(e, index);
                  //               }

                  //               )
                  //           ),

                  //     )
                  //         .values,

                  //     // addSubjectItem(context)
                  //   ]

                  //   ),

                  // )
                }

                return Container();
              },
            ),
          ],
        );
      }),
    );
  }

  Center addSubjectItem(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          subjectDialog(
            context,
            (subject) {
              subjects!.add(subject);

              setState(() {});
            },
            null,
            widget.categoryId,
            //  ,widget.yearId
          );
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              size: 30,
              color: kAppColor,
            ),
          ),
        ),
      ),
    );
  }

  void deleteSubject(subject) {
    final index = subjects.indexWhere((element) => element.id == subject.id);
    subjects.remove(subjects[index]);
    setState(() {});
  }

  void updateSubject(Subject subject, int index) {
    subjects[index] = subject;
    setState(() {});
  }
}
