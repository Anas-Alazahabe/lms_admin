import 'package:flutter/material.dart';
import 'package:lms_admin/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_admin/core/cubits/token_cubit/token_cubit.dart';
import 'package:lms_admin/core/utils/assets.dart';
import 'package:lms_admin/core/utils/service_locator.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/home_drawer.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/home_view_body_header.dart';

class ProfileDataView extends StatefulWidget {
  const ProfileDataView({super.key});

  @override
  State<ProfileDataView> createState() => _ProfileDataViewState();
}

class _ProfileDataViewState extends State<ProfileDataView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    tabController.removeListener(_handleTabSelection);
  }

  @override
  Widget build(BuildContext context) {
    final savedData = getIt<SharedPreferencesCubit>();
    return Scaffold(
      drawer: HomeDrawer(sharedPreferencesCubit: savedData),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            HomeViewBodyHeader(
              action: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 600,
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            Text('data'),
                            // Column(
                            //   children: [
                            //     Text('sasa'),
                            //   ],
                            // ),
                            // UnitsListView(
                            //   subjectName: widget.subject.name!,
                            //   units: state.data,
                            //   subjectId: widget.subject.id!,
                            // ),

                            // QuizzseListView(
                            //   parentId: widget.subject.id!,
                            //   subjectId: widget.subject.id!,
                            //   type: Types.subject.name,
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        // margin: EdgeInsets.only(top: 100),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 4,
                          child: Container(
                            padding: EdgeInsets.only(top: 100),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.195,
                                  width:
                                      MediaQuery.of(context).size.width * 0.195,
                                  child: ClipRRect(
                                    child: Image.asset(
                                      AssetsData.profile,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Teacher Name',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Teacher Email',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Container(
                                  width: 120,
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            tabController.animateTo(0);
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: tabController.index == 0
                                                    ? Colors.red
                                                    : Colors.transparent,
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                          padding: EdgeInsets.all(16.0),
                                          child: Text(
                                            'Subject ',
                                            style: TextStyle(
                                              color: tabController.index == 0
                                                  ? Colors.red
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            tabController.animateTo(1);
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: tabController.index == 1
                                                    ? Colors.red
                                                    : Colors.transparent,
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                          padding: EdgeInsets.all(16.0),
                                          child: Text(
                                            'Quizzez',
                                            style: TextStyle(
                                              color: tabController.index == 1
                                                  ? Colors.red
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
