import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/features/home/data/models/users_model/users_model.dart';
import 'package:lms_admin/features/home/data/repos/home_repos/home_repo.dart';

class FetchUsers extends BaseCubit<UsersModel> {
  final HomeRepo homeRepo;

  FetchUsers(this.homeRepo) : super();

  Future<void> fetchUser() async {
    emitLoading();
    final result = await homeRepo.fetchAllUsers();
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (teacher) => emitSuccess(teacher),
    );
  }
}
