import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/core/utils/functions/custom_toast.dart';
import 'package:lms_admin/core/utils/functions/image_picker.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/lesson.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/unit.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/unit_data.dart';
import 'package:lms_admin/features/subject_data/presentation/manager/post_lesson_cubit.dart';
import 'package:lms_admin/features/subject_data/presentation/manager/post_unit_cubit.dart';

class UnitNewLessonItem extends StatefulWidget {
  final String unitId;
  final void Function(Lesson lesson) onAdd;
  const UnitNewLessonItem({
    super.key,
    required this.onAdd,
    required this.unitId,
  });

  @override
  State<UnitNewLessonItem> createState() => _UnitNewLessonItemState();
}

class _UnitNewLessonItemState extends State<UnitNewLessonItem> {
  final controller = TextEditingController();
  FilePickerResult? image;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            child: BlocConsumer<PostLessonCubit, BaseState>(
          listener: (context, state) {
            if (state is Failure) {
              customToast(context, state.errorMessage);
            } else if (state is Success<Lesson>) {
              customToast(context, 'Successfully added');
              widget.onAdd(state.data);
              image = null;
              controller.clear();
            }
          },
          builder: (context, state) {
            if (state is Loading) {
              return const CustomLoading();
            }
            return ListTile(
              leading: GestureDetector(
                onTap: () async {
                  image = await imagePicker();
                  if (image != null) {
                    setState(() {});
                  }
                },
                child: image == null
                    ? Icon(Icons.attach_file_rounded)
                    : SizedBox(
                        height: 200,
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.memory(image!.files.single.bytes!),
                        ),
                      ),
              ),
              title: Form(child: FormField(
                builder: (field) {
                  return TextFormField(
                    controller: controller,
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  );
                },
              )),
              trailing: InkWell(
                  onTap: () {
                    if (controller.text.isEmpty || image == null) {
                      return;
                    }

                    BlocProvider.of<PostLessonCubit>(context).post(
                        lesson: Lesson(
                            description: 'des',
                            name: controller.text,
                            image: image?.files.single.bytes!,
                            unitId: widget.unitId.toString(),
                            price: '4'));
                  },
                  child: const Icon(Icons.add,
                      color: Color.fromARGB(255, 0, 0, 0))),
            );
          },
        )));
  }
}
