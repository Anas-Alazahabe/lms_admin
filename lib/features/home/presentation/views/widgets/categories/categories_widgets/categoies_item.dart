import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/core/utils/app_router.dart';
import 'package:lms_admin/core/utils/service_locator.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';
import 'package:lms_admin/core/widgets/custom_network_image.dart';
import 'package:lms_admin/features/home/data/models/categories_model/category.dart';
import 'package:lms_admin/features/home/data/repos/categorise_repo/categories_repo_impl.dart';
import 'package:lms_admin/features/home/presentation/manager/categories_cubits/delete_category_cubit.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/categories/categories_functions/category_dialog.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/sub.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/subjects/subjects_widgets/subjects_list.dart';

// class CategoiesItem extends StatelessWidget {
//   // final VoidCallback onItemTap;
//   // final Function(String) onItemTap;
//   final int? categoryId;
//   final Categoryy categoryy;
//   final void Function(Categoryy) onDelete;
//   final void Function(Categoryy) onUpdate;
//   const CategoiesItem({
//     super.key,
//     required this.categoryy,
//     required this.onDelete, required this.onUpdate,
//     required this.categoryId
//     // required this.onItemTap
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => DeleteCategoryCubit(getIt<CategoriesRepoImpl>()),
//       child: GestureDetector(
//         onTap: (){

//           categoryId==1?
//           context.push(AppRouter.kSubjectViewCatEdu, extra: categoryId)

//           // Navigator.push(
//           //         context,
//           //         MaterialPageRoute(builder: (context) => Center(child: const Text('center'))),
//           //       )

//                 :
//           context.push(AppRouter.kSubjectView,
//           extra: {'categoryId': categoryId , 'yearId':0}
//           //  extra: categoryId
//            );
//            print(categoryy.id);
//         },
//         child: Card(
//           child:

//             Column(
//               children: [
//                 Row(
//                   children: [
//                     Text(categoryy.category!),
//                     BlocConsumer<DeleteCategoryCubit, BaseState>(
//                       listener: (context, state) {
//                         if (state is Success) {
//                           onDelete(categoryy);
//                         }
//                       },
//                       builder: (context, state) {
//                         if (state is Loading) {
//                           return const CustomLoading();
//                         }
//                         return IconButton(
//                             onPressed: () {
//                               BlocProvider.of<DeleteCategoryCubit>(context)
//                                   .delete(name: categoryy.category!);
//                             },
//                             icon: const Icon(Icons.delete));
//                       },
//                     ),
//                    IconButton(
//                             onPressed: () {
//                         categoryDialog(context, (editedCategory) {
//                           onUpdate(editedCategory);
//                         }, categoryy);
//                       },
//                             icon: const Icon(Icons.edit)

//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 100,
//                   child: AspectRatio(
//                       aspectRatio: 16 / 9,
//                       child: CustomNetworkImage(
//                           url: '$kBaseUrlAsset${categoryy.imageUrl}')),
//                 )
//               ],
//             ),

//         ),
//       ),
//     );
//   }
// }

class CategoriesItem extends StatelessWidget {
  final int? categoryId;
  final Categoryy categoryy;
  final void Function(Categoryy) onDelete;
  final void Function(Categoryy) onUpdate;

  const CategoriesItem({
    super.key,
    required this.categoryy,
    required this.onDelete,
    required this.onUpdate,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteCategoryCubit(getIt<CategoriesRepoImpl>()),
      child: GestureDetector(
        onTap: () {
          categoryId == 1
              ? context.push(AppRouter.kSubjectViewCatEdu, extra: {
                  'categoryId': categoryId,
                  'category': categoryy,
                })
              : context.push(AppRouter.kSubjectView, extra: {
                  'categoryId': categoryId,
                  'yearId': 0,
                  'category': categoryy,
                });
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.category,
                      size: 30,
                      color: kAppColor,
                    ), // Replace with actual icons
                    SizedBox(height: 5),
                    Text(
                      categoryy.category!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                // Spacer(),

                // SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocConsumer<DeleteCategoryCubit, BaseState>(
                      listener: (context, state) {
                        if (state is Success) {
                          onDelete(categoryy);
                        }
                      },
                      builder: (context, state) {
                        if (state is Loading) {
                          return const CustomLoading();
                        }
                        return IconButton(
                            onPressed: () {
                              BlocProvider.of<DeleteCategoryCubit>(context)
                                  .delete(name: categoryy.id!.toString());
                            },
                            icon: const Icon(Icons.delete));
                      },
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     BlocProvider.of<DeleteCategoryCubit>(context)
                    //         .delete(name: categoryy.category!);
                    //   },
                    //   icon: const Icon(Icons.delete, size: 20),
                    // ),
                    IconButton(
                      onPressed: () {
                        categoryDialog(context, (editedCategory) {
                          onUpdate(editedCategory);
                        }, categoryy);
                      },
                      icon: const Icon(Icons.edit, size: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
