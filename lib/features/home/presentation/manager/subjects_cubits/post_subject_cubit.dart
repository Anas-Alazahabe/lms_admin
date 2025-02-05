import 'package:bloc/bloc.dart';
import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/subject.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/subjects_model.dart';
import 'package:lms_admin/features/home/data/repos/subjects_repo/subjects_repo.dart';

class PostSubjectCubit extends BaseCubit<SubjectsModel> {
  final SubjectsRepo subjectsRepo;

  PostSubjectCubit(this.subjectsRepo) : super();

  Future<void> post({
    required Subject subject,
  }) async {
    emitLoading();
    final result = await subjectsRepo.post(subject: subject);
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (subjet) => emitSuccess(subjet),
    );
  }
}
