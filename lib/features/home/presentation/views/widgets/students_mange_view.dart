import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/core/utils/functions/custom_toast.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';
import 'package:lms_admin/features/home/data/models/users_model/users_model.dart';
import 'package:lms_admin/features/home/presentation/manager/delete_user_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/fetch_users_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/reset_user_cubit.dart';
import 'package:number_pagination/number_pagination.dart';

class Student {
  final String name;
  final String gender;
  final String email;
  final String id;

  Student({
    required this.name,
    required this.gender,
    required this.email,
    required this.id,
  });
}

class StudentsManageView extends StatefulWidget {
  // final List<String> data;
  // final String title;

  const StudentsManageView({super.key
      // ,required this.data, required this.title

      });

  @override
  _StudentsManageViewState createState() => _StudentsManageViewState();
}

class _StudentsManageViewState extends State<StudentsManageView> {
  // int currentPage = 0;
  // final int itemsPerPage = 4; // Number of cards per page

  @override
  void initState() {
    BlocProvider.of<FetchUsers>(context).fetchUser();
    super.initState();
  }

  List<Student> employees = [];
  int currentPage = 1;
  int itemsPerPage = 6;
  int totalPages = 0;
  List<Student> paginatedEmployees = [];
  void paginateEmployees() {
    paginatedEmployees = employees
        .skip((currentPage - 1) * itemsPerPage)
        .take(itemsPerPage)
        .toList();
    setState(() {});
  }

  // int currentPage = 1;
  // int itemsPerPage = 6;

  @override
  Widget build(BuildContext context) {
    // int totalPages = (widget.data.length / itemsPerPage).ceil();
    // // Get the data for the current page
    // List<String> currentPageData = widget.data
    //     .skip(currentPage * itemsPerPage)
    //     .take(itemsPerPage)
    //     .toList();

    return BlocConsumer<FetchUsers, BaseState>(listener: (context, state) {
      if (state is Success<UsersModel>) {
        employees = [];
        for (var element in state.data.data!) {
          if (element.roleId == 'student') {
            employees.add(
              Student(
                  name: element.name!,
                  gender: element.gender == 0 ? 'Male' : 'Female',
                  email: element.email!,
                  id: element.id.toString()),
            );
          }
        }
        totalPages = (employees.length / itemsPerPage).ceil();
        paginateEmployees(); // Paginate employees after data is received
      }
    }, builder: (context, state) {
      if (state is Loading) {
        return const CustomLoading();
      }
      if (state is Success<UsersModel>) {
        return BlocListener<ResetUserCubit, BaseState>(
          listener: (context, state) {
            if (state is Success<String>) {
                  customToast(context, state.data);
                  BlocProvider.of<FetchUsers>(context).fetchUser();
                }
                if (state is Failure) {
                  customToast(context, state.errorMessage);
                }
          },
          child: BlocListener<DeleteUserCubit, BaseState>(
              listener: (context, state) {
                if (state is Success<String>) {
                  customToast(context, state.data);
                  BlocProvider.of<FetchUsers>(context).fetchUser();
                }
                if (state is Failure) {
                  customToast(context, state.errorMessage);
                }
              },
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Employee Name')),
                          DataColumn(label: Text('Gender')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('Actions')),
                        ],
                        rows: paginatedEmployees.map((employee) {
                          return DataRow(
                            cells: [
                              DataCell(Text(employee.name)),
                              DataCell(Text(employee.gender.toString())),
                              DataCell(Text(employee.email)),
                              DataCell(
                                IconButton(
                                  icon: const Icon(Icons.restart_alt_rounded),
                                  onPressed: () {
                                     BlocProvider.of<ResetUserCubit>(context)
                                      .reset(email: employee.email);
                                  },
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  NumberPagination(
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
                ],
              )),
        );
      }
      return Container();
    });

    // Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     // Display the title
    //     SizedBox(height: 20),
    //     Text(
    //       widget.title,
    //       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    //     ),
    //     Expanded(
    //       child: ListView.builder(
    //         itemCount: currentPageData.length,
    //         itemBuilder: (context, index) {
    //           return Container(
    //             width: 75,
    //             height: 60,
    //             child: Card(
    //               elevation: 0,
    //               shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(10),
    //               ),
    //               margin: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
    //               child: Padding(
    //                 padding: const EdgeInsets.symmetric(
    //                     horizontal: 20.0, vertical: 6),
    //                 child: ListTile(
    //                   title: Text(
    //                     currentPageData[index],
    //                     style: TextStyle(fontSize: 18),
    //                   ),
    //                   trailing: IconButton(
    //                     onPressed: () {},
    //                     icon: Icon(Icons.edit),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           );
    //         },
    //       ),
    //     ),
    //     // Pagination
    //     Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: NumberPagination(
    //         onPageChanged: (int pageNumber) {
    //           setState(() {
    //             currentPage = pageNumber - 1;
    //           });
    //         },
    //         pageTotal: totalPages,
    //         pageInit: currentPage + 1,
    //         colorPrimary: Colors.blue,
    //         colorSub: Colors.grey,
    //       ),
    //     ),
    //   ],
    // );
  }
}
