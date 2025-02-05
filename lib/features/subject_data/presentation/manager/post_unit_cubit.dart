import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/unit.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/unit_data.dart';
import 'package:lms_admin/features/subject_data/data/repo/subject_repo.dart';

class PostUnitCubit extends BaseCubit<Unitt> {
  final SubjectRepo subjectRepo;

  PostUnitCubit(this.subjectRepo) : super();

  Future<void> post({
    required UnitData unit,
  }) async {
    emitLoading();
    final result = await subjectRepo.postUnit(unit: unit);
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (unit) => emitSuccess(unit),
    );
  }
}
