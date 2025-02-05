import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_admin/core/utils/service_locator.dart';
import 'package:lms_admin/features/auth/data/repos/auth_repo_impl.dart';
import 'package:lms_admin/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:lms_admin/features/auth/presentation/manager/forgot_password_code_and_email_cubit/forgot_password_code_and_email_cubit.dart';
import 'package:lms_admin/features/auth/presentation/manager/forgot_password_email_cubit/forgot_password_email_cubit.dart';
import 'package:lms_admin/features/auth/presentation/manager/new_password_cubit/new_password_cubit.dart';
import 'package:lms_admin/features/auth/presentation/manager/resend_email_cubit/resend_email_cubit.dart';
import 'package:lms_admin/features/auth/presentation/manager/verify_user_cubit/verify_user_cubit.dart';
import 'package:lms_admin/features/auth/presentation/views/onboarding_view.dart';
import 'package:lms_admin/features/home/data/models/categories_model/category.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/subject.dart';
import 'package:lms_admin/features/home/data/repos/ads_repo/ad_repo_impl.dart';
import 'package:lms_admin/features/home/data/repos/categorise_repo/categories_repo_impl.dart';
import 'package:lms_admin/features/home/data/repos/subjects_repo/subjects_repo_impl.dart';
// import 'package:lms_admin/features/home/data/models/subjects_model/datum_subjects.dart';
import 'package:lms_admin/features/home/presentation/manager/ads_cubits/fetch_ads_cubit/fetch_ads_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/categories_cubits/fetch_category_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/subjects_cubits/delete_subject_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/subjects_cubits/fetch_subjecct_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/subjects_cubits/post_subject_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/subjects_cubits/update_subject_cubit.dart';
import 'package:lms_admin/features/home/presentation/views/ads_view.dart';
import 'package:lms_admin/features/home/presentation/views/home_view.dart';
import 'package:lms_admin/features/home/presentation/views/profile_view.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/profileView.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/subjects/subjects_widgets/subjects_list.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/years/years_widget.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/lesson.dart';
import 'package:lms_admin/features/subject_data/data/repo/subject_repo_impl.dart';
import 'package:lms_admin/features/subject_data/presentation/manager/comment_cubit/reply_cubit.dart';
import 'package:lms_admin/features/subject_data/presentation/manager/comments_cubit/comments_cubit.dart';
import 'package:lms_admin/features/subject_data/presentation/manager/post_lesson_cubit.dart';
import 'package:lms_admin/features/subject_data/presentation/manager/post_unit_cubit.dart';
import 'package:lms_admin/features/subject_data/presentation/manager/quizzes/fetch_quizzes_cubit.dart';
import 'package:lms_admin/features/subject_data/presentation/manager/units_cubit.dart';
import 'package:lms_admin/features/subject_data/presentation/views/comments_view.dart';
import 'package:lms_admin/features/subject_data/presentation/views/lesson_view.dart';
import 'package:lms_admin/features/subject_data/presentation/views/subject_data_view.dart';

abstract class AppRouter {
  static const kOnBoardingView = '/onBoardingView';
  static const kHomeView = '/homeView';
  static const kCoursesView = '/CoursesView';
  static const kSubjectView = '/homeView/subjectView';
  static const kSubjectViewCatEdu = '/homeView/subjectViewCatEdu';
  static const kVideoView = '/videoView';
  static const kSubjectDataView = '/subjectDataView';
  static const kQuizView = '/quizView';
  static const kQuizSummery = '/quizSummery';
  static const kQuizResults = '/quizResults';
  static const kLessonView = '/lessonView';
  static const kCommentsView = '/commentsRoomView';
  //static const kSettingsView = '/homeView/settingsView';
  static const kProfileView = '/homeView/profileView';
  static const kSpecificationView = '/homeView/specificationView';
  static const kDownloadVeiw = '/downloadVeiw';
  static const kSubjectsListView = '/subjectsListView';
  static const kAdsView = '/homeView/AdsView';
  static const kProfileDataView = '/profileView';

  static GoRouter setupRouter(String? token, String? gradeId) {
    return GoRouter(routes: [
      if (token == null)
        GoRoute(
          path: '/',
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AuthCubit(getIt<AuthRepoImpl>()),
              ),
              BlocProvider(
                create: (context) => getIt<SharedPreferencesCubit>(),
              ),
              BlocProvider(
                create: (context) => VerifyUserCubit(getIt<AuthRepoImpl>()),
              ),
              BlocProvider(
                create: (context) =>
                    ForgotPasswordEmailCubit(getIt<AuthRepoImpl>()),
              ),
              BlocProvider(
                create: (context) =>
                    ForgotPasswordCodeAndEmailCubit(getIt<AuthRepoImpl>()),
              ),
              BlocProvider(
                create: (context) => NewPasswordCubit(getIt<AuthRepoImpl>()),
              ),
              BlocProvider(
                create: (context) => ResendEmailCubit(getIt<AuthRepoImpl>()),
              ),
            ],
            child: const AuthView(),
          ),
        ),
      if (token != null)
        GoRoute(
          path: '/',
          builder: (context, state) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (context) => FetchAdsCubit(getIt<AdRepoImpl>())),

                // BlocProvider(
                //     create: (context) => PostAdCubit(getIt<AdRepoImpl>())),

                BlocProvider(
                    create: (context) =>
                        FetchCategoriesCubit(getIt<CategoriesRepoImpl>())),

                BlocProvider(
                    create: (context) =>
                        FetchSubjectsCubit(getIt<SubjectsRepoImpl>())),

                // BlocProvider(
                //     create: (context) =>
                //         PostCategoryCubit(getIt<CategoriesRepoImpl>())),
                //  BlocProvider(
                //       create: (context) => DeleteCategoryCubit(getIt<CategoriseRepoImpl>())),
              ],
              child: const HomeView(
                  // gradeId: gradeId ?? state.extra as String,
                  ),
            );
          },
        ),

      GoRoute(
        path: kOnBoardingView,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthCubit(getIt<AuthRepoImpl>()),
            ),
            BlocProvider(
              create: (context) => getIt<SharedPreferencesCubit>(),
            ),
            BlocProvider(
              create: (context) => VerifyUserCubit(getIt<AuthRepoImpl>()),
            ),
            BlocProvider(
              create: (context) =>
                  ForgotPasswordEmailCubit(getIt<AuthRepoImpl>()),
            ),
            BlocProvider(
              create: (context) =>
                  ForgotPasswordCodeAndEmailCubit(getIt<AuthRepoImpl>()),
            ),
            BlocProvider(
              create: (context) => NewPasswordCubit(getIt<AuthRepoImpl>()),
            ),
            BlocProvider(
              create: (context) => ResendEmailCubit(getIt<AuthRepoImpl>()),
            ),
          ],
          child: const AuthView(),
        ),
      ),

      GoRoute(
        path: kAdsView,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) =>
                    FetchCategoriesCubit(getIt<CategoriesRepoImpl>())),
            BlocProvider(
                create: (context) => FetchAdsCubit(getIt<AdRepoImpl>())),
          ],
          child: const AdsView(),
        ),
      ),

      GoRoute(
        path: kHomeView,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => FetchAdsCubit(getIt<AdRepoImpl>())),
              // BlocProvider(
              //     create: (context) => PostAdCubit(getIt<AdRepoImpl>())),
              BlocProvider(
                  create: (context) =>
                      FetchCategoriesCubit(getIt<CategoriesRepoImpl>())),

              BlocProvider(
                  create: (context) =>
                      FetchSubjectsCubit(getIt<SubjectsRepoImpl>())),

              BlocProvider(
                  create: (context) =>
                      PostSubjectCubit(getIt<SubjectsRepoImpl>())),

              // BlocProvider(
              //     create: (context) =>
              //         PostCategoryCubit(getIt<CategoriesRepoImpl>())),

              // BlocProvider(
              //       create: (context) => ),
            ],
            child: const HomeView(
                // gradeId: state.extra as String,
                ),
          );
        },
      ),


      
      GoRoute(
        path: kProfileDataView,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => FetchAdsCubit(getIt<AdRepoImpl>())),
              // BlocProvider(
              //     create: (context) => PostAdCubit(getIt<AdRepoImpl>())),
              BlocProvider(
                  create: (context) =>
                      FetchCategoriesCubit(getIt<CategoriesRepoImpl>())),

              BlocProvider(
                  create: (context) =>
                      FetchSubjectsCubit(getIt<SubjectsRepoImpl>())),

              BlocProvider(
                  create: (context) =>
                      PostSubjectCubit(getIt<SubjectsRepoImpl>())),

              // BlocProvider(
              //     create: (context) =>
              //         PostCategoryCubit(getIt<CategoriesRepoImpl>())),

              // BlocProvider(
              //       create: (context) => ),
            ],
            child: ProfileDataView(),
          );
        },
      ),



   GoRoute(
        path: kCommentsView,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
                  create: (context) => CommentsCubit(getIt<SubjectRepoImpl>()),
                ),
                BlocProvider(
                  create: (context) => ReplyCubit(getIt<SubjectRepoImpl>()),
                ),
          ],
          child: CommentsView(
            lessonId: state.extra! as String,
          ),
        ),
      ),

      GoRoute(
        path: kSubjectViewCatEdu, // Define the new route
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>;
          final categoryId = extras['categoryId']!;
          final categoryy = extras['category'] as Categoryy;
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) =>
                      FetchSubjectsCubit(getIt<SubjectsRepoImpl>())),
              BlocProvider(
                  create: (context) =>
                      PostSubjectCubit(getIt<SubjectsRepoImpl>())),
            ],
            child: YearsList(
              categoryId: categoryId,
              categoryy: categoryy,
            ), // Pass the categoryId to SubjectsList
          );
        },
      ),

      GoRoute(
        path: kSubjectView, // Define the new route
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>;
          final categoryId = extras['categoryId']!;
          final yearId = extras['yearId'];
          final categoryy = extras['category'] as Categoryy;

          // final categoryId = state.extra as int ;
          // final yearId = state.extra as int

          // Get the categoryId from the navigation
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) =>
                      FetchSubjectsCubit(getIt<SubjectsRepoImpl>())),
              BlocProvider(
                  create: (context) =>
                      PostSubjectCubit(getIt<SubjectsRepoImpl>())),
              BlocProvider(
                  create: (context) =>
                      UpdateSubjectCubit(getIt<SubjectsRepoImpl>())),
              BlocProvider(
                  create: (context) =>
                      DeleteSubjectCubit(getIt<SubjectsRepoImpl>())),
            ],
            child: SubjectsList(
              categoryId: categoryId,
              yearId: yearId,
              categoryy: categoryy,
            ), // Pass the categoryId to SubjectsList
          );
        },
      ),

      GoRoute(
        path: kSubjectDataView,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => PostUnitCubit(getIt<SubjectRepoImpl>())),
              BlocProvider(
                  create: (context) =>
                      PostLessonCubit(getIt<SubjectRepoImpl>())),
              BlocProvider(
                  create: (context) => UnitsCubit(
                        getIt<SubjectRepoImpl>(),
                      )),
              BlocProvider(
                  create: (context) => FetchQuizzesCubit(
                        getIt<SubjectRepoImpl>(),
                      )),
            ],
            child: SubjectDataView(
              subject: state.extra as Subject,
            ),
          );
        },
      ),

      GoRoute(
          path: kLessonView,
          builder: (context, state) {
            final Map<String, dynamic> extras =
                state.extra as Map<String, dynamic>;
            final Lesson lesson = extras['lesson'];
            final String subjectName = extras['subjectName'];
            final String unitName = extras['unitName'];
            final String subjectId = extras['subject_id'];
            return MultiBlocProvider(
providers: [

BlocProvider(
  create: (context)  => FetchQuizzesCubit(
                        getIt<SubjectRepoImpl>(),
                      ),
),

      BlocProvider(
              create: (context) => CommentsCubit(getIt<SubjectRepoImpl>()),
            ),
            BlocProvider(
              create: (context) => ReplyCubit(getIt<SubjectRepoImpl>()),
            ),
],

              child: LessonView(
                subjectName: subjectName,
                lesson: lesson,
                unitName: unitName,
                subjectId: subjectId,
              ),
            );
          }),

      GoRoute(
        path: kProfileView,
        builder: (context, state) {
          return ProfileView(
            sharedPreferencesCubit: state.extra as SharedPreferencesCubit,
          );
        },
      ),
    ]);
  }
}
