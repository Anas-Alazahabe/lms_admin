import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSubjectsListView extends StatelessWidget {
  const ShimmerSubjectsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Shimmer.fromColors(
              baseColor: Colors.black12,
              highlightColor: Colors.white,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.height * 0.13,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
              )),
        );
      },
    );
  }
}
