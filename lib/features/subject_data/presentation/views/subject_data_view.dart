import 'package:flutter/material.dart';
import 'package:lms_admin/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_admin/core/utils/service_locator.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/subject.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/home_drawer.dart';
import 'package:lms_admin/features/subject_data/presentation/views/widgets/subject_data_view_body.dart';

class SubjectDataView extends StatelessWidget {
  final Subject subject;
  const SubjectDataView({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    final savedData = getIt<SharedPreferencesCubit>();
    return SafeArea(
      child: Scaffold(
        drawer: HomeDrawer(sharedPreferencesCubit: savedData),
        body: SubjectDataViewBody(
          subject: subject,
        ),
      ),
    );
  }
}
