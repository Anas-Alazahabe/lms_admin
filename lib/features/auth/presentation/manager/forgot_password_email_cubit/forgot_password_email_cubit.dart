import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lms_admin/features/auth/data/repos/auth_repo.dart';

part 'forgot_password_email_state.dart';

class ForgotPasswordEmailCubit extends Cubit<ForgotPasswordEmailState> {
  final AuthRepo authRepo;

  ForgotPasswordEmailCubit(this.authRepo) : super(ForgotPasswordEmailInitial());

  Future<void> postForgotPasswordEmail(
    String email,
  ) async {
    emit(ForgotPasswordEmailLoading());

    final result = await authRepo.postForgotPasswordEmail(email: email);
    result.fold((failure) {
      emit(ForgotPasswordEmailFailure(errMessage: failure.errMessage));
    }, (success) {
      emit(const ForgotPasswordEmailSuccess(true));
    });
  }
}
