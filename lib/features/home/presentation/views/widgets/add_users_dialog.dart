import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_admin/core/utils/functions/custom_toast.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';
import 'package:lms_admin/features/auth/presentation/manager/create_user_cubit/create_user_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/add_user_cubit.dart';
import 'package:lms_admin/features/home/presentation/manager/fetch_users_cubit.dart';

addUsersDialog(BuildContext context) {
  final List<String> genderItems = [
    'Manager',
    'Admin',
    'Teacher',
  ];

  String selectedValue = 'Teacher';

  TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          return Dialog(
            child: Container(
              width: 600,
              height: 600,
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 20, top: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'Add User',
                      style: AppStyles.titleStyle,
                    ),
                  ),

                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: controller,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(16),
                            hintText: 'Enter Your Email',
                            hintStyle: const TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField2<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            // Add more decoration..
                          ),
                          hint: const Text(
                            'Select Your Role',
                            style: TextStyle(fontSize: 14),
                          ),
                          items: genderItems
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select role.';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            //Do something when selected item is changed.
                          },
                          onSaved: (value) {
                            selectedValue = value.toString();
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.only(right: 8),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 24,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                        const SizedBox(height: 30),
                        BlocConsumer<CreateUserWebCubit, BaseState>(
                          listener: (context, state) {
                            if (state is Failure) {
                              context.pop();
                              customToast(context, state.errorMessage);
                            }
                            if (state is Success) {
                              context.pop();
                              BlocProvider.of<FetchUsers>(context).fetchUser();
                            }
                          },
                          builder: (context, state) {
                            if (state is Loading) {
                              return const CustomLoading();
                            }

                            return ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();

                                  BlocProvider.of<CreateUserWebCubit>(context)
                                      .createUserWeb(
                                          email: controller.text,
                                          roleId: (genderItems
                                                      .indexOf(selectedValue) +
                                                  1)
                                              .toString());
                                }
                              },
                              child: const Text('Creat'),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // TextField(
                  //   decoration: const InputDecoration(
                  //     // labelText: 'Enter Your Email',
                  //     hintText: 'Enter Your Email...',
                  //     border: OutlineInputBorder(
                  //       borderSide: BorderSide(color: kAppColor),
                  //     ),
                  //   ),
                  //   onChanged: (text) {
                  //     Println('Text changed to: $text');
                  //   },
                  // ),
                  // const SizedBox(height: 16.0),
                  // TextField(
                  //   decoration: const InputDecoration(
                  //     // labelText: 'Enter your text',
                  //     hintText: 'Enter Your Email...',
                  //     border: OutlineInputBorder(
                  //       borderSide: BorderSide(color: kAppColor),
                  //     ),
                  //   ),
                  //   onChanged: (text) {
                  //     Println('Text changed to: $text');
                  //   },
                  // ),

                  // const SizedBox(height: 16.0),
                  // ElevatedButton(
                  //   onPressed: () async {},
                  //   child: Text('Creat'),
                  // )
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
