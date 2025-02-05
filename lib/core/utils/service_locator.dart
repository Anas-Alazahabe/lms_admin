import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lms_admin/core/cubits/directory_cubit/directory_cubit.dart';
import 'package:lms_admin/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_admin/core/cubits/token_cubit/token_cubit.dart';
import 'package:lms_admin/core/utils/api_service.dart';
import 'package:lms_admin/features/auth/data/repos/auth_repo_impl.dart';
import 'package:lms_admin/features/home/data/repos/ads_repo/ad_repo_impl.dart';
import 'package:lms_admin/features/home/data/repos/categorise_repo/categories_repo_impl.dart';
import 'package:lms_admin/features/home/data/repos/subjects_repo/subjects_repo_impl.dart';
import 'package:lms_admin/features/home/data/repos/home_repos/home_repo_impl.dart';
import 'package:lms_admin/features/subject_data/data/repo/subject_repo_impl.dart';

GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));
  getIt.registerLazySingleton<AuthRepoImpl>(
      () => AuthRepoImpl(getIt<ApiService>()));
  getIt.registerLazySingleton<HomeRepoImpl>(
      () => HomeRepoImpl(getIt<ApiService>()));
  getIt
      .registerLazySingleton<AdRepoImpl>(() => AdRepoImpl(getIt<ApiService>()));

  getIt.registerLazySingleton<CategoriesRepoImpl>(
      () => CategoriesRepoImpl(getIt<ApiService>()));

  getIt.registerLazySingleton<SubjectsRepoImpl>(
      () => SubjectsRepoImpl(getIt<ApiService>()));

  getIt.registerLazySingleton<SubjectRepoImpl>(
      () => SubjectRepoImpl(getIt<ApiService>()));

  getIt.registerLazySingleton<TokenCubit>(() => TokenCubit());
  getIt.registerLazySingleton<SharedPreferencesCubit>(
      () => SharedPreferencesCubit());
  getIt.registerLazySingleton<DirectoryCubit>(() => DirectoryCubit());

  // getIt.registerLazySingleton<TempDirectoryCubit>(() => TempDirectoryCubit());
  // getIt.registerLazySingleton<AuthorizeCubit>(() => AuthorizeCubit());
}
