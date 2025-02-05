import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/features/home/data/repos/ads_repo/ad_repo.dart';

class DeleteAdCubit extends BaseCubit<String> {
  final AdsRepo adRepo;

  DeleteAdCubit(this.adRepo) : super();

  Future<void> deleteAd({
    required String adId,
  }) async {
    emitLoading();
    final result = await adRepo.deleteAd(adId: adId);
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (ad) => emitSuccess(ad.message),
    );
  }
}
