import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/features/home/data/repos/home_repos/home_repo.dart';

class DeleteUserCubit extends BaseCubit<String> {
  final HomeRepo homeRepo;

  DeleteUserCubit(this.homeRepo) : super();

  Future<void> deleteUser({
    required String userId,
  }) async {
    emitLoading();
    final result = await homeRepo.deleteUser(userId: userId);
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (teacher) => emitSuccess(teacher),
    );
  }
}
