import 'package:pdf/pdf.dart';
import 'package:pdf_template/src/configs.dart';
import 'package:pdf_template/src/pdf_generator.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf_template/src/pdf_template.dart';

class InvoiceWidget implements PdfTemplate  {

  @override
  DocumentType documentType= DocumentType.invoice;

  @override
  HeaderItems? headerInfo= HeaderItems(
    title: companyName, 
    items: [companyEmail, companyAddress, companyPhoneNo],
    descriptionItems: ['InvoiceNo: #1234543df44f', 'Date: 2022-02-21', ],
  );

  @override
  HeaderItems? headerExtras= HeaderItems(title: 'Client Name', items: ['email@mail.com', '1002-20 Nairobi Kenya', 'P:+25411232565']);

  


  @override
  Widget get body => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Table(
        border: TableBorder.symmetric(outside: const BorderSide(color: PdfColors.grey)),
        columnWidths: {
          0: const FlexColumnWidth(2),
          1: const FlexColumnWidth(10),
          2: const FlexColumnWidth(2),
          3: const FlexColumnWidth(4),
          4: const FlexColumnWidth(4),
        },
        children: [
          TableRow( // table header
          decoration: const BoxDecoration(color: primaryColor),
            children: [
              for(var _header in _tableHeaders)
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(_header, style: _tableHeaderStyle)
                ),
            ]
          ),

          // table body
          for(int i=0; i < _contents.length; i++)
          TableRow( // table body content
            decoration: i.isOdd ? const BoxDecoration(color: primaryColorLight) : null,
            children: [
              for(var _item in _contents[i])
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(_item)
                ),
            ]
          ),
          TableRow(children: [SizedBox(height: 10),])
        ]
      ),

      // totals
      Align(
        alignment: Alignment.topRight,
        child: _totals
      )
    ]
  );

  TextStyle get _tableHeaderStyle => TextStyle(fontWeight: FontWeight.bold, color: PdfColors.white);

  final List<String> _tableHeaders = const ['No.', 'DESCRIPTION', 'QYT', 'UNIT PRICE', 'TOTAL'];

  final List<List<String>> _contents = [
    ['1', 'Transport beba mawe', '1', '10,000', '10,000'],
    ['2', 'Transport', '1', '20,000', '20,000'],
    ['3', 'Logistics', '1', '5,000', '5,000'],
    ['4', 'Logistics', '1', '5,000', '5,000'],
  ];

  Widget get _totals => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _totalsItem('Subtotal', 'Ksh. 40,000'),
        _totalsItem('Tax(16%)', 'Ksh. 6,400'),
        _totalsItem('Total', 'Ksh. 46,400'),
        _totalsItem('Balance due', 'Ksh. 46,400', bold: true),
      ]
    ),
  );

  Widget _totalsItem(String label, String value, {bool bold = false})=> Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: SizedBox(
      width: 250,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // labe
          SizedBox(
            width: 140,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(label, textAlign: TextAlign.right, style: !bold ? null : TextStyle(fontWeight: FontWeight.bold , fontSize: 16)),
            ),
          ),

          // value
          SizedBox(
            width: 100,
            child: Text(value, textAlign: TextAlign.right, style: !bold ? null : TextStyle(fontWeight: FontWeight.bold , fontSize: 16))
          )
        ]
      )
    ),
  );
}