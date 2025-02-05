// import 'package:dartz/dartz.dart';
// import 'package:lms_admin/core/errors/failures.dart';
// import 'package:lms_admin/features/home/data/models/comments_model/comment_model.dart';
// import 'package:lms_admin/features/home/data/models/comments_model/comments_model.dart';
// import 'package:lms_admin/features/home/data/models/course_model/course_model.dart';
// import 'package:lms_admin/features/home/data/models/lesson_model/lesson_model.dart';
// import 'package:lms_admin/features/home/data/models/lesson_model/video.dart';
// import 'package:lms_admin/features/home/data/models/quiz_model/quiz_model.dart';

// abstract class HomeRepo {import 'package:dartz/dartz.dart';
import 'package:dartz/dartz.dart';
import 'package:lms_admin/core/errors/failures.dart';
import 'package:lms_admin/features/home/data/models/search_result_model/search_result_model.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/subjects_model.dart';
import 'package:lms_admin/features/home/data/models/users_model/users_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, SubjectsModel>> fetchSubjects(
      {required String? yearId});

  Future<Either<Failure, SearchResultModel>> searchSubject(
      {required String? name, required String? yearId});
  Future<Either<Failure, UsersModel>> fetchAllUsers();
  Future<Either<Failure, String>> deleteUser({required String userId});
  Future<Either<Failure, String>> resetUser({required String email});

    Future<Either<Failure, bool>> createUser({required String email,required String roleId});

}
