import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/features/home/data/models/ad_model/ad.dart';
import 'package:lms_admin/features/home/data/models/ad_model/ads_model.dart';
import 'package:lms_admin/features/home/data/repos/ads_repo/ad_repo.dart';

class PostAdCubit extends BaseCubit<AdsModel> {
  final AdsRepo adRepo;

  PostAdCubit(this.adRepo) : super();

  Future<void> uploadAd({
    required Ad ad,
    // required PlatformFile file,
  }) async {
    emitLoading();
    final result = await adRepo.uploadAd(
      // file: file,
      ad: ad,
    );
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (ad) => emitSuccess(ad),
    );
  }
}
