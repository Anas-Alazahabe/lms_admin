import 'package:file_picker/file_picker.dart';

Future<FilePickerResult?> excelPicker() async {
  FilePickerResult? result;
  result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowMultiple: false,
    allowedExtensions: ['xlsx'],
  );
  return result;
}
