import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_admin/core/cubits/token_cubit/token_cubit.dart';
import 'package:lms_admin/core/errors/failures.dart';
import 'package:lms_admin/core/utils/api_service.dart';
import 'package:lms_admin/core/utils/service_locator.dart';
import 'package:lms_admin/features/home/data/models/search_result_model/search_result_model.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/subjects_model.dart';
import 'package:lms_admin/features/home/data/models/users_model/users_model.dart';
import 'package:lms_admin/features/home/data/repos/home_repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService _apiService;
  final TokenCubit tokenCubit = getIt<TokenCubit>();
  final SharedPreferencesCubit sharedPreferencesCubit =
      getIt<SharedPreferencesCubit>();
  HomeRepoImpl(this._apiService);
  //:// tokenCubit = GetIt.instance<TokenCubit>(),
  // sharedPreferencesCubit = GetIt.instance<SharedPreferencesCubit>();

  @override
  Future<Either<Failure, SubjectsModel>> fetchSubjects(
      {required String? yearId}) async {
    try {
      final response = await _apiService.get(
          url: '$kBaseUrl/subject/index',
          token: tokenCubit.state,
          body: null,
          queryParameters: {
            'year_id': yearId,
          });

      SubjectsModel subjectsModel = SubjectsModel.fromJson(response);

      return right(subjectsModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SearchResultModel>> searchSubject(
      {required String? name, required String? yearId}) async {
    try {
      final response = await _apiService.get(
          url: '$kBaseUrl/subject/search',
          token: tokenCubit.state,
          body: null,
          queryParameters: {
            'year_id': yearId,
            'name': name,
          });

      SearchResultModel resultModel = SearchResultModel.fromJson(response);

      return right(resultModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UsersModel>> fetchAllUsers() async {
    try {
      final response = await _apiService.get(
          url: '$kBaseUrl/auth/indexUsers',
          token: tokenCubit.state,
          body: null,
          queryParameters: null);

      print(response);

      UsersModel subjectsModel = UsersModel.fromJson(response);

      return right(subjectsModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> createUser(
      {required String email, required String roleId}) async {
    try {
      //final response =
      await _apiService.post(
        url: '$kBaseUrl/auth/createUserWeb',
        body: {'email': email, 'role_id': roleId},
        token: tokenCubit.state,
      );

      return right(true);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, String>> deleteUser({required String userId}) async{
     try {
      final response =
      await _apiService.post(
        url: '$kBaseUrl/auth/deleteUser',
        body: {'user_id': userId, },
        token: tokenCubit.state,
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
  Future<Either<Failure, String>> resetUser({required String email}) async{
     try {
      final response =
      await _apiService.post(
        url: '$kBaseUrl/auth/reset',
        body: {'email': email, },
        token: tokenCubit.state,
      );

      return right(response['message']);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
