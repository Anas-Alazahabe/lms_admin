import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/utils/app_router.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/my_search.dart';

class HomeViewBodyHeader extends StatelessWidget {
  final VoidCallback action;
  const HomeViewBodyHeader({
    super.key,
    // required this.rand,
    required this.action,
  });

  // final int rand;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 60,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: InkWell(
                      onTap: action,
                      child: const Image(
                        image: AssetImage('assets/images/logoIcon.png'),
                        // width: 280,
                        //height: 280,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.push(AppRouter.kHomeView);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    kAppName,
                    style: AppStyles.titleStyle,
                  ),
                ),
              ),

//Search
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 5),
                width: MediaQuery.of(context).size.width / 3,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GestureDetector(
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Icon(Icons.search),
                      Text(
                        'Search',
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),

                  // splashColor: Color.fromARGB(255, 241, 246, 249),
                  // hoverDuration: Duration(seconds: 1),
                  //  highlightColor: Color.fromARGB(255, 241, 246, 249),
                  // hoverColor: Color.fromARGB(255, 241, 246, 249),
                  onTap: () {
                    showSearch(context: context, delegate: MySearch());
                  },
                ),
              ),

              //     GestureDetector(
              //   child: Container(
              //     color: Colors.red,
              //     child: const Text('search'),
              //   ),
              //   onTap: () {
              //     showSearch(
              //         context: context,
              //         delegate: MySearch()); // replace this with your actual data
              //   },
              // ),
            ],
          ),
        ),
        // const SizedBox(
        //   width: double.infinity,
        //   child: Padding(
        //     padding: EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 20),
        //     child: Text(
        //       '    says[rand],',
        //       style: TextStyle(fontSize: 16),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
