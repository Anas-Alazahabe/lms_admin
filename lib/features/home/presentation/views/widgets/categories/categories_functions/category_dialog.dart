import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/core/utils/functions/image_picker.dart';
import 'package:lms_admin/core/utils/service_locator.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';
import 'package:lms_admin/core/widgets/custom_network_image.dart';
import 'package:lms_admin/features/home/data/models/categories_model/categories_model.dart';
import 'package:lms_admin/features/home/data/models/categories_model/category.dart';
import 'package:lms_admin/features/home/data/repos/categorise_repo/categories_repo_impl.dart';
import 'package:lms_admin/features/home/presentation/manager/categories_cubits/post_category_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/categories_cubits/update_category_cubit.dart';
import 'package:flutter/services.dart';

Future<dynamic> categoryDialog(BuildContext context,
    void Function(Categoryy) successfulAdding, Categoryy? categoryy) {
  FilePickerResult? image;
  TextEditingController title =
      TextEditingController(text: categoryy?.category);

  return showDialog(
    context: context,
    builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PostCategoryCubit(getIt<CategoriesRepoImpl>()),
          ),
          BlocProvider(
            create: (context) =>
                UpdateCategoryCubit(getIt<CategoriesRepoImpl>()),
          ),
        ],
        child: StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Dialog(
              child: Container(
                width: 600,
                height: 600,
                padding: EdgeInsets.only(top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        'Add Category',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Divider(
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
                          setState(() {});
                        }
                      },
                      child: categoryy == null && image == null
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
                                            style:
                                                TextStyle(color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )

                          // const Text('item')
                          : Center(
                              child: Container(
                                height: 200,
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: categoryy != null && image == null
                                      ? CustomNetworkImage(
                                          url:
                                              '$kBaseUrlAsset${categoryy.imageUrl}')
                                      : Image.memory(
                                          image!.files.single.bytes!),
                                ),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 33.0),
                      child: Text(
                        'Category Name',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Category Name',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: kAppColor)),
                          // enabledBorder: OutlineInputBorder(
                          //   borderSide: BorderSide(
                          //     color:
                          //         kAppColor, // Set the color for the enabled state
                          //   ),
                          // ),
                        ),
                        controller: title,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: ElevatedButton(
                              onPressed: () async {
                                if (categoryy != null) {
                                  BlocProvider.of<UpdateCategoryCubit>(context)
                                      .updateCategory(
                                          categoryy: Categoryy(
                                    category: categoryy.category,
                                    image: image?.files.single.bytes!,
                                    newName: title.text,
                                  ));
                                } else {
                                  BlocProvider.of<PostCategoryCubit>(context)
                                      .post(
                                          categoryy: Categoryy(
                                    category: title.text,
                                    image: image?.files.single.bytes!,
                                  ));
                                }
                              },
                              child: BlocConsumer<BaseCubit, BaseState>(
                                bloc: categoryy != null
                                    ? BlocProvider.of<UpdateCategoryCubit>(
                                        context)
                                    : BlocProvider.of<PostCategoryCubit>(
                                        context),
                                listener: (context, state) {
                                  if (state is Success) {
                                    successfulAdding(
                                        (state.data as CategoriesModel)
                                            .singleCategory!);
                                    if (context.mounted) {
                                      context.pop();
                                    }
                                  }
                                },
                                builder: (context, state) {
                                  if (state is Loading) {
                                    return const CustomLoading();
                                  }
                                  if (state is Success) {
                                    return const Text('done');
                                  }
                                  return Text(
                                      // textAlign: TextAlign.center,
                                      categoryy == null
                                          ? 'add category'
                                          : 'update');
                                },
                              )),
                        ),
                        SizedBox(
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
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

// Custom DottedBorder widget
class DottedBorder extends StatelessWidget {
  final Widget child;
  final Color color;
  final double strokeWidth;
  final List<double> dashPattern;
  final BorderType borderType;
  final Radius radius;

  const DottedBorder({
    required this.child,
    required this.color,
    required this.strokeWidth,
    required this.dashPattern,
    required this.borderType,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius.x),
      child: Stack(
        children: [
          CustomPaint(
            size: Size(double.infinity, double.infinity),
            painter: _DottedBorderPainter(
              color: color,
              strokeWidth: strokeWidth,
              dashPattern: dashPattern,
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _DottedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final List<double> dashPattern;

  _DottedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashPattern,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(4),
      ));

    final PathMetrics pathMetrics = path.computeMetrics();
    for (final PathMetric pathMetric in pathMetrics) {
      final double length = pathMetric.length;
      double distance = 0.0;

      while (distance < length) {
        for (final double dash in dashPattern) {
          final double segmentLength = dash;
          final bool draw = dash == dashPattern.first;
          if (draw) {
            canvas.drawPath(
              pathMetric.extractPath(distance, distance + segmentLength),
              paint,
            );
          }
          distance += segmentLength;
          if (distance > length) break;
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

enum BorderType {
  Rect,
  RRect,
  Oval,
  Circle,
}
