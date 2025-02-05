import 'package:dartz/dartz.dart';
import 'package:lms_admin/core/errors/failures.dart';
import 'package:lms_admin/core/success/success.dart';
import 'package:lms_admin/features/home/data/models/categories_model/categories_model.dart';
import 'package:lms_admin/features/home/data/models/categories_model/category.dart';


abstract class CategoriesRepo {
  //Ads
  //all ads or only the active ads
  Future<Either<Failure, CategoriesModel>> fetch();
  //post new ad
  Future<Either<Failure, CategoriesModel>> post({
    required Categoryy category,
  });
  Future<Either<Failure, CategoriesModel>> update({
    required Categoryy categoryy,
  });

  Future<Either<Failure, ServerSuccess>> delete({
    required String name,
  });
}
