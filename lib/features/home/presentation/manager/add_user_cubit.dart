import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/features/home/data/repos/home_repos/home_repo.dart';

class CreateUserWebCubit extends BaseCubit<bool> {
  final HomeRepo homeRepo;

  CreateUserWebCubit(this.homeRepo) : super();

  Future<void> createUserWeb({
    required String email,
    required String roleId,
  }) async {
    emitLoading();
    final result = await homeRepo.createUser(email: email, roleId: roleId);
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (teacher) => emitSuccess(teacher),
    );
  }
}
