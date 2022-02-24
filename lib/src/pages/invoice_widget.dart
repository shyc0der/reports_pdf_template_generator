import 'package:pdf_template/src/configs.dart';
import 'package:pdf_template/src/pdf_generator.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf_template/src/pdf_template.dart';
import 'package:pdf_template/src/widgets/custom_table.dart';
import 'package:pdf_template/src/widgets/pdf_totals_widget.dart';

class InvoiceWidget implements PdfTemplate  {

  @override
  DocumentType documentType= DocumentType.invoice;

  @override
  HeaderItems? headerInfo= HeaderItems(
    title: companyName, 
    items: [companyEmail, companyAddress, companyPhoneNo],
    descriptionItems: ['InvoiceNo: #1234543df44f', 'Date: 2022-02-21', ].map((e) => e.toDescriptionItems()).toList(),
  );

  @override
  HeaderItems? headerExtras= HeaderItems(title: 'Client Name', items: ['email@mail.com', '1002-20 Nairobi Kenya', 'P:+25411232565']);

  


  @override
  Widget get body => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...customTable(headers: _tableHeaders, contents: _contents, columnWidths: columnWidths),

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

  Map<int, TableColumnWidth> get columnWidths=> {
    0: const FlexColumnWidth(2),
    1: const FlexColumnWidth(10),
    2: const FlexColumnWidth(2),
    3: const FlexColumnWidth(4),
    4: const FlexColumnWidth(4),
  };

}