import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms_admin/core/utils/functions/excel_picker.dart';
import 'package:lms_admin/features/home/presentation/manager/categories_cubits/fetch_category_cubit.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/categories/categories_functions/category_dialog.dart';
import 'package:lms_admin/features/subject_data/data/models/quizzes_model/question.dart';
import 'package:lms_admin/features/subject_data/data/models/quizzes_model/quiz.dart';
import 'package:lms_admin/features/subject_data/data/repo/subject_repo_impl.dart';
import 'package:lms_admin/features/subject_data/presentation/manager/quizzes/post_quizzes_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/core/utils/functions/image_picker.dart';
import 'package:lms_admin/core/utils/service_locator.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';
import 'package:lms_admin/core/widgets/custom_network_image.dart';
import 'package:lms_admin/features/home/data/models/categories_model/categories_model.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/subject.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/subjects_model.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/year.dart';

import 'dart:convert';
import 'dart:io';
import 'package:excel/excel.dart' as exc;
import 'package:flutter/services.dart' show rootBundle;

import 'package:lms_admin/features/home/presentation/manager/categories_cubits/update_category_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/subjects_cubits/update_subject_cubit.dart';

Future<dynamic> quizDialog(
  BuildContext context,
  void Function(Quiz, bool) successfulAdding,
  Quiz? quiz,
  String parentId,
  String parentType,
  // int? categoryId,
) {
  FilePickerResult? excelFile;
  bool isOpen = true;

  TextEditingController name = TextEditingController(text: quiz?.name);
  TextEditingController successMark =
      TextEditingController(text: quiz?.successMark.toString());
  TextEditingController duration =
      TextEditingController(text: quiz?.duration.toString());

  //
  // TextEditingController year =
  // TextEditingController(text: Year[0].yearId.toString());

  return showDialog(
    context: context,
    builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PostQuizCubit(getIt<SubjectRepoImpl>()),
          ),

          // BlocProvider(
          //   create: (context) => UpdateCategoryCubit(getIt<CategoriesRepoImpl>()),
          // ),
        ],
        child: StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Dialog(
              child: Container(
                width: 600,
                height: 600,
                padding: const EdgeInsets.only(top: 30),
                child: SingleChildScrollView(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Text(
                                'Add quiz',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ]),
                      const Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      GestureDetector(
                          onTap: () async {
                            excelFile = await excelPicker();
                            if (excelFile != null) {
                              // String tempPath = (await getTemporaryDirectory()).path;
                              //  String filePath = path.join(tempPath, image!.files.first.name);
                              //     File file = File(filePath);
                              //       await file.writeAsBytes(image!.files.first.bytes!);
                              setState(() {
                                // imagef =file;
                              });
                            }
                          },
                          child: quiz == null && excelFile == null
                              ? Center(
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const DottedBorder(
                                      color: Colors.grey,
                                      strokeWidth: 2,
                                      dashPattern: [6, 3],
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(4),
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.image,
                                                size: 50, color: Colors.grey),
                                            SizedBox(height: 8),
                                            Text("Choose an image",
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Text(
                                  excelFile!.files.single.name,
                                  overflow: TextOverflow.ellipsis,
                                )),
                      const SizedBox(
                        height: 30,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 33.0),
                      //   child: Text(
                      //     'Category Name',
                      //     style: GoogleFonts.poppins(
                      //       textStyle: TextStyle(
                      //           fontSize: 15, fontWeight: FontWeight.w600),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),

                      // const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: 'Quiz Name',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: kAppColor)),
                          ),
                          controller: name,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: 'success mark',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: kAppColor)),
                          ),
                          controller: successMark,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 1),
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: 'duration',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: kAppColor)),
                          ),
                          controller: duration,
                        ),
                      ),
                      // TextField(
                      //   controller: year,
                      // ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('isOpen'),
                          Checkbox(
                              value: isOpen,
                              onChanged: (v) {
                                isOpen = !isOpen;
                                setState(
                                  () {},
                                );
                              }),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                if (quiz != null) {
                                  // BlocProvider.of<UpdateCategoryCubit>(context).updateCategory(
                                  //  categoryy : Categoryy(
                                  //   category: categoryy.category,
                                  //   image: image?.files.single.bytes!,
                                  //    newName: title.text,
                                  //  )
                                  // );

                                  // Println('it\'s not null');
                                } else {
                                  // print('i\'m here');

                                  try {
                                    List<Map<String, dynamic>> questions = [];
                                    if (excelFile != null) {
                                      var bytes = excelFile!.files.first.bytes;
                                      var excel = exc.Excel.decodeBytes(bytes!);

                                      for (var table in excel.tables.keys) {
                                        var sheet = excel.tables[table];
                                        for (var row in sheet!.rows.skip(1)) {
                                          questions.add({
                                            'text': row[0]?.value.toString(),
                                            'mark': row[1]?.value.toString(),
                                            'answers': row[2]
                                                ?.value
                                                .toString()
                                                .split(', '),
                                            'correct_answer':
                                                row[3]?.value.toString(),
                                          });
                                        }
                                      }
                                    }
                                    // String jsonQuestions = jsonEncode(questions);
                                    // print(jsonQuestions);

                                    BlocProvider.of<PostQuizCubit>(context)
                                        .post(
                                            quiz: Quiz(
                                      // categoryId: categoryId.toString(),
                                      name: name.text,
                                      // price:  5 ,
                                      // image: image,
                                      public: true,
                                      successMark: successMark.text,
                                      duration: duration.text,
                                      typeId: parentId,
                                      typeType: parentType,
                                      questions: (questions as List<dynamic>?)
                                          ?.map((e) => Question.fromJson(
                                              e as Map<String, dynamic>))
                                          .toList(),
                                    ));
                                    // print('i\'m here agaaaaaaaaaain');
                                  } on Exception catch (e) {
                                    // print('sdsdsd');
                                    print(e);
                                  }
                                }
                              },
                              child:
                                  //  Text('donnnnne'))

                                  BlocConsumer<BaseCubit, BaseState>(
                                bloc: quiz != null
                                    // ? BlocProvider.of<PostSubjectCubit>(context)
                                    ? BlocProvider.of<PostQuizCubit>(context)
                                    : BlocProvider.of<PostQuizCubit>(context),
                                listener: (context, state) {
                                  if (state is Success<Quiz>) {
                                    successfulAdding((state.data), isOpen);
                                    if (context.mounted) {
                                      context.pop();
                                    }
                                    // print('in listener');
                                  }
                                },
                                builder: (context, state) {
                                  if (state is Loading) {
                                    // print('in loading');
                                    // return const Text('dsdsdsdsdsdsd');
                                    return const CustomLoading();
                                  } else if (state is Success) {
                                    return const Text('done');
                                  }
                                  return Text(quiz == null ? 'add' : 'update');
                                },
                              )),
                          const SizedBox(
                            width: 40,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'cancel',
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
