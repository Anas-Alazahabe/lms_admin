import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatelessWidget {
  final String? path;
  final String? url;
  const PdfView({super.key, this.path, this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: path != null
            ? SfPdfViewer.file(
                File(path!),
              )
            : SfPdfViewer.network(
                url!,
                //'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'
              ));
  }
}
