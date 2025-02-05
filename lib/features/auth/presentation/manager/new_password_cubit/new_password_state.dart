part of 'new_password_cubit.dart';

sealed class NewPasswordState extends Equatable {
  const NewPasswordState();

  @override
  List<Object> get props => [];
}

final class NewPasswordInitial extends NewPasswordState {}

final class NewPasswordLoading extends NewPasswordState {}

final class NewPasswordFailure extends NewPasswordState {
  final String errMessage;
  const NewPasswordFailure({required this.errMessage});
}

final class NewPasswordSuccess extends NewPasswordState {
  final bool success;
  const NewPasswordSuccess(this.success);
}
