import 'package:pdf/widgets.dart';
import 'package:pdf_template/src/pages/reports_page.dart';
import 'package:pdf_template/src/widgets/custom_table.dart';
import 'package:pdf_template/src/widgets/pdf_totals_widget.dart';

class JobsPerVehicleReportPdf extends ReportsPdf {
  JobsPerVehicleReportPdf() ;

  @override
  String get title => 'Jobs per vehicle: KZY 154';

  @override
  String get dateRange {
    DateTime _from = DateTime.now().subtract(const Duration(days: 30));
    DateTime _to = DateTime.now();
    return 'From ${_from.toString().substring(0,16)} To ${_to.toString().substring(0,16)}';
  }

  @override
  List<String>? get filtersApplied => [];

  @override
  Widget get body => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...customTable(headers: _tableHeaders, contents: _contents, columnWidths: columnWidths),
           

      // totals
      Align(
        alignment: Alignment.topRight,
        child: pdfTotals([
          PdfTotalItems(label: 'Sub Total', value: 'Ksh. 400,000'),
          PdfTotalItems(label: 'Expenses Total', value: 'Ksh. 100,000'),
          PdfTotalItems(label: 'Total', value: 'Ksh. 300,000', bold: true),
        ])
      )
    ]
  );

  final List<String> _tableHeaders = const ['ORDERNO', 'AMOUNT', 'TOTAL EXPENSES', 'TOTAL'];

  List<List<String>> get _contents => [
    for(int i=0; i<10; i++)
    ['12SEAGrGDUXI', '20,000', '$i,000', '15,000'],
  ];

  Map<int, TableColumnWidth> get columnWidths=> {
    0: const FlexColumnWidth(4),
    1: const FlexColumnWidth(4),
    2: const FlexColumnWidth(4),
    3: const FlexColumnWidth(4),
  };
  
}