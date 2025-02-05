import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/features/home/data/repos/categorise_repo/categories_repo.dart';

class DeleteCategoryCubit extends BaseCubit<String> {
  final CategoriesRepo categoriseRepo;

  DeleteCategoryCubit(this.categoriseRepo) : super();

  Future<void> delete({
    required String name,
  }) async {
    emitLoading();
    final result = await categoriseRepo.delete(name: name);
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (success) => emitSuccess(success.message),
    );
  }
}
