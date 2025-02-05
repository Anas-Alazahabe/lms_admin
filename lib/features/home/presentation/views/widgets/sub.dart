import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/subjects_model.dart';
import 'package:lms_admin/features/home/presentation/manager/subjects_cubits/fetch_subjecct_cubit.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/subjects/subjects_widgets/subjects_list.dart';

class AnotherScreen extends StatelessWidget {
  final int? categoryId;
  const AnotherScreen({Key? key, required this.categoryId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          BlocConsumer<FetchSubjectsCubit, BaseState>(
            listener: (context, state) {
              if (state is Success<SubjectsModel>) {
                // state.data.dataa!
                // .asMap()
                // .map((key, value) => MapEntry(

                // key,
                // value.category!.id ==2 ?
                //   subjects = value.subjects!
                // :null

                // )).values;
                // subjectss = state.data.dataa!;
                // print(widget.categoryId);
                // subjects= subjectss[1].subjects!;
                // // print(subjectss);
                // print(subjects);
              }
            },
            builder: (context, state) {
              if (state is Loading) {
                // print('object loading');
                return const CustomLoading();
              }
              if (state is Success<SubjectsModel>) {
                return Scaffold(
                    // appBar: AppBar(
                    //   title: const Text('Another Screen'),
                    // ),
                    // body: SubjectsList(categoryId: categoryId,),
                    );
              }

              return Container();
            },
          ),
        ],
      ),
    );
  }
}

//  Scaffold(
//       // appBar: AppBar(
//       //   title: const Text('Another Screen'),
//       // ),
//       body: SubjectsList(categoryId: categoryId,),
//     )
