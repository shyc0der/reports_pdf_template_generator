import 'package:pdf_template/src/configs.dart';
import 'package:pdf_template/src/pdf_generator.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf_template/src/pdf_template.dart';
import 'package:pdf_template/src/widgets/custom_table.dart';
import 'package:pdf_template/src/widgets/pdf_totals_widget.dart';

class QuotationWidget implements PdfTemplate  {

  @override
  DocumentType documentType= DocumentType.quotation;

  @override
  HeaderItems? headerInfo= HeaderItems(
    title: companyName, 
    items: [companyEmail, companyAddress, companyPhoneNo],
    descriptionItems: ['Quotation No: #1234543df44f', 'Date: 2022-02-21', 'Date Delivery By: 2022-03-05', ],
  );

  @override
  HeaderItems? headerExtras= HeaderItems(title: 'Client Name', items: ['email@mail.com', '1002-20 Nairobi Kenya', 'P:+25411232565']);

  


  @override
  Widget get body => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      customTable(headers: _tableHeaders, contents: _contents),

      // totals
      Align(
        alignment: Alignment.topRight,
        child: pdfTotals([
          PdfTotalItems(label: 'Subtotal', value: 'Ksh. 40,000'),
          PdfTotalItems(label: 'Tax(16%)', value: 'Ksh. 6,400'),
          PdfTotalItems(label: 'Total', value: 'Ksh. 46,400'),
          PdfTotalItems(label: 'Balance due', value: 'Ksh. 46,400', bold: true),
        ])
      )
    ]
  );

  

  final List<String> _tableHeaders = const ['No.', 'DESCRIPTION', 'QYT', 'UNIT PRICE', 'TOTAL'];
  
  final List<List<String>> _contents = [
    ['1', 'Transport beba mawe', '1', '10,000', '10,000'],
    ['2', 'Transport', '1', '20,000', '20,000'],
    ['3', 'Logistics', '1', '5,000', '5,000'],
    ['4', 'Logistics', '1', '5,000', '5,000'],
  ];
 


}