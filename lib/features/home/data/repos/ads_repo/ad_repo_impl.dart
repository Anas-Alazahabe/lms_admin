import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/cubits/token_cubit/token_cubit.dart';
import 'package:lms_admin/core/errors/failures.dart';
import 'package:lms_admin/core/success/success.dart';
import 'package:lms_admin/core/utils/api_service.dart';
import 'package:lms_admin/core/utils/service_locator.dart';
import 'package:lms_admin/features/home/data/models/ad_model/ad.dart';
import 'package:lms_admin/features/home/data/models/ad_model/ads_model.dart';
import 'package:lms_admin/features/home/data/repos/ads_repo/ad_repo.dart';

class AdRepoImpl implements AdsRepo {
  final ApiService _apiService;
  final TokenCubit tokenCubit = getIt<TokenCubit>();
  AdRepoImpl(this._apiService);

//Ads Impl
  @override
  Future<Either<Failure, AdsModel>> fetchAds({required bool all}) async {
    try {
      final response = await _apiService.get(
        url: all ? '$kBaseUrl/ad/index' : '$kBaseUrl/ad/showNewest',
        token: tokenCubit.state,
        body: null,
        queryParameters: null,
      );

      AdsModel adModel = AdsModel.fromJson(response);

      return right(adModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AdsModel>> uploadAd({
    required Ad ad,
  }) async {
    try {
      // var imageFile =  MultipartFile.fromBytes(ad.image!.bytes!.toList(), filename: 'fileName');

      final response = await _apiService.upload(
          url: '$kBaseUrl/ad/store',
          token: tokenCubit.state,
          body: ad.toUploadJson(),
          // file: file
          // await ad.toJson(),
          // file: ad.image!,
          cancelToken: null,
          onSendProgress: null);
      AdsModel adModel = AdsModel.fromSingleJson(response);

      return right(adModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AdsModel>> updateAd({required Ad ad}) async {
    try {
      // var imageFile =  MultipartFile.fromBytes(ad.image!.bytes!.toList(), filename: 'fileName');

      final response = await _apiService.upload(
          url: '$kBaseUrl/ad/update',
          token: tokenCubit.state,
          body: ad.toUpdateJson(),
          cancelToken: null,
          onSendProgress: null);
      AdsModel adModel = AdsModel.fromSingleJson(response);
      return right(adModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ServerSuccess>> setAdExpired(
      {required String adId}) async {
    try {
      final response = await _apiService.post(
        url: '$kBaseUrl/ad/setExpired',
        token: tokenCubit.state,
        body: {"ad_id": adId},
      );
      ServerSuccess serverSuccess = ServerSuccess.fromResponse(response);
      return right(serverSuccess);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ServerSuccess>> deleteAd(
      {required String adId}) async {
    try {
      final response = await _apiService.post(
        url: '$kBaseUrl/ad/destroy',
        token: tokenCubit.state,
        body: {"ad_id": adId},
      );
      ServerSuccess serverSuccess = ServerSuccess.fromResponse(response);
      return right(serverSuccess);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
