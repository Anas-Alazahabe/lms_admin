import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/features/home/data/repos/subjects_repo/subjects_repo.dart';
// import 'package:lms_admin/features/home/data/repos/categorise_repo/categories_repo.dart';

class DeleteSubjectCubit extends BaseCubit<String> {
  final SubjectsRepo subjectsRepo;

  DeleteSubjectCubit(this.subjectsRepo) : super();

  Future<void> delete({
    required String id,
  }) async {
    emitLoading();
    final result = await subjectsRepo.delete(id: id);
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (success) => emitSuccess(success),
    );
  }
}
