import 'package:file_picker/file_picker.dart';

Future<FilePickerResult?> imagePicker() async {
  FilePickerResult? result;
  result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowMultiple: false,
    allowedExtensions: ['jpeg', 'png', 'jpg'],
  );
  return result;
}
