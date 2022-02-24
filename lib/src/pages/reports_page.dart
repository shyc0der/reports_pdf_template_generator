// basic orders
// dateCreated, orderNo, title, desc, amount, state, dateApproved, dateClosed, customerEmail, -expenseTotal, totalAmount

// job 
// dateCreated, jobId, orderNo, customerEmail, driverEmail, truckReg, state, dateClosed, amount, -expenseTotal, totalAmount,title,description


// expense
//datecreated,expenseid,truckid,state,userid,jobid,orderNo,amount

// vehicle
// vehicleregno,totalamountofexpenses,totalamountofjobs,

// expenses per vehicles heading on the vehicle
// expenseid,expense amount,

// jobs per vehicle
// jobid,orderno,amount,expensetotal

import 'package:pdf/widgets.dart';
import 'package:pdf_template/src/configs.dart';
import 'package:pdf_template/src/pdf_generator.dart';
import 'package:pdf_template/src/pdf_template.dart';

class ReportsPdf implements PdfTemplate {
  ReportsPdf();
  
  String title = '';
  String dateRange = '';
  final String dateGenerated = DateTime.now().toString().substring(0, 16);
  List<String>? filtersApplied;


  @override
  DocumentType documentType = DocumentType.reports;

  @override
  HeaderItems? headerExtras;

  @override
  HeaderItems? get headerInfo => HeaderItems(
      title: companyName, 
      items: [companyEmail, companyAddress, companyPhoneNo],
      descriptionItems: [title, 'Date Generated: $dateGenerated', dateRange, 
      if(filtersApplied?.isNotEmpty == true) filtersApplied.toString() 
      ],
    );


  @override
  Widget  body = Container();

  @override
  set headerInfo(HeaderItems? _headerInfo) {
    headerInfo = _headerInfo;
  }
  
  
}