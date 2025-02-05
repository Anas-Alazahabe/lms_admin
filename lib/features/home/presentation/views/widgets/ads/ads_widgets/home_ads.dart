// import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/utils/service_locator.dart';
import 'package:lms_admin/core/utils/size_config.dart';
import 'package:lms_admin/core/widgets/custom_error.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';
import 'package:lms_admin/features/home/data/models/ad_model/ad.dart';
import 'package:lms_admin/features/home/data/repos/ads_repo/ad_repo_impl.dart';
import 'package:lms_admin/features/home/presentation/manager/ads_cubits/delete_ad_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/ads_cubits/fetch_ads_cubit/fetch_ads_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/ads_cubits/set_ad_expired_cubit.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/ads/ads_functions/ad_dialog.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/home_view_body_header.dart';
import 'package:navigation_tool/navigation_tool.dart';
import 'ad_item.dart';

class HomeAds extends StatefulWidget {
  const HomeAds({
    super.key,
    required this.action,
  });
  final VoidCallback action;
  @override
  State<HomeAds> createState() => _HomeAdsState();
}

class _HomeAdsState extends State<HomeAds> {
  List<Ad>? ads;

  @override
  void initState() {
    BlocProvider.of<FetchAdsCubit>(context).fetchAds(all: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchAdsCubit, FetchAdsState>(
      builder: (context, state) {
        if (state is FetchAdsFailure) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/noresult.png',
                    height: 150.0, // Adjust the size as needed
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'No results found',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Try agian later to find what you are looking for.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is FetchAdsLoading) {
          return const CustomLoading();
        }
        if (state is FetchAdsSuccess) {
          if (state.adModel.message!.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/noresult.png',
                      height: 150.0, // Adjust the size as needed
                    ),
                    SizedBox(height: 24.0),
                    Text(
                      'No results found',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Try again later to find what you are looking for.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          ads = state.adModel.message!;
          return Column(
            children: [
              HomeViewBodyHeader(
                // rand: widget.rand,
                action: widget.action,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 252,
                      maxCrossAxisExtent: 250,
                      childAspectRatio: 6.99 / 7,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemCount: ads!.length + 1,
                    itemBuilder: (context, index) {
                      if (index == ads!.length) {
                        return addAdItem(context);
                      }
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider(
                              create: (context) =>
                                  SetAdExpiredCubit(getIt<AdRepoImpl>())),
                          BlocProvider(
                              create: (context) =>
                                  DeleteAdCubit(getIt<AdRepoImpl>()))
                        ],
                        child: AdItem(
                          ad: ads![index],
                          onUpdateAd: editAd,
                          onSetExpired: setAdExpired,
                          onDelete: deleteAd,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  void editAd(editedAd) {
    final index = ads!.indexWhere((element) => element.id == editedAd.id);
    ads![index] = editedAd;
    setState(() {});
  }

  void setAdExpired(ad) {
    final index = ads!.indexWhere((element) => element.id == ad.id);
    ads![index] = ad.copyWith(isExpired: (() => 1));
    setState(() {});
  }

  void deleteAd(ad) {
    final index = ads!.indexWhere((element) => element.id == ad.id);
    ads!.remove(ads![index]);
    setState(() {});
  }

  Center addAdItem(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          adDialog(context, (ad) {
            ads!.add(ad);
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
      ),
    );
  }
}
