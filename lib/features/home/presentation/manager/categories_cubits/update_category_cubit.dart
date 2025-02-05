import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/features/home/data/models/categories_model/categories_model.dart';
import 'package:lms_admin/features/home/data/models/categories_model/category.dart';
import 'package:lms_admin/features/home/data/repos/categorise_repo/categories_repo.dart';

class UpdateCategoryCubit extends BaseCubit<CategoriesModel> {
  final CategoriesRepo categoreisRepo;

  UpdateCategoryCubit(this.categoreisRepo) : super();

  Future<void> updateCategory({
    required Categoryy categoryy,
  }) async {
    emitLoading();
    final result = await categoreisRepo.update(categoryy: categoryy);
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (ad) => emitSuccess(ad),
    );
  }
}
