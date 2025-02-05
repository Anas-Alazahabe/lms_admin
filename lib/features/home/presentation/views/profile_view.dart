import 'package:flutter/material.dart';
import 'package:lms_admin/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';

class ProfileView extends StatelessWidget {
  final SharedPreferencesCubit sharedPreferencesCubit;
  const ProfileView({super.key, required this.sharedPreferencesCubit});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الملف الشخصي'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // const Spacer(),
                CircleAvatar(
                  radius: 50,
                  child: Text(
                    sharedPreferencesCubit.getUsername()![0],
                    style: const TextStyle(fontSize: 40.0, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'الاسم: ${sharedPreferencesCubit.getUsername()}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'اسم الأب: ${sharedPreferencesCubit.getFatherName()}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'اجمالي النقاط: ${sharedPreferencesCubit.getPoints()}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                // const Spacer(),
                Row(
                  children: [
                    const Spacer(),
                    Card(
                        child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('ID:${sharedPreferencesCubit.getId()}'),
                    )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
