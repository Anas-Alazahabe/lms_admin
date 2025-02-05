import 'package:file_picker/file_picker.dart';

Future<FilePickerResult?> videoPicker() async {
  FilePickerResult? result;
  result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowMultiple: false,
    allowedExtensions: ['mp4', 'mov', 'avi', 'flv'],
  );
  return result;
}
