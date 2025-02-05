import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/unit.dart';
import 'package:lms_admin/features/subject_data/data/repo/subject_repo.dart';

class UnitsCubit extends BaseCubit<Unitt> {
  final SubjectRepo subjectRepo;

  UnitsCubit(this.subjectRepo) : super();

  Future<void> fetchUnits({required String? subjectId}) async {
    emitLoading();
    final result = await subjectRepo.fetchUnits(subjectId: subjectId);
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (units) => emitSuccess(units),
    );
  }
}
