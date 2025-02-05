import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/core/utils/functions/image_picker.dart';
import 'package:lms_admin/core/utils/service_locator.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';
import 'package:lms_admin/core/widgets/custom_network_image.dart';
import 'package:lms_admin/features/home/data/models/ad_model/ad.dart';
import 'package:lms_admin/features/home/data/models/ad_model/ads_model.dart';
import 'package:lms_admin/features/home/data/repos/ads_repo/ad_repo_impl.dart';
import 'package:lms_admin/features/home/presentation/manager/ads_cubits/post_ad_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/ads_cubits/update_ad_cubit.dart';

Future<dynamic> adDialog(
    BuildContext context, void Function(Ad) successfulAdding, Ad? ad) {
  FilePickerResult? image;
  TextEditingController title = TextEditingController(text: ad?.title);
  TextEditingController description =
      TextEditingController(text: ad?.description);
  return showDialog(
    context: context,
    builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PostAdCubit(getIt<AdRepoImpl>()),
          ),
          BlocProvider(
            create: (context) => UpdateAdCubit(getIt<AdRepoImpl>()),
          ),
        ],
        child: StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Dialog(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      image = await imagePicker();
                      if (image != null) {
                        setState(() {});
                      }
                    },
                    child: ad == null && image == null
                        ? const Text('item')
                        : SizedBox(
                            height: 200,
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: ad != null && image == null
                                  ? CustomNetworkImage(
                                      url: '$kBaseUrlAsset${ad.imageUrl}')
                                  : Image.memory(image!.files.single.bytes!),
                            ),
                          ),
                  ),
                  TextField(
                    controller: title,
                  ),
                  TextField(
                    controller: description,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (ad != null) {
                          BlocProvider.of<UpdateAdCubit>(context).updateAd(
                            ad: Ad(
                              id: ad.id,
                              image: image?.files.single.bytes!,
                              title: title.text,
                              description: description.text,
                            ),
                          );
                        } else {
                          BlocProvider.of<PostAdCubit>(context).uploadAd(
                            ad: Ad(
                              image: image!.files.single.bytes!,
                              title: title.text,
                              description: description.text,
                            ),
                          );
                        }
                      },
                      child: BlocConsumer<BaseCubit, BaseState>(
                        bloc: ad != null
                            ? BlocProvider.of<UpdateAdCubit>(context)
                            : BlocProvider.of<PostAdCubit>(context),
                        listener: (context, state) {
                          if (state is Success) {
                            successfulAdding(
                                (state.data as AdsModel).singleAd!);
                            if (context.mounted) {
                              context.pop();
                            }
                          }
                        },
                        builder: (context, state) {
                          if (state is Loading) {
                            return const CustomLoading();
                          }
                          if (state is Success) {
                            return const Text('done');
                          }
                          return Text(ad == null ? 'add ad' : 'update');
                        },
                      ))
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
