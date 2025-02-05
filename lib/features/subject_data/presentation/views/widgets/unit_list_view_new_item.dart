import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/core/utils/app_router.dart';
import 'package:lms_admin/core/utils/functions/custom_toast.dart';
import 'package:lms_admin/core/utils/functions/image_picker.dart';
import 'package:lms_admin/core/widgets/custom_error.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';
import 'package:lms_admin/core/widgets/custom_network_image.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/unit.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/unit_data.dart';
import 'package:lms_admin/features/subject_data/presentation/manager/post_unit_cubit.dart';

class UnitListViewNewItem extends StatefulWidget {
  final String subjectId;
  final void Function(UnitData units) onAdd;
  const UnitListViewNewItem({
    super.key,
    required this.onAdd,
    required this.subjectId,
  });

  @override
  State<UnitListViewNewItem> createState() => _UnitListViewNewItemState();
}

class _UnitListViewNewItemState extends State<UnitListViewNewItem> {
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
            child: BlocConsumer<PostUnitCubit, BaseState>(
          listener: (context, state) {
            if (state is Failure) {
              customToast(context, state.errorMessage);
            } else if (state is Success<Unitt>) {
              customToast(context, 'Successfully added');
              widget.onAdd(state.data.singleData!);
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

                    BlocProvider.of<PostUnitCubit>(context).post(
                        unit: UnitData(
                            description: 'des',
                            name: controller.text,
                            image: image?.files.single.bytes!,
                            subjectId: widget.subjectId.toString()));
                  },
                  child: const Icon(Icons.add,
                      color: Color.fromARGB(255, 0, 0, 0))),
            );
          },
        )));
  }
}
