import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/features/home/data/models/categories_model/categories_model.dart';
import 'package:lms_admin/features/home/data/models/categories_model/category.dart';
import 'package:lms_admin/features/home/data/repos/categorise_repo/categories_repo.dart';

class PostCategoryCubit extends BaseCubit<CategoriesModel> {
  final CategoriesRepo categoriseRepo;

  PostCategoryCubit(this.categoriseRepo) : super();

  Future<void> post({
    required Categoryy categoryy,
  }) async {
    emitLoading();
    final result = await categoriseRepo.post(category: categoryy);
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (categoryy) => emitSuccess(categoryy),
    );
  }
}
