import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';
import 'package:lms_admin/features/home/data/models/categories_model/categories_model.dart';
import 'package:lms_admin/features/home/data/models/categories_model/category.dart';
import 'package:lms_admin/features/home/presentation/manager/categories_cubits/fetch_category_cubit.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/categories/categories_functions/category_dialog.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/categories/categories_widgets/categoies_item.dart';

// class CategoriesList extends StatefulWidget {
//   // final Function(String) onItemTap;
//   const CategoriesList({
//     super.key,
//     // required this.onItemTap,
//   });

//   @override
//   State<CategoriesList> createState() => _CategoriesListState();
// }

// class _CategoriesListState extends State<CategoriesList> {
//   final TextEditingController controller = TextEditingController();
//   FilePickerResult? file;

//   late List<Categoryy>? categories;

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     context.read<FetchCategoriesCubit>().fetch();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: Column(
//         children: [
//           BlocConsumer<FetchCategoriesCubit, BaseState>(
//             listener: (context, state) {
//               if (state is Success<CategoriesModel>) {
//                 categories = state.data.categories;
//               }
//             },
//             builder: (context, state) {
//               if (state is Loading) {
//                 return const CustomLoading();
//               }
//               if (state is Success<CategoriesModel>) {
//                 return SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(children: [
//                     ...categories!
//                         .asMap()
//                         .map(
//                           (index, e) => MapEntry(
//                               index,
//                               CategoiesItem(
//                                 categoryId: e.id!,
//                                   categoryy: e,
//                                   onDelete: deleteCategory,
//                                   onUpdate: (e) {
//                                     updateCategory(e, index);
//                                   })),
//                         )
//                         .values,
//                     addCategoryItem(context)
//                   ]),
//                 );
//               }

//               return Container();
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Center addCategoryItem(BuildContext context) {
//     return Center(
//       child: GestureDetector(
//         onTap: () {
//           categoryDialog(context, (category) {
//             categories!.add(category);
//             setState(() {});
//           }, null);
//         },
//         child: const Text('add item'),
//       ),
//     );
//   }

//   void deleteCategory(category) {
//     final index =
//         categories!.indexWhere((element) => element.id == category.id);
//     categories!.remove(categories![index]);
//     setState(() {});
//   }

//   void updateCategory(Categoryy category, int index) {
//     categories![index] = category;
//     setState(() {});
//   }
// }

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  final TextEditingController controller = TextEditingController();
  FilePickerResult? file;
  late List<Categoryy>? categories;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<FetchCategoriesCubit>().fetch();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          BlocConsumer<FetchCategoriesCubit, BaseState>(
            listener: (context, state) {
              if (state is Success<CategoriesModel>) {
                categories = state.data.categories;
              }
            },
            builder: (context, state) {
              if (state is Loading) {
                return const CustomLoading();
              }
              if (state is Success<CategoriesModel>) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      childAspectRatio: 6 / 7,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: categories!.length + 1,
                    itemBuilder: (context, index) {
                      if (index < categories!.length) {
                        return CategoriesItem(
                          categoryId: categories![index].id!,
                          categoryy: categories![index],
                          onDelete: deleteCategory,
                          onUpdate: (e) {
                            updateCategory(e, index);
                          },
                        );
                      } else {
                        return addCategoryItem(context);
                      }
                    },
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  Widget addCategoryItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        categoryDialog(context, (category) {
          categories!.add(category);
          setState(() {});
        }, null);
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
    );
  }

  void deleteCategory(Categoryy category) {
    final index =
        categories!.indexWhere((element) => element.id == category.id);
    categories!.removeAt(index);
    setState(() {});
  }

  void updateCategory(Categoryy category, int index) {
    categories![index] = category;
    setState(() {});
  }
}
