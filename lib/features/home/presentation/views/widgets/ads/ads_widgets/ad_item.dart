import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';
import 'package:lms_admin/features/home/data/models/ad_model/ad.dart';
import 'package:lms_admin/features/home/presentation/manager/ads_cubits/delete_ad_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/ads_cubits/set_ad_expired_cubit.dart';
import 'package:lms_admin/features/home/presentation/views/widgets/ads/ads_functions/ad_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../../core/widgets/custom_network_image.dart';

class AdItem extends StatefulWidget {
  const AdItem({
    super.key,
    required this.ad,
    required this.onUpdateAd,
    required this.onSetExpired,
    required this.onDelete,
  });
  final Ad ad;
  final void Function(Ad) onUpdateAd;
  final void Function(Ad) onSetExpired;
  final void Function(Ad) onDelete;

  @override
  State<AdItem> createState() => _AdItemState();
}

class _AdItemState extends State<AdItem> {
  bool _isHovering = false;
  void _onHover(bool isHovering) {
    setState(() {
      _isHovering = isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 300,
        height: _isHovering ? 270 : 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child:
                    // CustomNetworkImage(
                    //     url: '$kBaseUrlAsset${widget.ad.imageUrl}')
                    Image.asset(
                  'assets/images/adimage.png',
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 160,
              left: 20,
              right: 20,
              child: Text(
                widget.ad.title!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Positioned(
              top: 190,
              left: 20,
              right: 20,
              child: AnimatedOpacity(
                opacity: _isHovering ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Column(
                  children: [
                    Text(
                      widget.ad.description!,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // TextButton(onPressed: () {}, child: Icon(Icons.delete)),

                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            adDialog(context, (editedAd) {
                              widget.onUpdateAd(editedAd);
                            }, widget.ad);
                          },
                        ),

                        BlocConsumer<DeleteAdCubit, BaseState>(
                          listener: (context, state) {
                            if (state is Success) {
                              widget.onDelete(widget.ad);
                            }
                          },
                          builder: (context, state) {
                            if (state is Loading) {
                              return const CustomLoading();
                            }
                            return IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                BlocProvider.of<DeleteAdCubit>(context)
                                    .deleteAd(adId: widget.ad.id.toString());
                              },
                            );
                          },
                        ),

                        // TextButton(
                        //     onPressed: () {
                        //       adDialog(context, (editedAd) {
                        //         widget.onUpdateAd(editedAd);
                        //       }, widget.ad);
                        //     },
                        //     child: Icon(Icons.edit)),
                        // TextButton(onPressed: () {}, child: Icon(Icons.timer)),

                        BlocConsumer<SetAdExpiredCubit, BaseState>(
                          listener: (context, state) {
                            if (state is Success) {
                              widget.onSetExpired(widget.ad);
                            }
                          },
                          builder: (context, state) {
                            if (state is Loading) {
                              return const CustomLoading();
                            }
                            return IconButton(
                              icon: const Icon(Icons.timer),
                              onPressed: () {
                                BlocProvider.of<SetAdExpiredCubit>(context)
                                    .setAdExpired(
                                        adId: widget.ad.id.toString());
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              left: 20,
              right: 20,
              child: AnimatedOpacity(
                opacity: !_isHovering ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: const Column(
                  children: [
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('View More'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )

        // MouseRegion(
        //   onEnter: (_) {
        //     setState(() {
        //       _isHovering = true;
        //     });
        //   },
        //   onExit: (_) {
        //     setState(() {
        //       _isHovering = false;
        //     });
        //   },
        //   child: AnimatedContainer(
        //     duration: Duration(milliseconds: 200),
        //     width: 250,
        //     height: 300,
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(12),
        //       boxShadow: _isHovering
        //           ? [
        //               BoxShadow(
        //                   color: Colors.black26, blurRadius: 10, spreadRadius: 2)
        //             ]
        //           : [],
        //     ),
        //     child: Column(
        //       children: [
        //         ClipRRect(
        //           borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        //           child: Image.asset(
        //             'assets/images/adimage.png',
        //             width: 250,
        //             height: 150,
        //             fit: BoxFit.cover,
        //           ),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Text(
        //             widget.ad.title!,
        //             style:
        //                 const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        //           ),
        //         ),
        //         if (_isHovering) ...[
        //           Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(widget.ad.description!,
        //                     style: TextStyle(color: Color(0xFF555555))),
        //               ],
        //             ),
        //           ),
        //           Row(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               TextButton(onPressed: () {}, child: Icon(Icons.delete)),
        //               TextButton(onPressed: () {}, child: Icon(Icons.edit)),
        //               TextButton(onPressed: () {}, child: Icon(Icons.timer)),

        //               // Text('Free', style: TextStyle(color: Colors.green)),
        //             ],
        //           ),
        //         ] else ...[
        //           const Spacer(),
        //           const Divider(
        //             color: Colors.grey, // Change the color of the line
        //             thickness: 1, // Change the thickness of the line
        //             indent: 20, // Add indent from the left
        //             endIndent: 20, // Add indent from the right
        //           ),
        //           const Padding(
        //             padding: EdgeInsets.all(8.0),
        //             child: Text(
        //               'View More',
        //               style: TextStyle(
        //                   color: Colors.black54, fontWeight: FontWeight.bold),
        //             ),
        //           ),
        //         ],
        //       ],
        //     ),
        //   ),
        // );

        // MouseRegion(
        //   onEnter: (value) {
        //     setState(() {
        //       isHovered = true;
        //     });
        //   },
        //   onExit: (value) {
        //     setState(() {
        //       isHovered = false;
        //     });
        //   },
        //   child: Card(
        //     elevation: 2,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(8),
        //     ),
        //     child: Stack(
        //       children: [
        //         Container(
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(8),
        //           ),
        //           height: 140,
        //           width: double.infinity,
        //           child: ClipRRect(
        //             borderRadius: BorderRadius.circular(8),
        //             child: Image.asset(
        //               'assets/images/adimage.png',
        //               fit: BoxFit.cover,
        //             ),
        //           ),
        //         ),

        //         // Container(
        //         //   decoration:
        //         //       BoxDecoration(borderRadius: BorderRadius.circular(12)),
        //         //   height: 140,
        //         //   width: double.infinity,
        //         //   child: ClipRRect(
        //         //     child: Image.asset(
        //         //       'assets/images/adimage.png',
        //         //       // width: 20,
        //         //       // height: 20,
        //         //       fit: BoxFit.fill,
        //         //     ),
        //         //   ),
        //         // ),

        //         AnimatedPositioned(
        //           duration: const Duration(milliseconds: 775),
        //           curve: Curves.easeOut,
        //           //move to up
        //           bottom: isHovered ? -50.0 : -100.0,
        //           child: SizedBox(
        //             height: 250.0,
        //             width: 230,
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   widget.ad.title!,
        //                   // textAlign: TextAlign.center,
        //                   style: GoogleFonts.quicksand(
        //                     fontSize: 24.0,
        //                     fontWeight: FontWeight.w600,
        //                     color: Colors.black,
        //                   ),
        //                 ),

        //                 const SizedBox(
        //                   height: 5.0,
        //                 ),
        //                 AnimatedOpacity(
        //                   opacity: isHovered ? 1.0 : 0.0,
        //                   duration: isHovered
        //                       ? const Duration(milliseconds: 575)
        //                       : const Duration(milliseconds: 375),
        //                   curve: isHovered ? Curves.easeInOutBack : Curves.easeOut,
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       Text(
        //                         widget.ad.description!,
        //                         style: GoogleFonts.quicksand(
        //                           fontSize: 16.0,
        //                           fontWeight: FontWeight.w400,
        //                           color: Colors.black,
        //                         ),
        //                       ),
        //                       // const SizeButton(
        //                       //   value: '7',
        //                       // ),
        //                       // const SizeButton(
        //                       //   value: '8',
        //                       // ),
        //                       // const SizeButton(
        //                       //   value: '9',
        //                       // ),
        //                       // const SizeButton(
        //                       //   value: '10',
        //                       // ),
        //                     ],
        //                   ),
        //                 ),
        //                 const SizedBox(
        //                   height: 5.0,
        //                 ),
        //                 // AnimatedOpacity(
        //                 //   opacity: isHovered ? 1.0 : 0.0,
        //                 //   duration: isHovered
        //                 //       ? const Duration(milliseconds: 975)
        //                 //       : const Duration(milliseconds: 375),
        //                 //   curve:
        //                 //   isHovered ? Curves.easeInOutBack : Curves.easeOut,
        //                 //   child: Row(
        //                 //     mainAxisAlignment: MainAxisAlignment.center,
        //                 //     children: [
        //                 //       //update
        //                 //       Text(
        //                 //         'Update ',
        //                 //         style: GoogleFonts.quicksand(
        //                 //           fontSize: 16.0,
        //                 //           fontWeight: FontWeight.w400,
        //                 //           color: Colors.white,
        //                 //         ),
        //                 //       ),
        //                 //
        //                 //       const SizedBox(
        //                 //         width: 10.0,
        //                 //       ),
        //                 //
        //                 //       // const CircleAvatar(
        //                 //       //   radius: 9.0,
        //                 //       //   backgroundColor: Colors.red,
        //                 //       // ),
        //                 //       // const SizedBox(
        //                 //       //   width: 10.0,
        //                 //       // ),
        //                 //       // const CircleAvatar(
        //                 //       //   radius: 9.0,
        //                 //       //   backgroundColor: Colors.blue,
        //                 //       // ),
        //                 //       // const SizedBox(
        //                 //       //   width: 10.0,
        //                 //       // ),
        //                 //       // const CircleAvatar(
        //                 //       //   radius: 9.0,
        //                 //       //   backgroundColor: Colors.green,
        //                 //       // ),
        //                 //     ],
        //                 //   ),
        //                 // ),
        //                 const SizedBox(
        //                   height: 20.0,
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //         AnimatedPositioned(
        //           duration: isHovered
        //               ? const Duration(milliseconds: 800)
        //               : const Duration(milliseconds: 500),
        //           bottom: isHovered ? 20.0 : -100.0,
        //           curve: isHovered ? Curves.easeInCubic : Curves.easeOut,
        //           child: AnimatedOpacity(
        //             opacity: isHovered ? 1.0 : 0.0,
        //             duration: const Duration(milliseconds: 1075),
        //             curve: Curves.easeOut,
        //             child: SizedBox(
        //               width: 230.0,
        //               child: Center(
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   children: [
        //                     TextButton(
        //                       style: TextButton.styleFrom(
        //                         shape: RoundedRectangleBorder(
        //                           borderRadius: BorderRadius.circular(10.0),
        //                         ),
        //                       ),
        //                       onPressed: () {},
        //                       child: const Icon(
        //                         color: kAppColor,
        //                         Icons.delete,
        //                         size:
        //                             24, // Adjusted size to a more standard icon size
        //                       ),
        //                     ),

        //                     // TextButton(
        //                     //   style: TextButton.styleFrom(
        //                     //     foregroundColor: Colors.black87,
        //                     //     backgroundColor: Colors.black45,
        //                     //     padding: const EdgeInsets.only(
        //                     //         left: 8, right: 8, bottom: 15, top: 15),
        //                     //     shape: RoundedRectangleBorder(
        //                     //       borderRadius: BorderRadius.circular(5.0),
        //                     //     ),
        //                     //   ),
        //                     //   onPressed: () {},
        //                     //   child: Icon(
        //                     //     Icons.delete,
        //                     //     size: 10,
        //                     //   ),
        //                     //   // Text(
        //                     //   //   'Buy Now',
        //                     //   //   style: GoogleFonts.montserrat(
        //                     //   //     fontSize: 16.0,
        //                     //   //     fontWeight: FontWeight.w600,
        //                     //   //   ),
        //                     //   // ),
        //                     // ),

        //                     const SizedBox(
        //                       width: 10.0,
        //                     ),
        //                     TextButton(
        //                       style: TextButton.styleFrom(
        //                         shape: RoundedRectangleBorder(
        //                           borderRadius: BorderRadius.circular(10.0),
        //                         ),
        //                       ),
        //                       onPressed: () {},
        //                       child: const Icon(
        //                         color: kAppColor,
        //                         Icons.edit,
        //                         size:
        //                             24, // Adjusted size to a more standard icon size
        //                       ),
        //                     ),
        //                     const SizedBox(
        //                       width: 10.0,
        //                     ),
        //                     TextButton(
        //                       style: TextButton.styleFrom(
        //                         shape: RoundedRectangleBorder(
        //                           borderRadius: BorderRadius.circular(10.0),
        //                         ),
        //                       ),
        //                       onPressed: () {},
        //                       child: const Icon(
        //                         color: kAppColor,
        //                         Icons.timer,
        //                         size: 24,
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // )

        // Card(
        //   margin: EdgeInsets.all(8.0),
        //   child: ListTile(
        //     leading:  Image.asset('assets/images/homeview.png'),
        //     // leading:  CustomNetworkImage(url: '$kBaseUrlAsset${ad.imageUrl}'),

        //     title: Text(ad.title!),
        //     subtitle: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text('by ${ad.description}'),
        //         // Text('${course.weeks} weeks | ${course.students} Students | ${course.lessons} Lessons'),
        //       ],
        //     ),
        //     trailing: Text('\$${ad.title}'),
        //   ),
        // )

        ;

    // Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: ExpansionTile(
    //     title: ClipRRect(
    //       borderRadius: BorderRadius.circular(10),
    //       child: Stack(
    //         children: [
    //           CustomNetworkImage(url: '$kBaseUrlAsset${ad.imageUrl}'),
    //           Positioned(
    //             top: 0,
    //             left: 0,
    //             child: IconButton(
    //               icon: const Icon(Icons.edit),
    //               onPressed: () {
    //                 adDialog(context, (editedAd) {
    //                   onUpdateAd(editedAd);
    //                 }, ad);
    //               },
    //             ),
    //           ),
    //           Positioned(
    //             top: 0,
    //             right: 0,
    //             child: BlocConsumer<SetAdExpiredCubit, BaseState>(
    //               listener: (context, state) {
    //                 if (state is Success) {
    //                   onSetExpired(ad);
    //                 }
    //               },
    //               builder: (context, state) {
    //                 if (state is Loading) {
    //                   return const CustomLoading();
    //                 }
    //                 return IconButton(
    //                   icon: const Icon(Icons.timer),
    //                   onPressed: () {
    //                     BlocProvider.of<SetAdExpiredCubit>(context)
    //                         .setAdExpired(adId: ad.id.toString());
    //                   },
    //                 );
    //               },
    //             ),
    //           ),
    //           Positioned(
    //             bottom: 0,
    //             right: 0,
    //             child: BlocConsumer<DeleteAdCubit, BaseState>(
    //               listener: (context, state) {
    //                 if (state is Success) {
    //                   onDelete(ad);
    //                 }
    //               },
    //               builder: (context, state) {
    //                 if (state is Loading) {
    //                   return const CustomLoading();
    //                 }
    //                 return IconButton(
    //                   icon: const Icon(Icons.delete),
    //                   onPressed: () {
    //                     BlocProvider.of<DeleteAdCubit>(context)
    //                         .deleteAd(adId: ad.id.toString());
    //                   },
    //                 );
    //               },
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     children: [
    //       Text('${ad.title!} \n ${ad.description!}'),
    //     ],
    //   ),
    // );
  }
}
