import 'package:flutter/material.dart';
import 'package:pdf_template/src/pages/invoice_widget.dart';
import 'package:pdf_template/src/pages/reports/jobs_per_vehicle_report_pdf.dart';
import 'package:pdf_template/src/pdf_template.dart';
import 'package:printing/printing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final InvoiceWidget invoiceWidget = InvoiceWidget();
  final JobsPerVehicleReportPdf quotationWidget = JobsPerVehicleReportPdf();
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PdfPreview(
        build: (_) async => (await PdfGenerate.generate(quotationWidget)).save(),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
