import 'package:flutter/material.dart';
import 'package:maziwa_ui/modules/user_module.dart';

class PaymentReportsPage extends StatefulWidget {
  final BaseModule baseModule;
  PaymentReportsPage(this.baseModule);
  @override
  _PaymentReportsPageState createState() => _PaymentReportsPageState();
}

class _PaymentReportsPageState extends State<PaymentReportsPage> {
  @override
  Widget build(BuildContext context) {
    List payments = widget.baseModule.paymentReports;
    return Material(
      child: Container(
        width: 600,
        child: ListView.builder(
          itemCount: payments.length,
          itemBuilder: (BuildContext context, int index){
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Phone: ${payments[index]['MSISDN']}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("TransactionId: ${payments[index]['TransID']}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Business Short code: ${payments[index]['BusinessShortCode']}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Amount: ${payments[index]['TransAmount']}"),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(payments[index].toString()),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}