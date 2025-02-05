import 'package:file_picker/file_picker.dart';

Future<FilePickerResult?> pdfPicker() async {
  FilePickerResult? result;
  result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowMultiple: false,
    allowedExtensions: ['pdf'],
  );
  return result;
}
