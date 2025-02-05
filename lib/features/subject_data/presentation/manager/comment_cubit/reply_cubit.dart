import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lms_admin/features/subject_data/data/models/comments_model/comment_data.dart';
import 'package:lms_admin/features/subject_data/data/models/comments_model/comment_model.dart';
import 'package:lms_admin/features/subject_data/data/repo/subject_repo.dart';

part 'reply_state.dart';

class ReplyCubit extends Cubit<ReplyState> {
  final SubjectRepo subjectRepo;

  ReplyCubit(this.subjectRepo) : super(ReplyInitial());

  Future<void> postReply(
      {required String comment,
      required String parentId,
      required String lessonId,
      }) async {
    emit(ReplyLoading());
    final result = await subjectRepo.postReply(
lessonId: lessonId,
         reply: comment, parentId: parentId);
    result.fold((failure) => emit(ReplyFailure(errMessage: failure.errMessage)),
        (comment) => emit(ReplySuccess(comment)));
  }

  Future<void> updateReply({
    required String comment,
    required String commentId,
  }) async {
    emit(ReplyLoading());
    final result =
        await subjectRepo.updateReply(reply: comment, replyId: commentId);
    result.fold((failure) => emit(ReplyFailure(errMessage: failure.errMessage)),
        (comment) => emit(EditingSuccess(comment)));
  }

  void onSetReplyText(String text, String id) {
    emit(SetReplyText(text, id));
  }
}
