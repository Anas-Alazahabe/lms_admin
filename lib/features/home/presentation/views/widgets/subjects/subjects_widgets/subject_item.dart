import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/core/utils/app_router.dart';
import 'package:lms_admin/core/utils/functions/custom_toast.dart';
import 'package:lms_admin/core/utils/service_locator.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';
import 'package:lms_admin/core/widgets/custom_network_image.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/subject.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/subjects_model.dart';
import 'package:lms_admin/features/home/data/repos/subjects_repo/subjects_repo_impl.dart';
import 'package:lms_admin/features/home/presentation/manager/subjects_cubits/delete_subject_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/subjects_cubits/update_subject_cubit.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/subjects/subjects_finctions/subject_dialog.dart';
// import 'package:lms_admin/features/home/data/models/categories_model/category.dart';
// import 'package:lms_admin/features/home/data/repos/categorise_repo/categories_repo_impl.dart';
// import 'package:lms_admin/features/home/presentation/manager/categories_cubits/delete_category_cubit.dart';
// import 'package:lms_admin/features/home/presentation/views/widgets/categories/categories_functions/category_dialog.dart';

class SubjectItem extends StatefulWidget {
  final int? yearId;
  final int? categoryId;
  final Subject subject;
  final void Function() onDelete;
  final void Function(Subject) onUpdate;
  const SubjectItem({
    super.key,
    required this.subject,
    required this.categoryId,
    required this.yearId,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  State<SubjectItem> createState() => _SubjectItemState();
}

class _SubjectItemState extends State<SubjectItem> {
  bool _isHovering = false;

  void _onHover(bool isHovering) {
    setState(() {
      _isHovering = isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRouter.kSubjectDataView, extra: widget.subject);
      },
      child: MouseRegion(
        onEnter: (_) => _onHover(true),
        onExit: (_) => _onHover(false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 300,
          height: _isHovering ? 270 : 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                  child:
                      // CustomNetworkImage(
                      //     url: '$kBaseUrlAsset${widget.ad.imageUrl}')
                      Image.asset(
                    'assets/images/adimage.png',
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 160,
                left: 20,
                right: 20,
                child: Text(
                  widget.subject.name!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                top: 190,
                left: 20,
                right: 20,
                child: AnimatedOpacity(
                  opacity: _isHovering ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Column(
                    children: [
                      // Text(
                      //   widget.ad.description!,
                      //   style: const TextStyle(
                      //     color: Colors.grey,
                      //   ),
                      // ),

                      // const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // TextButton(onPressed: () {}, child: Icon(Icons.delete)),

                          BlocListener<UpdateSubjectCubit, BaseState>(
                            listener: (context, state) {
                                if (state is Failure) {
                                customToast(context, state.errorMessage);
                              }
                              if (state is Success<SubjectsModel>) {
                                customToast(context, 'edited');
                                widget.onUpdate(state.data.singleSubject!);
                              }
                            },
                            child: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                subjectDialog(
                                  context,
                                  (editedCategory) {
                                    // onUpdate(editedCategory);
                                  },
                                  widget.subject,
                                  widget.categoryId,

                                  // yearId
                                );
                              },
                            ),
                          ),

                          BlocListener<DeleteSubjectCubit, BaseState>(
                            listener: (context, state) {
                              if (state is Failure) {
                                customToast(context, state.errorMessage);
                              }
                              if (state is Success<String>) {
                                customToast(context, state.data);
                                widget.onDelete();
                              }
                            },
                            child: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                BlocProvider.of<DeleteSubjectCubit>(context)
                                    .delete(id: widget.subject.id!);
                              },
                            ),
                          ),

                          // TextButton(
                          //     onPressed: () {
                          //       adDialog(context, (editedAd) {
                          //         widget.onUpdateAd(editedAd);
                          //       }, widget.ad);
                          //     },
                          //     child: Icon(Icons.edit)),
                          // TextButton(onPressed: () {}, child: Icon(Icons.timer)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 15,
                left: 20,
                right: 20,
                child: AnimatedOpacity(
                  opacity: !_isHovering ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: const Column(
                    children: [
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('View More'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
