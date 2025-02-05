import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/utils/app_router.dart';
import 'package:lms_admin/features/auth/data/models/user_model/user.dart';
import 'package:lms_admin/features/home/presentation/views/ads_view.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/roles_manage_view.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/sub.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/subjects/subjects_widgets/subjects_list.dart';
import 'package:navigation_tool/navigation_tool.dart';
import 'package:path/path.dart';

import 'ads/ads_widgets/home_ads.dart';
import 'categories/categories_widgets/categories_list.dart';
import 'home_view_body_header.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({
    super.key,
    // required this.rand,
    // required this.screenHeight,
    // required this.gradeId,
    // required this.isads,
    required this.action,
  });
  final VoidCallback action;

  // final String gradeId;
  // final int rand;
  // final double screenHeight;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  /// List of the tabs
  /// bool isads=false;
  ///
  ///

  final List<Widget> tabs = [
    AddsAndCategoryesItems(),
    RolesManageTabs(),
    // const Text('Tab3'),
    // const Text('Tab4'),
  ];

  /// List of the navigation icons / provide any widgets
  final List<Widget> navigationIcons = [
    const Icon(Icons.home),
    const Icon(Icons.person),
    // const Icon(Icons.settings),
    // const Icon(Icons.ac_unit),
  ];

  /// List of NavigationRail label / provide list of any widgets
  final List<Widget> labelNavRail = [
    const Text(
      'one',
      style: TextStyle(color: Colors.black),
    ),
    const Text('two'),
    // const Text('three'),
    // const Text('four'),
  ];

  @override
  Widget build(BuildContext context) {
    // bool isads = false;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        HomeViewBodyHeader(
          // rand: widget.rand,
          action: widget.action,
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: NavigationTool(
                    indicatorColorNavRail:
                        const Color.fromARGB(255, 251, 252, 254),

                    // insidePaddingNavRail: EdgeInsets.all(80),
                    // indicatorColorNavRail: const Color.fromARGB(255, 179, 211, 221),
                    navigationTabs: tabs,
                    navigationIcons: navigationIcons,
                    labelsNavRail: labelNavRail),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AddsAndCategoryesItems extends StatelessWidget {
  // final VoidCallback onItemTap;
  // bool isAdsPressed;
  AddsAndCategoryesItems({
    super.key,
    // required this.isAdsPressed,
    // required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<User>(kUser);
    return Row(
      children: [
        Expanded(
          flex: 3, // This determines the width ratio, adjust as needed
          child: CustomScrollView(
            slivers: <Widget>[
              //image to go ads
              SliverToBoxAdapter(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background image
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: AssetImage(
                              'assets/images/homeview.png'), // Replace with your image asset path
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Overlay text
                    const Positioned(
                      bottom: 120, // Position above the button
                      left: 150,
                      right: 20,
                      child: Text(
                        'Click the button below\nto view existing ads',
                        textAlign: TextAlign.left, // Align text to the left
                        style: TextStyle(
                          color: Color.fromARGB(255, 58, 54, 54),
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          // backgroundColor: Colors.black54, // Optional: Background color for text for readability
                        ),
                      ),
                    ),
                    // Overlay button
                    Positioned(
                      bottom: 60,
                      left: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          // isAdsPressed = true;

                          context.push(AppRouter.kAdsView);

                          // Navigate to the ads page or perform some action
                        },
                        child: const Text('View Ads'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 15,
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    'Explore Your Categories',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: kTextCollor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),

              const CategoriesList(),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16.0, bottom: 16.0, right: 16.0),
            child: Stack(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 4,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(
                              'assets/images/profile.png'), // Replace with your image asset
                        ),
                        const SizedBox(height: 16),
                        Text(
                          box.values.first.name!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          box.values.first.email!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          box.values.first.birthDate!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom:
                      20, // Adjust the value as needed to position the image
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/homeimage.png', // Replace with your image asset
                    // width: 400, // Adjust the size as needed
                    height: 180,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Profile extends StatelessWidget {
  // final VoidCallback onItemTap;
  const Profile({
    super.key,
    // required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        Column(
          children: [
            Container(
              color: kAppColor,
            ),
          ],
        ),
      ],
    );
  }
}
