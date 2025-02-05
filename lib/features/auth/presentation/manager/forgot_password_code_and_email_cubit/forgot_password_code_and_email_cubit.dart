import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lms_admin/features/auth/data/repos/auth_repo.dart';

part 'forgot_password_code_and_email_state.dart';

class ForgotPasswordCodeAndEmailCubit
    extends Cubit<ForgotPasswordCodeAndEmailState> {
  final AuthRepo authRepo;

  ForgotPasswordCodeAndEmailCubit(this.authRepo)
      : super(ForgotPasswordCodeAndEmailInitial());

  Future<void> postForgotPasswordCodeAndEmail(
    String email,
    String code,
  ) async {
    emit(ForgotPasswordCodeAndEmailLoading());

    final result =
        await authRepo.postForgotPasswordEmailAndCode(email: email, code: code);
    result.fold((failure) {
      emit(ForgotPasswordCodeAndEmailFailure(errMessage: failure.errMessage));
    }, (success) {
      emit(const ForgotPasswordCodeAndEmailSuccess(true));
    });
  }
}
