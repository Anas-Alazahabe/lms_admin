import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_admin/core/errors/failures.dart';
import 'package:lms_admin/core/cubits/token_cubit/token_cubit.dart';
import 'package:lms_admin/core/utils/api_service.dart';
import 'package:lms_admin/core/utils/service_locator.dart';
import 'package:lms_admin/features/auth/data/models/user_model/user.dart';
import 'package:lms_admin/features/auth/data/models/user_model/user_model.dart';
import 'package:lms_admin/features/auth/data/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService _apiService;
  final TokenCubit tokenCubit = getIt<TokenCubit>();
  final SharedPreferencesCubit sharedPreferencesCubit =
      getIt<SharedPreferencesCubit>();
  AuthRepoImpl(this._apiService);

  @override
  Future<Either<Failure, Map<String, dynamic>>> signInWithDeviceToken({
    required String email,
    required String password,
  }) async {
    try {
// Encrypting
      // Map<String, dynamic> body;
      // if (verificationCode!.trim().isNotEmpty &&
      //     verificationCode.trim().length == 7) {
      // } else {}
      final response = await _apiService.post(
        url: '$kBaseUrl/auth/loginWeb',
        body: {
          'email': email,
          'password': password,
        },
        token: null,
      );
      var box = Hive.box<User>(kUser);
      Future.wait([
        box.add(UserModel.fromJson(response).user!),
        tokenCubit.storeToken(response['access_token']),
      ]);

      return right(response);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> signUpWithNameAndPassword(
      {required String username,
      required String userId,
      required String password}) async {
    try {
      final response = await _apiService.post(
        url: '$kBaseUrl/auth/registerWeb',
        body: {
          'name': username,
          'password': password,
          'user_id': userId,
        },
        token: null,
      );
      var box = Hive.box<User>(kUser);
      Future.wait([
        box.add(UserModel.fromJson(response).user!),
        tokenCubit.storeToken(response['access_token']),
        // sharedPreferencesCubit.setUsername(response['user']['name']),
        // sharedPreferencesCubit.setFatherName(response['user']['father_name']),
        // sharedPreferencesCubit.setpoints(response['user']['total_points']),
        // sharedPreferencesCubit.setId((response['user']['id']).toString()),
      ]);

      return right(response);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> createUser({required String email}) async {
    try {
      //final response =
      await _apiService.post(
        url: '$kBaseUrl/auth/createUser',
        body: {
          'email': email,
        },
        token: null,
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
  Future<Either<Failure, int>> verifyUser(
      {required String email, required String verificationCode}) async {
    try {
      final response = await _apiService.post(
        url: '$kBaseUrl/auth/verifyUser',
        body: {
          'verificationCode': verificationCode,
          'email': email,
        },
        token: null,
      );
      Future.wait([
        sharedPreferencesCubit.setId((response['user_id']).toString()),
      ]);
      return right(response['user_id']);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> postForgotPasswordEmail(
      {required String email}) async {
    try {
      //final response =
      await _apiService.post(
        url: '$kBaseUrl/auth/check_user',
        body: {'email': email},
        token: null,
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
  Future<Either<Failure, bool>> postForgotPasswordEmailAndCode(
      {required String email, required String code}) async {
    try {
      await _apiService.post(
        url: '$kBaseUrl/auth/check_code',
        body: {
          'verificationCode': code,
          'email': email,
        },
        token: null,
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
  Future<Either<Failure, bool>> postNewPasswordAndEmail(
      {required String email, required String newPassword}) async {
    try {
      await _apiService.post(
        url: '$kBaseUrl/auth/setPassword',
        body: {
          'email': email,
          'newPassword': newPassword,
        },
        token: null,
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
  Future<Either<Failure, bool>> resendEmail({required String email}) async {
    try {
      //final response =
      await _apiService.post(
        url: '$kBaseUrl/auth/resendEmail',
        body: {'email': email},
        token: null,
      );
      return right(true);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
