import 'package:flutter/material.dart';
import 'package:maziwa_ui/modules/user_module.dart';

class SmsReportsPage extends StatefulWidget {
  final BaseModule baseModule;
  SmsReportsPage(this.baseModule);
  @override
  _SmsReportsPageState createState() => _SmsReportsPageState();
}

class _SmsReportsPageState extends State<SmsReportsPage> {
  @override
  Widget build(BuildContext context) {
    List _smsReports = widget.baseModule.smsReports;
    return Material(
      child: Container(
        width: 600,
        child: ListView.builder(
          itemCount: _smsReports.length,
          itemBuilder: (BuildContext context, int index){
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_smsReports[index]['phoneNo'].toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_smsReports[index]['body'].toString()),
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