import 'package:pdf_template/src/pdf_generator.dart';

import 'package:pdf/widgets.dart';

abstract class PdfTemplate {
  late DocumentType documentType;

  HeaderItems? headerInfo;
  HeaderItems? headerExtras;

  Widget get body;


}

class PdfGenerate {

  static final PdfGenerator pdfGenerator = PdfGenerator();

  static Future<Document> generate(PdfTemplate pdfTemplate)async{
    return pdfGenerator.generator(
          documentType: pdfTemplate.documentType,
          headerInfo: pdfTemplate.headerInfo,
          headerExtras: pdfTemplate.headerExtras,
          body: pdfTemplate.body
        );
  }
}