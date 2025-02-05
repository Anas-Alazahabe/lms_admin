import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_admin/core/utils/app_router.dart';
import 'package:lms_admin/features/auth/data/models/user_model/user.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
    required this.sharedPreferencesCubit,
  });

  final SharedPreferencesCubit sharedPreferencesCubit;

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<User>(kUser);
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(sharedPreferencesCubit.getUsername() ??
                box.values.first
                    .name!), // Replace 'Username' with the actual username
            accountEmail: null, // Replace with the actual user email
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                sharedPreferencesCubit.getUsername() != null
                    ? sharedPreferencesCubit.getUsername()![0]
                    : box.values.first.name!.characters.first,
                style: const TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          if (sharedPreferencesCubit.getUsername() != null)
            Builder(builder: (context) {
              return ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('الملف الشخصي'),
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  context.push(AppRouter.kProfileView,
                      extra: sharedPreferencesCubit);
                },
              );
            }),
          // ListTile(
          //   leading: const Icon(Icons.download),
          //   title: const Text('الملفات المحملة'),
          //   onTap: () {
          //     Scaffold.of(context).closeDrawer();
          //     context.push(
          //       AppRouter.kDownloadVeiw,
          //     );
          //   },
          // ),
          if (sharedPreferencesCubit.getUsername() != null)
            Builder(builder: (context) {
              return ListTile(
                leading: const Icon(Icons.swap_horiz_rounded),
                title: const Text('تبديل الفرع'),
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  context.push(
                    AppRouter.kSpecificationView,
                  );
                },
              );
            }),

          // if (sharedPreferencesCubit.getUsername() == null)
          //   Builder(builder: (context) {
          //     return ListTile(
          //       leading: const Icon(Icons.login),
          //       title: const Text('تسجيل الدخول'),
          //       onTap: () {
          //         Scaffold.of(context).closeDrawer();
          //         context.pop();
          //       },
          //     );
          //   }),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('logout'),
            onTap: () {
              Scaffold.of(context).closeDrawer();
              context.push(
                AppRouter.kOnBoardingView,
              );
            },
          ),
        ],
      ),
    );
  }
}
