import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf_template/src/configs.dart';

List<Table> customTable({required List<String> headers, required List<List<String>> contents, Map<int, TableColumnWidth>? columnWidths}){
  TextStyle _tableHeaderStyle = TextStyle(fontWeight: FontWeight.bold, color: PdfColors.white);
  int _count = 20;
  int _noOfTable = (contents.length / _count).ceil(); // get how many tables can fit this data

  List<List<List<String>>> _tablesData = [];
  for (var i = 0; i < _noOfTable; i++) { // for each table, get its content
    if(i+1 == _noOfTable){ // if the last one, add all the remaining contents
    var _l = contents.sublist(i*_count,);
      _tablesData.add(_l);
      

    }else{
      _tablesData.add(contents.sublist(i*_count, i*_count + _count));
    }
    
  }
  
  return [
    for(var _contents in _tablesData)
    Table(
        border: TableBorder.symmetric(outside: const BorderSide(color: PdfColors.grey)),
        columnWidths: columnWidths,
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
          TableRow(children: [SizedBox(height: 20),])
        ]
      ),
  ];
}