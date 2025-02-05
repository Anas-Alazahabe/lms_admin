part of 'forgot_password_code_and_email_cubit.dart';

sealed class ForgotPasswordCodeAndEmailState extends Equatable {
  const ForgotPasswordCodeAndEmailState();

  @override
  List<Object> get props => [];
}

final class ForgotPasswordCodeAndEmailInitial
    extends ForgotPasswordCodeAndEmailState {}

final class ForgotPasswordCodeAndEmailLoading
    extends ForgotPasswordCodeAndEmailState {}

final class ForgotPasswordCodeAndEmailFailure
    extends ForgotPasswordCodeAndEmailState {
  final String errMessage;
  const ForgotPasswordCodeAndEmailFailure({required this.errMessage});
}

final class ForgotPasswordCodeAndEmailSuccess
    extends ForgotPasswordCodeAndEmailState {
  final bool success;
  const ForgotPasswordCodeAndEmailSuccess(this.success);
}
