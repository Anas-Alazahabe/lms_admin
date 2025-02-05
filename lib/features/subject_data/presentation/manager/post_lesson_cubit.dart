import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/lesson.dart';
import 'package:lms_admin/features/subject_data/data/repo/subject_repo.dart';

class PostLessonCubit extends BaseCubit<Lesson> {
  final SubjectRepo subjectRepo;

  PostLessonCubit(this.subjectRepo) : super();

  Future<void> post({
    required Lesson lesson,
  }) async {
    emitLoading();
    final result = await subjectRepo.postLesson(lesson: lesson);
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (lesson) => emitSuccess(lesson),
    );
  }
}
