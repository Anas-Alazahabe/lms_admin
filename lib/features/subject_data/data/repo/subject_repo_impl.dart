import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_admin/core/cubits/token_cubit/token_cubit.dart';
import 'package:lms_admin/core/errors/failures.dart';
import 'package:lms_admin/core/utils/api_service.dart';
import 'package:lms_admin/core/utils/service_locator.dart';
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
import 'package:lms_admin/features/subject_data/data/repo/subject_repo.dart';

class SubjectRepoImpl implements SubjectRepo {
  final ApiService _apiService;
  final TokenCubit tokenCubit = getIt<TokenCubit>();
  final SharedPreferencesCubit sharedPreferencesCubit =
      getIt<SharedPreferencesCubit>();
  SubjectRepoImpl(this._apiService);

  @override
  Future<Either<Failure, Unitt>> fetchUnits(
      {required String? subjectId}) async {
    try {
      final response = await _apiService.post(
        url: '$kBaseUrl/unit/show_all_units',
        token: tokenCubit.state,
        body: {
          'subject_id': subjectId,
        },
      );
      // print(response['files']);

      Unitt unitModel = Unitt.fromJson(response);

      return right(unitModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unitt>> postUnit({required UnitData unit}) async {
    try {
      // var imageFile =  MultipartFile.fromBytes(ad.image!.bytes!.toList(), filename: 'fileName');

      final response = await _apiService.upload(
          url: '$kBaseUrl/unit/add_unit',
          token: tokenCubit.state,
          body: unit.toUploadJson(),
          cancelToken: null,
          onSendProgress: null);

      Unitt unitModel = Unitt.fromSingleJson(response);

      return right(unitModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Lesson>> postLesson({required Lesson lesson}) async {
    try {
      // var imageFile =  MultipartFile.fromBytes(ad.image!.bytes!.toList(), filename: 'fileName');

      final response = await _apiService.upload(
          url: '$kBaseUrl/lessons/add',
          token: tokenCubit.state,
          body: lesson.toUploadJson(),
          cancelToken: null,
          onSendProgress: null);

      Lesson lessonModel = Lesson.fromJson(response['data']);

      return right(lessonModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Video>> postVideo(
      {required Video video,
      required CancelToken cancelToken,
      required void Function(int received, int total)? onSendProgress}) async {
    try {
      final response = await _apiService.upload(
          url: '$kBaseUrl/video/store',
          token: tokenCubit.state,
          body: video.toUploadJson(),
          cancelToken: cancelToken,
          onSendProgress: onSendProgress);
      Video videoo = Video.fromJson(response['video']);
      return right(videoo);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, QuizzesModel>> fetchQuizzes(
      {required String? subjectId,
      required String? type,
      required String? typeId}) async {
    try {
      final response = await _apiService.post(
        url: '$kBaseUrl/quiz/show_all_to_teacher',
        token: tokenCubit.state,
        body: {
          'subject_id': subjectId,
          'type': type,
          'type_id': typeId,
        },
      );
      print(response);
      QuizzesModel quizzezModel = QuizzesModel.fromJson(response);

      return right(quizzezModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Quiz>> postQuiz({required Quiz quiz}) async {
    try {
      // var imageFile =  MultipartFile.fromBytes(ad.image!.bytes!.toList(), filename: 'fileName');

      final response = await _apiService.post(
        url: '$kBaseUrl/quiz/add_quiz',
        token: tokenCubit.state,
        body: quiz.toAddQuizJson(),
      );

      Quiz quizz = Quiz.fromJson(response['quiz']);

      return right(quizz);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommentsModel>> fetchCommentsData(
      {required String lessonId}) async {
    try {
      final response = await _apiService.get(
        url: '$kBaseUrl/comment/getComments',
        token: tokenCubit.state,
        body: null,
        queryParameters: {'lesson_id':lessonId},
      );

      CommentsModel commentsModel = CommentsModel.fromJson(response);

      return right(commentsModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommentData>> postReply(
      {required String reply,
      required String parentId,
            required String lessonId,
     }) async {
    try {
      final response = await _apiService.post(
        url: '$kBaseUrl/comment/teacherReply',
        token: tokenCubit.state,
        body: {
          "content": reply,
          "r": parentId,

        },
      );

      CommentData commentsModel = CommentData.fromSingleJson(response['data']);
      return right(commentsModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommentData>> updateReply(
      {required String reply, required String replyId}) async {
    try {
      final response = await _apiService.post(
        url: '$kBaseUrl/comment/update',
        token: tokenCubit.state,
        body: {
             "content": reply,
          'id':replyId
        },
      );

      CommentData commentsModel = CommentData.fromSingleJson(response['data']);

      return right(commentsModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Filee>> postFile(
      {required Filee file,
      required CancelToken cancelToken,
      required void Function(int received, int total)? onSendProgress}) async {
    try {
      final response = await _apiService.upload(
          url: '$kBaseUrl/files/store',
          token: tokenCubit.state,
          body: file.toUploadJson(),
          cancelToken: cancelToken,
          onSendProgress: onSendProgress);
      Filee videoo = Filee.fromJson(response['file']);
      return right(videoo);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
