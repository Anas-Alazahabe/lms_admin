// final formKey = GlobalKey<FormState>();
// late String phoneNumber;
// late String password;
//late String username;
//late String fatherName;
//late int avatarIndex;
// DateTime? selectedDate;
// String verificationCodee = '';
//bool isGuest = false;
// bool isSignIn = false;
// bool failedToLog = false;
// bool showCode = false;

//void Function(String? newValue)? save = (newValue) {};

// String? Function(String?, BuildContext)? emailValidator = (value, context) {
//   if (value == null ||
//       value.isEmpty ||
//       value.trim().length < 10 ||
//       !value.contains('@') ||
//       !value.contains('.')) {
//     return 'البريد الالكتروني غير صالح';
//   }
//   return null;
// };

// String? Function(String?, BuildContext)? nameValidator = (value, context) {
//   if (value == null || value.trim().isEmpty || value.trim().length < 2) {
//     return 'الاسم غير صالح';
//   }
//   return null;
// };
// String? Function(String?, BuildContext)? fatherNameValidator =
//     (value, context) {
//   if (value == null || value.trim().isEmpty || value.trim().length < 2) {
//     return 'اسم المستخدم غير صالح';
//   }
//   return null;
// };
// String? Function(String?, BuildContext)? passwordValidator = (value, context) {
//   if (value == null || value.trim().isEmpty || value.trim().length < 8) {
//    password = value!;
//     return 'كلمة المرور يجب ان تكون 8 محارف عل الاقل';
//   }
//   password = value;
//   return null;
// };
// String? Function(String?, BuildContext)? confirmPasswordValidator = (value, context) {
//   if (value !=password) {
//     return 'لا يوجد تطابق';
//   }
//   return null;
// };

// List<TextInputFormatter>? emailFormater = <TextInputFormatter>[
// //  FilteringTextInputFormatter.digitsOnly,
//   // LengthLimitingTextInputFormatter(10),
// ];
// List<TextInputFormatter>? nameFormatter = <TextInputFormatter>[
//   // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
//   LengthLimitingTextInputFormatter(25),
// ];
// // List<TextInputFormatter>? passwordFormatter = <TextInputFormatter>[
// //   LengthLimitingTextInputFormatter(20),
// // ];

// void Function(String?)? onSave;

// bool hidePassword = true;
