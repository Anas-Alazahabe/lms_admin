part of 'comments_cubit.dart';

sealed class CommentsState extends Equatable {
  const CommentsState();

  @override
  List<Object> get props => [];
}

final class CommentsInitial extends CommentsState {}

final class CommentsLoading extends CommentsState {}

final class CommentsFailure extends CommentsState {
  final String errMessage;
  const CommentsFailure({required this.errMessage});
}

final class CommentsSuccess extends CommentsState {
  final CommentsModel commentsModel;

  const CommentsSuccess(this.commentsModel);
}
