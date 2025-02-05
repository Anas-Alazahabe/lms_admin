import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_admin/core/cubits/token_cubit/token_cubit.dart';
import 'package:lms_admin/core/cubits/upload_video_cubit/upload_cubit.dart';
import 'package:lms_admin/core/cubits/upload_file_cubit/upload_cubit.dart';
import 'package:lms_admin/core/utils/app_bloc_observer.dart';
import 'package:lms_admin/core/utils/app_router.dart';
import 'package:lms_admin/core/utils/service_locator.dart';
import 'package:lms_admin/core/utils/size_config.dart';
import 'package:lms_admin/features/auth/data/models/user_model/user.dart';
import 'package:lms_admin/features/home/data/repos/home_repos/home_repo_impl.dart';
import 'package:lms_admin/features/home/presentation/manager/add_user_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/delete_user_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/fetch_users_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/reset_user_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/search_cubits/subjects_seach_cubit.dart';
import 'package:lms_admin/features/subject_data/data/repo/subject_repo_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: kAppColor, // Status bar color
    statusBarIconBrightness: Brightness.light, // Status bar icons' color
  ));

  final tokenCubit = getIt<TokenCubit>();
  // final gradeCubit = getIt<GradeCubit>();
  final sharedPreferencesCubit = getIt<SharedPreferencesCubit>();
  // final tempDirectoryCubit = getIt<TempDirectoryCubit>();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Future.wait([
    // Hive.openBox<VideoState>(kVideoState),
    Hive.openBox<User>(kUser),

    sharedPreferencesCubit.setup(),
    // tokenCubit.deleteSavedToken(),
    tokenCubit.fetchSavedToken(),
    // tempDirectoryCubit.fetchDocsTempDir(),
    EasyLocalization.ensureInitialized(),
  ]);

  final router = AppRouter.setupRouter(
      tokenCubit.state, sharedPreferencesCubit.getGrade());
  Bloc.observer = AppBlocObserver();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('ar', 'AE'), Locale('en', 'US')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar', 'AE'),
        startLocale: const Locale('en', 'US'),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<SharedPreferencesCubit>(),
            ),
            BlocProvider(
                create: (context) => SearchSubjectsCubit(
                      getIt<HomeRepoImpl>(),
                    )),
            BlocProvider(
                create: (context) => UploadCubit(
                      getIt<SubjectRepoImpl>(),
                    )),
            BlocProvider(
                create: (context) => UploadFileCubit(
                      getIt<SubjectRepoImpl>(),
                    )),
            BlocProvider(
                create: (context) => CreateUserWebCubit(
                      getIt<HomeRepoImpl>(),
                    )),
            BlocProvider(
                create: (context) => FetchUsers(
                      getIt<HomeRepoImpl>(),
                    )),
            BlocProvider(
                create: (context) => DeleteUserCubit(
                      getIt<HomeRepoImpl>(),
                    )),
            BlocProvider(
                create: (context) => ResetUserCubit(
                      getIt<HomeRepoImpl>(),
                    )),
            //   BlocProvider(create: (context) => getIt<DirectoryCubit>(),),
          ],
          child: ProviderScope(
            child: LMSApp(
              router: router,
            ),
          ),
        )),
  );
}

class LMSApp extends StatelessWidget {
  final GoRouter router;
  const LMSApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: false,
        // fontFamily: 'Marhey',
      ).copyWith(
          appBarTheme: const AppBarTheme(
            color: kAppColor,
          ),

          iconTheme: const IconThemeData(
            color: kAppColor,
          ),

          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Color(0xff0F0961),
          ),
          scaffoldBackgroundColor: const Color(0xfff4f6fa),
          colorScheme: ColorScheme.fromSeed(seedColor: kAppColor)),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
