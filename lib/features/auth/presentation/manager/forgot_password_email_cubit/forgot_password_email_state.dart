part of 'forgot_password_email_cubit.dart';

sealed class ForgotPasswordEmailState extends Equatable {
  const ForgotPasswordEmailState();

  @override
  List<Object> get props => [];
}

final class ForgotPasswordEmailInitial extends ForgotPasswordEmailState {}

final class ForgotPasswordEmailLoading extends ForgotPasswordEmailState {}

final class ForgotPasswordEmailFailure extends ForgotPasswordEmailState {
  final String errMessage;
  const ForgotPasswordEmailFailure({required this.errMessage});
}

final class ForgotPasswordEmailSuccess extends ForgotPasswordEmailState {
  final bool success;
  const ForgotPasswordEmailSuccess(this.success);
}
