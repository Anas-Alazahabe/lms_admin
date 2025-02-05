import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/core/utils/app_router.dart';
import 'package:lms_admin/core/utils/functions/custom_toast.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';
import 'package:lms_admin/features/home/data/models/users_model/users_model.dart';
import 'package:lms_admin/features/home/presentation/manager/add_user_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/delete_user_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/fetch_users_cubit.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/add_users_dialog.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/students_mange_view.dart';
import 'package:number_pagination/number_pagination.dart';

class Employee {
  final String name;
  final String roleId;
  final String email;
  final String id;

  Employee(
      {required this.name,
      required this.roleId,
      required this.email,
      required this.id});
}

class RolesManageView extends StatefulWidget {
  // final List<String> data;
  // final String title;

  const RolesManageView({super.key
      // ,required this.data, required this.title

      });

  @override
  _RolesManageViewState createState() => _RolesManageViewState();
}

class _RolesManageViewState extends State<RolesManageView> {
  @override
  void initState() {
    BlocProvider.of<FetchUsers>(context).fetchUser();
    super.initState();
  }

  List<Employee> employees = [];
  int currentPage = 1;
  int itemsPerPage = 6;
  int totalPages = 0;
  List<Employee> paginatedEmployees = [];

  void paginateEmployees() {
    paginatedEmployees = employees
        .skip((currentPage - 1) * itemsPerPage)
        .take(itemsPerPage)
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchUsers, BaseState>(
      listener: (context, state) {
        if (state is Success<UsersModel>) {
          employees = [];
          for (var element in state.data.data!) {
            if(element.roleId!='student'&&element.email!='deleted_user@example.com'){
            employees.add(
              Employee(
                  name: element.name!,
                  roleId: element.roleId!,
                  email: element.email!,
                  id: element.id.toString()),
            );
            }
          }
          totalPages = (employees.length / itemsPerPage).ceil();
          paginateEmployees(); // Paginate employees after data is received
        }
      },
      builder: (context, state) {
        if (state is Loading) {
          return const CustomLoading();
        }
        if (state is Success<UsersModel>) {
          return BlocListener<DeleteUserCubit, BaseState>(
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
                          DataColumn(label: Text('Role')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('Actions')),
                        ],
                        rows: paginatedEmployees.map((employee) {
                          return DataRow(
                            cells: [
                              DataCell(GestureDetector(
                                  onTap: () {
                                    context.push(AppRouter.kProfileDataView);
                                  },
                                  child: Text(employee.name))),
                              DataCell(Text(employee.roleId)),
                              DataCell(Text(employee.email)),
                              DataCell(IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  BlocProvider.of<DeleteUserCubit>(context)
                                      .deleteUser(userId: employee.id);
                                },
                              )),
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
                        paginateEmployees(); // Update pagination when page changes
                      });
                    },
                    threshold:
                        4, // Controls the number of pages to show before "..." appears
                  ),
                ],
              ));
        }
        return Container();
      },
    );
  }
}

class RolesManageTabs extends StatelessWidget {
  const RolesManageTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 400,
                  child: TabBar(
                    labelColor: Colors.black,
                    indicatorColor: kAppColor,
                    tabs: [
                      Tab(
                        text: 'Users',
                      ),
                      Tab(text: 'students'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: ElevatedButton(
                      onPressed: () {
                        addUsersDialog(context);
                      },
                      child: const Icon(Icons.add)),
                )
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  RolesManageView(),
                  StudentsManageView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
