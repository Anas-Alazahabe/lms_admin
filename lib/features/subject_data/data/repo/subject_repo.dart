import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lms_admin/core/errors/failures.dart';
import 'package:lms_admin/features/subject_data/data/models/comments_model/comment_model.dart';
import 'package:lms_admin/features/subject_data/data/models/comments_model/comments_model.dart';
import 'package:lms_admin/features/subject_data/data/models/comments_model/comment_data.dart';
import 'package:lms_admin/features/subject_data/data/models/quizzes_model/quiz.dart';
import 'package:lms_admin/features/subject_data/data/models/quizzes_model/quizzes_model.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/file.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/lesson.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/unit.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/unit_data.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/video.dart';

abstract class SubjectRepo {
  Future<Either<Failure, Unitt>> fetchUnits({required String? subjectId});
  Future<Either<Failure, Unitt>> postUnit({required UnitData unit});
  Future<Either<Failure, Lesson>> postLesson({required Lesson lesson});
  Future<Either<Failure, QuizzesModel>> fetchQuizzes(
      {required String? subjectId,
      required String? type,
      required String? typeId});
  Future<Either<Failure, Quiz>> postQuiz({required Quiz quiz});
  Future<Either<Failure, Video>> postVideo(
      {required Video video,
      required CancelToken cancelToken,
      required void Function(int received, int total)? onSendProgress});
  Future<Either<Failure, Filee>> postFile(
      {required Filee file,
      required CancelToken cancelToken,
      required void Function(int received, int total)? onSendProgress});

  Future<Either<Failure, CommentsModel>> fetchCommentsData(
      {required String lessonId});
  Future<Either<Failure, CommentData>> postReply({
    required String reply,
    required String parentId,
          required String lessonId,
    // required String courseId
  });
  Future<Either<Failure, CommentData>> updateReply(
      {required String reply, required String replyId});

  // Future<Either<Failure, SearchResultModel>> searchSubject(
  //     {required String? name, required String? yearId});
}
