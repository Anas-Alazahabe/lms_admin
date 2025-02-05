part of 'reply_cubit.dart';

sealed class ReplyState extends Equatable {
  const ReplyState();

  @override
  List<Object> get props => [];
}

final class ReplyInitial extends ReplyState {}

final class ReplySuccess extends ReplyState {
  final CommentData commentReply;

  const ReplySuccess(this.commentReply);
     @override
  List<Object> get props => [commentReply];
}

final class EditingSuccess extends ReplyState {
  final CommentData commentModel;

  const EditingSuccess(this.commentModel);

     @override
  List<Object> get props => [commentModel];
}

final class ReplyLoading extends ReplyState {}

//final class ReplyLoading1 extends ReplyState {}

final class ReplyFailure extends ReplyState {
  final String errMessage;
  const ReplyFailure({required this.errMessage});
}

final class SetReplyText extends ReplyState {
  final String text;
  final String id;
  const SetReplyText(this.text, this.id);

   @override
  List<Object> get props => [text, id];
}
