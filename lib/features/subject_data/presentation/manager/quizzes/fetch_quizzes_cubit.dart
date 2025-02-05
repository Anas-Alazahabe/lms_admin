import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/features/subject_data/data/models/quizzes_model/quizzes_model.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/unit.dart';
import 'package:lms_admin/features/subject_data/data/repo/subject_repo.dart';

class FetchQuizzesCubit extends BaseCubit<QuizzesModel> {
  final SubjectRepo subjectRepo;

  FetchQuizzesCubit(this.subjectRepo) : super();

  Future<void> fetchQuizzes(
      {required String? subjectId,
      required String? type,
      required String? typeId}) async {
    emitLoading();
    final result = await subjectRepo.fetchQuizzes(
        subjectId: subjectId, type: type, typeId: typeId);
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (quizzes) => emitSuccess(quizzes),
    );
  }
}
