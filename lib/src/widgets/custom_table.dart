import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf_template/src/configs.dart';

Widget customTable({required List<String> headers, required List<List<String>> contents}){
  TextStyle _tableHeaderStyle = TextStyle(fontWeight: FontWeight.bold, color: PdfColors.white);
  return Table(
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
              for(var _header in headers)
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(_header, style: _tableHeaderStyle)
                ),
            ]
          ),

          // table body
          for(int i=0; i < contents.length; i++)
          TableRow( // table body content
            decoration: i.isOdd ? const BoxDecoration(color: primaryColorLight) : null,
            children: [
              for(var _item in contents[i])
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(_item)
                ),
            ]
          ),
          TableRow(children: [SizedBox(height: 10),])
        ]
      );
}