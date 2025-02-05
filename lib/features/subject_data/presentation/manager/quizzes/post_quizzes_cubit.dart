import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/features/subject_data/data/models/quizzes_model/quiz.dart';
import 'package:lms_admin/features/subject_data/data/repo/subject_repo.dart';

class PostQuizCubit extends BaseCubit<Quiz> {
  final SubjectRepo subjectRepo;

  PostQuizCubit(this.subjectRepo) : super();

  Future<void> post({
    required Quiz quiz,
  }) async {
    emitLoading();
    final result = await subjectRepo.postQuiz(quiz: quiz);
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (quiz) => emitSuccess(quiz),
    );
  }
}
