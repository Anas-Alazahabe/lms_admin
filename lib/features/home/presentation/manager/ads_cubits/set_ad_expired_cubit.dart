import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/features/home/data/repos/ads_repo/ad_repo.dart';

class SetAdExpiredCubit extends BaseCubit<String> {
  final AdsRepo adRepo;

  SetAdExpiredCubit(this.adRepo) : super();

  Future<void> setAdExpired({
    required String adId,
  }) async {
    emitLoading();
    final result = await adRepo.setAdExpired(adId: adId);
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (ad) => emitSuccess(ad.message),
    );
  }
}
