import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms_admin/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_admin/core/cubits/token_cubit/token_cubit.dart';
import 'package:lms_admin/core/utils/assets.dart';
import 'package:lms_admin/core/utils/service_locator.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/subjects/subjects_widgets/subjects_list.dart';
import 'package:lms_admin/constants.dart';
import 'widgets/home_drawer.dart';
import 'widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  // final String? gradeId;
  const HomeView({
    super.key,
    //  required this.gradeId
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final token = getIt<TokenCubit>();
  final savedData = getIt<SharedPreferencesCubit>();

  bool splash = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          splash = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    // final rand = Random().nextInt(34);
    return SafeArea(
      child: Scaffold(
        drawer: HomeDrawer(sharedPreferencesCubit: savedData),
        body: !splash
            ? Center(
                child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      constraints: BoxConstraints(
                        maxWidth: 200,
                        maxHeight: 200,
                      ),
                      child: Image.asset(AssetsData.logo)),
                  Text(kAppName, style: AppStyles.titleStyle),
                ],
              ))
            : Builder(builder: (context) {
                return HomeViewBody(
                  action: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              }),
      ),
    );
  }
}
