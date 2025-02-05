import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/features/home/data/models/categories_model/categories_model.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/subject.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/subjects_model.dart';
// import 'package:lms_admin/features/home/data/models/subjects_model/subjects_model.dart';

import 'package:lms_admin/features/home/data/repos/categorise_repo/categories_repo.dart';
import 'package:lms_admin/features/home/data/repos/subjects_repo/subjects_repo.dart';

class FetchSubjectsCubit extends BaseCubit<SubjectsModel> {
  final SubjectsRepo subjectsRepo;

  FetchSubjectsCubit(this.subjectsRepo) : super();

  Future<void> fetch({
    required int? categoryId,
    required int? yearId,
    // required Subject subject,
  }) async {
    emitLoading();
    final result = await subjectsRepo.fetch(
      categoryId: categoryId,
      yearId: yearId,
      // subject: subject
    );
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (subjects) => emitSuccess(subjects),
    );
  }
}
