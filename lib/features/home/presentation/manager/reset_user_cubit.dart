import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/features/home/data/repos/home_repos/home_repo.dart';

class ResetUserCubit extends BaseCubit<String> {
  final HomeRepo homeRepo;

  ResetUserCubit(this.homeRepo) : super();

  Future<void> reset({
    required String email,
  }) async {
    emitLoading();
    final result = await homeRepo.resetUser(email: email);
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (teacher) => emitSuccess(teacher),
    );
  }
}
