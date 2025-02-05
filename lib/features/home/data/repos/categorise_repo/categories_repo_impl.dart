import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/cubits/token_cubit/token_cubit.dart';
import 'package:lms_admin/core/errors/failures.dart';
import 'package:lms_admin/core/success/success.dart';
import 'package:lms_admin/core/utils/api_service.dart';
import 'package:lms_admin/core/utils/service_locator.dart';
import 'package:lms_admin/features/home/data/models/categories_model/categories_model.dart';
import 'package:lms_admin/features/home/data/models/categories_model/category.dart';
import 'package:lms_admin/features/home/data/repos/categorise_repo/categories_repo.dart';

class CategoriesRepoImpl implements CategoriesRepo {
  final ApiService _apiService;
  final TokenCubit tokenCubit = getIt<TokenCubit>();
  CategoriesRepoImpl(this._apiService);

//Ads Impl
  @override
  Future<Either<Failure, CategoriesModel>> fetch() async {
    try {
      final response = await _apiService.get(
        url: '$kBaseUrl/category/index',
        token: tokenCubit.state,
        body: null,
        queryParameters: null,
      );

      CategoriesModel categoriesModel = CategoriesModel.fromJson(response);

      return right(categoriesModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CategoriesModel>> post({
    required Categoryy category,
  }) async {
    try {
      // var imageFile =  MultipartFile.fromBytes(ad.image!.bytes!.toList(), filename: 'fileName');

      final response = await _apiService.upload(
          url: '$kBaseUrl/category/store',
          token: tokenCubit.state,
          body: category.toUploadJson(),
          // file: file
          // await ad.toJson(),
          // file: ad.image!,
          cancelToken: null,
          onSendProgress: null);

      CategoriesModel categoriesModel =
          CategoriesModel.fromSingleJson(response);

      return right(categoriesModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CategoriesModel>> update(
      {required Categoryy categoryy}) async {
    try {
      // var imageFile =  MultipartFile.fromBytes(ad.image!.bytes!.toList(), filename: 'fileName');

      final response = await _apiService.upload(
          url: '$kBaseUrl/category/update',
          token: tokenCubit.state,
          body: categoryy.toUpdateJson(),
          cancelToken: null,
          onSendProgress: null);
      CategoriesModel categoriesModel =
          CategoriesModel.fromSingleJson(response);
      // CategoriesModel categoriesModel = CategoriesModel.fromJson(response);
      return right(categoriesModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ServerSuccess>> delete({required String name}) async {
    try {
      final response = await _apiService.post(
        url: '$kBaseUrl/category/destroy',
        token: tokenCubit.state,
        body: {"category_id": name},
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
