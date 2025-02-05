import 'package:dartz/dartz.dart';
import 'package:lms_admin/core/errors/failures.dart';
import 'package:lms_admin/core/success/success.dart';
import 'package:lms_admin/features/home/data/models/ad_model/ad.dart';
import 'package:lms_admin/features/home/data/models/ad_model/ads_model.dart';

abstract class AdsRepo {
  //Ads
  //all ads or only the active ads
  Future<Either<Failure, AdsModel>> fetchAds({required bool all});
  //post new ad
  Future<Either<Failure, AdsModel>> uploadAd({
    required Ad ad,
  });
  Future<Either<Failure, AdsModel>> updateAd({
    required Ad ad,
  });
  Future<Either<Failure, ServerSuccess>> setAdExpired({
    required String adId,
  });
  Future<Either<Failure, ServerSuccess>> deleteAd({
    required String adId,
  });
}
