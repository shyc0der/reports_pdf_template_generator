
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_template/src/configs.dart';


class PdfGenerator{
  // header
  //    - doc info(type; invoice, total, id)
  //    - extra(client details)

  // body
  //    - content
  //    - summary

  Future<pw.Document> generator({
    required DocumentType documentType,
    HeaderItems? headerInfo, HeaderItems? headerExtras,
    pw.Widget? body,
  })async{
    final doc = pw.Document();
    final logo = pw.MemoryImage(
      (await rootBundle.load('assets/images/LOGO.JPG')).buffer.asUint8List(),
    );

    doc.addPage(
      pw.MultiPage(
        pageTheme: const pw.PageTheme(pageFormat: PdfPageFormat.a4),
        header: (_)=> _buildHeader(logo, documentType: documentType, headerInfo: headerInfo, headerExtras: headerExtras),
        footer: (_footerContext) {
          return pw.Column(
            children: [
                pw.Container(
                  height: 10,
                  width: double.infinity,
                  color: primaryColorAccent
                ),
                if(_footerContext.pagesCount > 1 ) pw.Padding(
                  padding: const pw.EdgeInsets.all(8.0),
                  child: pw.Text('Page ${_footerContext.pageNumber} of ${_footerContext.pagesCount}'),
                )

            ],
          );
        },
        build: (context){
          return [
            if(body != null) body,
          ];
        }
      )
    );

    return doc;
  }

  pw.Widget _buildHeader(pw.ImageProvider logo, {required DocumentType documentType, HeaderItems? headerInfo, HeaderItems? headerExtras}){
    String _documentType = (){
      switch (documentType) {
        case DocumentType.invoice:
            return 'INVOICE';
        case DocumentType.quotation:
            return 'QUOTATION';
        case DocumentType.reports:
            return 'REPORTS';
        default:
        return 'Document';
      }
    }.call();
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 10),
      child: pw.Column(
        mainAxisSize: pw.MainAxisSize.min,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // header details; header info, extras. logo
          pw.Row(
            children: [
              // 1st doc about
              pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // document type
                  pw.Text(_documentType, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 21, color: primaryColor)),
                  pw.SizedBox(height: 14),

                  // headers
                  if(documentType == DocumentType.invoice ||documentType == DocumentType.quotation) pw.Padding(padding: const pw.EdgeInsets.symmetric(vertical: 1), child: pw.Text('From')),
                  if(headerInfo?.title != null)
                    pw.Text(headerInfo!.title!, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15)),
                  
                  if(headerInfo?.items != null)
                    for(var _headerItem in headerInfo!.items)
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(vertical: 1),
                        child: pw.Text(_headerItem, style: const pw.TextStyle(fontSize: 12))
                      ),


                ] 
              ),

              // 2nd doc extra info
              pw.Expanded(child: pw.Center(child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  if(headerExtras != null) pw.SizedBox(height: 39),
                  if(documentType == DocumentType.invoice ||documentType == DocumentType.quotation) pw.Padding(padding: const pw.EdgeInsets.symmetric(vertical: 1), child: pw.Text('For')),
                  if(headerExtras?.title != null)
                    pw.Text(headerExtras!.title!, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15)),
                  
                  if(headerExtras?.items != null)
                    for(var _headerItem in headerExtras!.items)
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(vertical: 1),
                        child: pw.Text(_headerItem, style: const pw.TextStyle(fontSize: 12))
                      ),
                ]
              ))),

              // 3rd logo
              pw.Container(
                // alignment: pw.Alignment.topRight,
                margin: const pw.EdgeInsets.only(top: 35),
                height: 100,
                child: pw.Image(logo)
              )
            ]
          ),

          // document  description
          if(headerInfo?.descriptionItems != null)
          pw.Divider(height: 20, color: PdfColor.fromHex('#808080')),
          if(headerInfo?.descriptionItems != null)
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 5),
            child: pw.Column(
              mainAxisSize: pw.MainAxisSize.min,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                for(var _des in headerInfo!.descriptionItems)
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(vertical: 3),
                    child: pw.Text(_des, style: const pw.TextStyle(fontSize: 12))
                  ),
              ]
            ),
          )
        ]
      ),
    );
  }
}

class HeaderItems {
  HeaderItems({this.title, this.items = const [], this.descriptionItems = const []});
  String? title;
  List<String> items;
  List<String> descriptionItems;
}

enum DocumentType{
  invoice, quotation, reports
}