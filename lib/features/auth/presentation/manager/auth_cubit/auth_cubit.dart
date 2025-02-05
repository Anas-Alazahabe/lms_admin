import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin/features/auth/data/repos/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  final AuthRepo authRepo;

  Future<void> signInWithUsernameAndToken({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    final result = await authRepo.signInWithDeviceToken(
      email: email,
      password: password,
    );
    result.fold((failure) {
      emit(AuthFailure(errMessage: failure.errMessage));
    }, (success) {
      emit(AuthSuccess(success['message']));
    });
  }

  Future<void> signUpWithNameAndPassword(
      String username, String userId, String password) async {
    emit(AuthLoading());
    final result = await authRepo.signUpWithNameAndPassword(
        userId: userId, username: username, password: password);
    result.fold((failure) {
      emit(AuthFailure(errMessage: failure.errMessage));
    }, (success) {
      emit(AuthSuccess(success['message']));
    });
  }
}
