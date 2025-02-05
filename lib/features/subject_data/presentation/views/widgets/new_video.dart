import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin/core/cubits/upload_video_cubit/upload_cubit.dart';
import 'package:lms_admin/core/utils/functions/custom_toast.dart';
import 'package:lms_admin/core/utils/functions/video_picker.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/video.dart';

class NewVideo extends StatefulWidget {
  final void Function(Video video) onAdd;

  String? lessonId;
  String? subjectId;
  NewVideo({
    super.key,
    this.lessonId,
    this.subjectId,
    required this.onAdd,
  });

  @override
  State<NewVideo> createState() => _NewVideoState();
}

class _NewVideoState extends State<NewVideo> {
  final controller = TextEditingController();
  FilePickerResult? result;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadCubit, UploadState>(
      listener: (context, state) {
        if (state is UploadFailure) {
          customToast(context, state.errMessage);
        }
        if (state is UploadSuccess) {
          // BlocProvider.of<SessionCubit>(context)
          //     .fetchSessionData(id: widget.sessionId);
          widget.onAdd(state.video);
          setState(() {
            result = null;
            controller.clear();
          });
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey, width: 2)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          width: 16,
                        ),

                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: SizedBox(
                              height: 100,
                              // width: 500,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    // border: Border.all(color: Colors.grey, width: 2)
                                  ),
                                  child: Column(
                                    children: [
                                      const Spacer(),
                                      Form(child: FormField(
                                        builder: (field) {
                                          return TextFormField(
                                            controller: controller,
                                            style: const TextStyle(
                                              fontSize: 24,
                                            ),
                                          );
                                        },
                                      )),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                            onTap: () async {
                              result = await videoPicker();

                              if (result != null) {
                                setState(() {});
                              }
                            },
                            child: result == null
                                ? const Icon(
                                    Icons.attach_file_rounded,
                                  )
                                : Text(
                                    result!.files.single.name,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                        const SizedBox(
                          width: 50,
                        ),
                        // if (state is UploadLoading)
                        //   InkWell(
                        //       onTap: () {
                        //         // if (controller.text.isEmpty || file == null) {
                        //         //   return;
                        //         // }
                        //         BlocProvider.of<UploadCubit>(context)
                        //             .cancelDownload(
                        //           controller.text,
                        //         );
                        //       },
                        //       child: const Icon(Icons.cancel,
                        //           color: Color(0xffd8c2bd), size: 100)),
                        // if (state is! UploadLoading)
                        InkWell(
                            onTap: (state is UploadLoading) ||
                                    (state is UploadPendingLoading)
                                ? null
                                : () {
                                    if (controller.text.isEmpty ||
                                        result == null) {
                                      return;
                                    }
                                    BlocProvider.of<UploadCubit>(context)
                                        .uploadFile(
                                      video: Video(
                                          name: controller.text,
                                          video: result?.files.single.bytes!,
                                          lessonId: widget.lessonId,
                                          subjectId: widget.subjectId
                                          ),
                                      onSendProgress: null,
                                      uniqueName: controller.text,
                                    );
                                  },
                            child: const Icon(
                              Icons.add,
                            )),
                        const SizedBox(
                          width: 100,
                        )
                      ]),
                  if (state is UploadLoading)
                    Column(
                      children: [
                        Text(
                            '${(state.recived / 1000000).toStringAsFixed(1)} / ${(state.total / 1000000).toStringAsFixed(1)}'),
                        LinearProgressIndicator(
                          value: state.progress / 100,
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
