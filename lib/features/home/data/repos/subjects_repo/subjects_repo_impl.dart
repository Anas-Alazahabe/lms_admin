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
import 'package:lms_admin/features/home/data/models/subjects_model/subjects_model.dart';
import 'package:lms_admin/features/home/data/repos/categorise_repo/categories_repo.dart';
import 'package:lms_admin/features/home/data/repos/subjects_repo/subjects_repo.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/subject.dart';

class SubjectsRepoImpl implements SubjectsRepo {
  final ApiService _apiService;

  final TokenCubit tokenCubit = getIt<TokenCubit>();
  SubjectsRepoImpl(this._apiService);

// Ads Impl
  @override
  Future<Either<Failure, SubjectsModel>> fetch({
    required int? categoryId,
    required int? yearId,
    // Subject subject
    // required Subject subject
  }) async {
    try {
      final response = await _apiService.get(
        url: '$kBaseUrl/subject/index',
        token: tokenCubit.state,
        body: null,

        queryParameters: categoryId == 1
            ? {
                'year_id': yearId
                // subject.yearsContent
                ,
              }
            : null,

        //     {
        //   'category_id': 2
        //   // subject.categoryId
        //   ,
        //   'year_id':0
        //   // subject.yearsContent
        //   ,
        // },
      );
      print(response);
      SubjectsModel subjectsModel = SubjectsModel.multifromJson(response);
      return right(subjectsModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

//add subjects
  @override
  Future<Either<Failure, SubjectsModel>> post({
    required Subject subject,
  }) async {
    try {
      // var imageFile =  MultipartFile.fromBytes(ad.image!.bytes!.toList(), filename: 'fileName');
      print(
        subject.toJson(),
      );

      final response = await _apiService.upload(
        url: '$kBaseUrl/subject/add_subject',
        token: tokenCubit.state,
        cancelToken: null,
        onSendProgress: null,
        body: subject.toJson(),

        // file: file
        // await ad.toJson(),
        // file: ad.image!,
      );
      SubjectsModel subjectsModel = SubjectsModel.fromJson(response);
      // print('After fromJson');

      return right(subjectsModel);
    } on Exception catch (e) {
      if (e is DioException) {
        print(e);
        return Left(ServerFailure.fromDioException(e));
      }
      print(e);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> delete({required String id}) async {
    try {
      final response = await _apiService.post(
        url: '$kBaseUrl/subject/delete_subject',
        token: tokenCubit.state,
        body: {"subject_id": id},
      );

      return right(response['message']);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SubjectsModel>> update({ required Subject subject}) async {
    try {
      // var imageFile =  MultipartFile.fromBytes(ad.image!.bytes!.toList(), filename: 'fileName');

      final response = await _apiService.upload(
          url: '$kBaseUrl/subject/edit_subject',
          token: tokenCubit.state,
          body: subject.toJson(),
          cancelToken: null,
          onSendProgress: null);
      SubjectsModel categoriesModel = SubjectsModel.fromSingleJson(response);
      // CategoriesModel categoriesModel = CategoriesModel.fromJson(response);
      return right(categoriesModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, ServerSuccess>> delete({required String name}) async {
  //   try {
  //     final response = await _apiService.post(
  //       url: '$kBaseUrl/category/destroy',
  //       token: tokenCubit.state,
  //       body: {"category": name},
  //     );
  //     ServerSuccess serverSuccess = ServerSuccess.fromResponse(response);
  //     return right(serverSuccess);
  //   } on Exception catch (e) {
  //     if (e is DioException) {
  //       return Left(ServerFailure.fromDioException(e));
  //     }
  //     return Left(ServerFailure(e.toString()));
  //   }
  // }
}
