import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

class DirectoryCubit extends Cubit<Directory?> {
  DirectoryCubit() : super(null);

  Future<void> fetchDocsDir() async {
    Directory dir = await getApplicationDocumentsDirectory();
    emit(dir);
  }

  Future<void> clearAllData() async {
    state!.deleteSync(recursive: true);
  }
}

// class DirectoryCubit extends Cubit<String?> {
//   DirectoryCubit() : super(null);

//   Future<void> fetchDeviceToken() async {
//       DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
// AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

//     emit(androidInfo.id);
//   }
// }
