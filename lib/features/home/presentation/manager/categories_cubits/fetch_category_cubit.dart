import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/features/home/data/models/categories_model/categories_model.dart';
import 'package:lms_admin/features/home/data/repos/categorise_repo/categories_repo.dart';

class FetchCategoriesCubit extends BaseCubit<CategoriesModel> {
  final CategoriesRepo categoriseRepo;

  FetchCategoriesCubit(this.categoriseRepo) : super();

  Future<void> fetch() async {
    emitLoading();
    final result = await categoriseRepo.fetch();
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (categories) => emitSuccess(categories),
    );
  }
}
