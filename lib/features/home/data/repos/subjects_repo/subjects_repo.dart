import 'package:dartz/dartz.dart';
import 'package:lms_admin/core/errors/failures.dart';
import 'package:lms_admin/core/success/success.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/subject.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/subjects_model.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/year.dart';

abstract class SubjectsRepo {
  //Ads
  //all ads or only the active ads

  Future<Either<Failure, SubjectsModel>> fetch({
    required int? categoryId,
    required int? yearId,
    //  Subject subject,
    // required Subject subject,
  });

  // Future<Either<Failure, SubjectsModel>> fetch(
  //   // {
  //     //  Subject subject,
  //   // required Subject subject,
  // // }
  // );
  //post new ad
  Future<Either<Failure, SubjectsModel>> post({
    required Subject subject,
  });
  Future<Either<Failure, SubjectsModel>> update({
    required Subject subject,
  });

  Future<Either<Failure, String>> delete({
    required String id,
  });
}
