import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_admin/core/cubits/token_cubit/token_cubit.dart';
import 'package:lms_admin/core/utils/app_router.dart';
import 'package:lms_admin/core/utils/service_locator.dart';
import 'package:lms_admin/core/widgets/custom_network_image.dart';
import 'package:lms_admin/features/home/data/models/categories_model/category.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/home_drawer.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/home_view_body_header.dart';
import 'package:number_pagination/number_pagination.dart';

List<int?> years = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
// Map<int, String> years = {
//   1: '1st',
//   2: '2rd',
//   3: '3rd',
//   4: '4th',
//   5: '5th',
//   6: '6th',
//   7: '1st-mid',
//   8: '2nd-mid',
//   9: '3rd-mid',
//   10: '1st-sci',
//   11: '2nd-sci',
//   12: '3rd-sci',
//   13: '1st-lit',
//   14: '2nd-lit',
//   15: '3rd-lit'
// };

List<String> yearsName = [
  '1st',
  '2rd',
  '3rd',
  '4th',
  '5th',
  '6th',
  '1st-mid',
  '2nd-mid',
  '3rd-mid',
  '1st-sci',
  '2nd-sci',
  '3rd-sci',
  '1st-lit',
  '2nd-lit',
  '3rd-lit'
];

class YearsList extends StatefulWidget {
  final Categoryy categoryy;
  final int? categoryId;
  const YearsList(
      {super.key, required this.categoryId, required this.categoryy});

  @override
  State<YearsList> createState() => _YearsListState();
}

int currentPage = 1;

int itemsPerPage = 6;

class _YearsListState extends State<YearsList> {
  @override
  Widget build(BuildContext context) {
    int totalPages = (years.length / itemsPerPage).ceil();
    // Map<int, String> paginatedYearsMap = Map.fromEntries(
    //   years.entries.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage),
    // );
    List<int?> paginatedyears = years
        .skip((currentPage - 1) * itemsPerPage)
        .take(itemsPerPage)
        .toList();

    List<String> paginatedyearsName = yearsName
        .skip((currentPage - 1) * itemsPerPage)
        .take(itemsPerPage)
        .toList();
    final token = getIt<TokenCubit>();
    final savedData = getIt<SharedPreferencesCubit>();
    return Scaffold(
      drawer: HomeDrawer(sharedPreferencesCubit: savedData),
      backgroundColor: Color(0xFFF2F8FC),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: 40,
                            right: MediaQuery.of(context).size.width / 10,
                            left: MediaQuery.of(context).size.width / 10),
                        height: MediaQuery.of(context).size.height / 3.5,
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: paginatedyears.length,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150,
                            childAspectRatio: 6 / 7,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                context.push(AppRouter.kSubjectView, extra: {
                                  'categoryId': widget.categoryId,
                                  'yearId': paginatedyears[index],
                                  'category': widget.categoryy
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        children: [
                                          const Icon(
                                            Icons.cake,
                                            size: 30,
                                            color: kAppColor,
                                          ), // Replace with actual icons
                                          const SizedBox(height: 5),
                                          Text(
                                            paginatedyearsName[index]
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );

                            // Column(
                            //   children: [
                            //     Text(
                            //       paginatedyears[index].toString(),
                            //       style: TextStyle(fontSize: 18),
                            //     ),
                            //   ],
                            // );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: NumberPagination(
                          pageTotal: totalPages,
                          pageInit: currentPage,
                          onPageChanged: (int page) {
                            setState(() {
                              currentPage = page;
                            });
                          },
                          threshold:
                              4, // Controls the number of pages to show before "..." appears
                        ),
                      ),
                    ],
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.195,
                                    width: MediaQuery.of(context).size.width *
                                        0.195,
                                    child: ClipRRect(
                                        child: CustomNetworkImage(
                                      url: widget.categoryy.imageUrl.toString(),
                                    )),
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
          ),

          // Pagination
          /*********************************************** */

          // ...years
          //     .asMap()
          //     .map((key, value) => MapEntry(
          //           key,
          //           Row(
          //             children: [
          //               Expanded(
          //                 child: GestureDetector(
          //                   onTap: () {
          //                     context.push(AppRouter.kSubjectView, extra: {
          //                       'categoryId': widget.categoryId,
          //                       'yearId': value,
          //                       'category': widget.categoryy
          //                     });
          //                   },
          //                   child: Card(
          //                     child: Padding(
          //                       padding: const EdgeInsets.all(16.0),
          //                       child: Text('year $value'),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ))
          //     .values,
        ],
      ),
    );
  }
}
