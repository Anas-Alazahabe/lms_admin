import 'package:dartz/dartz.dart';
import 'package:lms_admin/core/errors/failures.dart';

abstract class AuthRepo {
  Future<Either<Failure, Map<String, dynamic>>> signInWithDeviceToken({
    required String email,
    required String password,
  });
  Future<Either<Failure, Map<String, dynamic>>> signUpWithNameAndPassword(
      {required String username,
      required String userId,
      required String password});

  Future<Either<Failure, bool>> createUser({required String email});
  Future<Either<Failure, int>> verifyUser(
      {required String email, required String verificationCode});
  Future<Either<Failure, bool>> postForgotPasswordEmail(
      {required String email});
  Future<Either<Failure, bool>> postForgotPasswordEmailAndCode(
      {required String email, required String code});
  Future<Either<Failure, bool>> postNewPasswordAndEmail(
      {required String email, required String newPassword});
  Future<Either<Failure, bool>> resendEmail({required String email});
}
