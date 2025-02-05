import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// const kBaseUrl = 'http://10.0.2.2:8000/api';

const kBaseUrl = 'https://bb02-178-253-95-112.ngrok-free.app/api';
// const kBaseUrlAsset = 'https://06f4-145-249-67-8.ngrok-free.app';
// const kBaseUrl = 'http://127.0.0.1:8000/api';
// const kBaseUrl = 'http://192.168.2.108:8000/api';
final kBaseUrlAsset = kBaseUrl.split('/api')[0];
//const kBaseUrlAsset= 'http://127.0.0.1:8000';
const kSignIn = 'Login';
const kAppName = 'ScholarSphere';
// const kAppColor = Color(0xff042e6a);
const kAppColor = Color(0xFF17505E);
const kTextCollor = Color(0xFF154957);
//const kAppColor = Color(0xff3fbbc0);
// const kAppColor = Color.fromARGB(255, 3, 228, 142);
const kSignUp = 'SighUp';
const kArabic = 'ar';
const kEnglish = 'en';

const kUser = 'User';

//const kVideoState = 'VideoState';
const kFileState = 'FileState';
const kVideo = 'Video';
const kQuestion = 'Question';
const kBlank = 'Blank';
const kMatchItem = 'MatchItem';
const kOption = 'Option';
const kCustomTime = 'CustomTime';
const kFieldRequests = 'FieldRequests';

List<String> boxNames = [
  kFileState,
  kVideo,
  kQuestion,
  kBlank,
  kMatchItem,
  kOption,
  kCustomTime,
  kFieldRequests,
];

class AppStyles {
  static final TextStyle titleStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color(0xFF154957),
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  );
}
