import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/core/utils/assets.dart';
import 'package:lms_admin/features/auth/data/models/user_model/user.dart';
import 'package:lms_admin/features/home/data/models/search_result_model/search_result_model.dart';
import 'package:lms_admin/features/home/presentation/manager/search_cubits/subjects_seach_cubit.dart';

class MySearch extends SearchDelegate<String> {
  var box = Hive.box<User>(kUser);
  int index = 0;

  MySearch();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    context
        .read<SearchSubjectsCubit>()
        .search(yearId: box.values.first.yearId, name: query);
    return BlocBuilder<SearchSubjectsCubit, BaseState>(
      builder: (context, state) {
        if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is Failure) {
          return Text('Error: ${state.errorMessage}');
        } else if (state is Success<SearchResultModel>) {
          return buildSearchResults(state, index);
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
// Use BlocBuilder to rebuild the UI based on cubit state
    context
        .read<SearchSubjectsCubit>()
        .search(yearId: box.values.first.yearId, name: query);

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 4.0, // gap between lines
              children: [
                ChoiceChip(
                  label: const Text('Subjects'),
                  selected: index == 0,
                  onSelected: (selected) {
                    setState(() {
                      index = 0;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('مدرسين'),
                  selected: index == 1,
                  onSelected: (selected) {
                    setState(() {
                      index = 1;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('وحدات'),
                  selected: index == 2,
                  onSelected: (selected) {
                    setState(() {
                      index = 2;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('دروس'),
                  selected: index == 3,
                  onSelected: (selected) {
                    setState(() {
                      index = 3;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('مواد'),
                  selected: index == 4,
                  onSelected: (selected) {
                    setState(() {
                      index = 4;
                    });
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 200.0),
              child: BlocBuilder<SearchSubjectsCubit, BaseState>(
                builder: (context, state) {
                  if (state is Loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is Failure) {
                    return Text('Error: ${state.errorMessage}');
                  } else if (state is Success<SearchResultModel>) {
                    return buildSearchResults(state, index);
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildSearchResults(Success<SearchResultModel> state, int index) {
    final subjetcsResults = state.data.subjects;
    final lessonsResults = state.data.lessons;
    final teachersResults = state.data.teachers;
    final unitsResults = state.data.units;
    final categoriesResults = state.data.categories;

    final List<Widget> widgets = [
      ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) => ListTile(
            title: Container(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          height: 70,
          child: Card(
            elevation: 1,
            color: Colors.grey[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    AssetsData.logo,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(subjetcsResults[index].name!),
                onTap: () {
                  // Handle tap
                },
              ),
            ),
          ),
        )

            // Text(
            //   subjetcsResults[index].name!,
            //   style: TextStyle(color: Colors.red),
            // ),
            ),
        itemCount: subjetcsResults!.length,
      ),
      ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) => ListTile(
          title: Text(lessonsResults[index].name!),
        ),
        itemCount: lessonsResults!.length,
      ),
      ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) => ListTile(
          title: Text(teachersResults[index].name!),
        ),
        itemCount: teachersResults!.length,
      ),
      ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) => ListTile(
          title: Text(unitsResults[index].name!),
        ),
        itemCount: unitsResults!.length,
      ),
      ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) => ListTile(
          title: Text(categoriesResults[index].category!),
        ),
        itemCount: categoriesResults!.length,
      ),
    ];

    return widgets[index];
  }
}
