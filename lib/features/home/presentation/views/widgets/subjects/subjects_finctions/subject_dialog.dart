import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/categories/categories_functions/category_dialog.dart';
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

import 'package:lms_admin/features/home/data/repos/subjects_repo/subjects_repo.dart';
import 'package:lms_admin/features/home/data/repos/subjects_repo/subjects_repo_impl.dart';
import 'package:lms_admin/features/home/presentation/manager/subjects_cubits/fetch_subjecct_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/subjects_cubits/post_subject_cubit.dart';

import 'package:lms_admin/features/home/presentation/manager/categories_cubits/update_category_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/subjects_cubits/update_subject_cubit.dart';

Future<dynamic> subjectDialog(
  BuildContext context,
  void Function(Subject) successfulAdding,
  Subject? subjectt,
  int? categoryId,
  // List<int>? yearId
) {
  FilePickerResult? image;

  TextEditingController title = TextEditingController(text: subjectt?.name);
  TextEditingController price =
      TextEditingController(text: subjectt?.price.toString());
  TextEditingController desc =
      TextEditingController(text: subjectt?.description);
  TextEditingController years = TextEditingController(
      text: convertYearsContentListToString(subjectt?.yearsContent));

  //
  // TextEditingController year =
  // TextEditingController(text: Year[0].yearId.toString());

  return showDialog(
    context: context,
    builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PostSubjectCubit(getIt<SubjectsRepoImpl>()),
          ),
          BlocProvider(
            create: (context) => UpdateSubjectCubit(getIt<SubjectsRepoImpl>()),
          ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          'Add Subject',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      GestureDetector(
                        onTap: () async {
                          image = await imagePicker();
                          if (image != null) {
                            // String tempPath = (await getTemporaryDirectory()).path;
                            //  String filePath = path.join(tempPath, image!.files.first.name);
                            //     File file = File(filePath);
                            //       await file.writeAsBytes(image!.files.first.bytes!);
                            setState(() {
                              // imagef =file;
                            });
                          }
                        },
                        child: subjectt == null && image == null
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
                            : Center(
                                child: SizedBox(
                                  height: 200,
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: subjectt != null && image == null
                                        ? CustomNetworkImage(
                                            url:
                                                '$kBaseUrlAsset${subjectt.imageUrl}')
                                        : Image.memory(
                                            image!.files.single.bytes!),
                                  ),
                                ),
                              ),
                      ),
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
                            labelText: 'Subject Name',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: kAppColor),
                            ),
                          ),
                          controller: title,
                        ),
                      ),

                      const SizedBox(height: 16.0),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: 'price',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: kAppColor)),
                          ),
                          controller: price,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 1),
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: 'decsprition',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: kAppColor)),
                          ),
                          controller: desc,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 1),
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: 'years',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: kAppColor)),
                          ),
                          controller: years,
                        ),
                      ),
                      // TextField(
                      //   controller: year,
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                if (subjectt != null) {
                                  BlocProvider.of<UpdateSubjectCubit>(context)
                                      .update(
                                    subject: Subject(
                                        image: image?.files.single.bytes!,
                                        name: title.text,
                                        price: price.text,
                                        description: desc.text,
                                        id: subjectt.id,
                                        yearsContent:
                                            parseYearsContent(years.text),
                                        categoryId: subjectt.categoryId),
                                  );

                                  // Println('it\'s not null');
                                } else {
                                  // print('i\'m here');

                                  try {
                                    List<YearsContent> yearsContentList =
                                        parseYearsContent(years.text);

                                    BlocProvider.of<PostSubjectCubit>(context)
                                        .post(
                                            subject: Subject(
                                      categoryId: categoryId.toString(),
                                      name: title.text,
                                      price: price.text,
                                      // price:  5 ,
                                      description: desc.text,
                                      // image: image,

                                      image: image?.files.single.bytes!,
                                      videoId: '555',
                                      fileId: '255',
                                      yearsContent: yearsContentList,
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
                                bloc: subjectt != null
                                    // ? BlocProvider.of<PostSubjectCubit>(context)
                                    ? BlocProvider.of<UpdateSubjectCubit>(
                                        context)
                                    : BlocProvider.of<PostSubjectCubit>(
                                        context),
                                listener: (context, state) {
                                  if (state is Success) {
                                  subjectt != null?successfulAdding(
                                        (state.data as SubjectsModel).singleSubject!):   successfulAdding(
                                        (state.data as SubjectsModel).data!);
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
                                  return Text(subjectt == null
                                      ? 'add subject'
                                      : 'update');
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

List<YearsContent> parseYearsContent(String text) {
  List<YearsContent> yearsContentList = [];
  List<String> years = text.split(',');
  if (years.first == '' || text.trim.toString().isEmpty) {
    return [];
  }
  for (String year in years) {
    yearsContentList.add(YearsContent(yearId: int.parse(year.trim())));
  }
  return yearsContentList;
}

String? convertYearsContentListToString(List<YearsContent>? yearsContentList) {
  if (yearsContentList == null) {
    return null;
  }
  return yearsContentList.map((yc) => yc.yearId.toString()).join(', ');
}
