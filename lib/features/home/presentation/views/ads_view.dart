import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lms_admin/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_admin/core/cubits/token_cubit/token_cubit.dart';
import 'package:lms_admin/core/utils/service_locator.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/ads/ads_widgets/home_ads.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/home_drawer.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/home_view_body.dart';

class AdsView extends StatefulWidget {
  const AdsView({super.key});

  @override
  State<AdsView> createState() => _AdsViewState();
}

class _AdsViewState extends State<AdsView> {
  final token = getIt<TokenCubit>();
  final savedData = getIt<SharedPreferencesCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(sharedPreferencesCubit: savedData),
      body: Builder(builder: (context) {
        return HomeAds(
          action: () {
            Scaffold.of(context).openDrawer();
          },
        );
      }),
    );
  }
}
