import 'package:equatable/equatable.dart';
import 'package:lms_admin/features/home/data/models/ad_model/ads_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repos/ads_repo/ad_repo.dart';

part 'fetch_ads_state.dart';

class FetchAdsCubit extends Cubit<FetchAdsState> {
  final AdsRepo adRepo;

  FetchAdsCubit(this.adRepo) : super(FetchAdsInitial());

  Future<void> fetchAds({required bool all}) async {
    emit(FetchAdsLoading());
    final result = await adRepo.fetchAds(all: all);
    result.fold(
        (failure) => emit(FetchAdsFailure(errMessage: failure.errMessage)),
        (ad) => emit(FetchAdsSuccess(ad)));
  }
}
