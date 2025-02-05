import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lms_admin/features/auth/data/repos/auth_repo.dart';

part 'new_password_state.dart';

class NewPasswordCubit extends Cubit<NewPasswordState> {
  final AuthRepo authRepo;

  NewPasswordCubit(this.authRepo) : super(NewPasswordInitial());

  Future<void> postNewPasswordAndEmail(
    String email,
    String newPassword,
  ) async {
    emit(NewPasswordLoading());

    final result = await authRepo.postNewPasswordAndEmail(
        newPassword: newPassword, email: email);
    result.fold((failure) {
      emit(NewPasswordFailure(errMessage: failure.errMessage));
    }, (success) {
      emit(NewPasswordSuccess(success));
    });
  }
}
