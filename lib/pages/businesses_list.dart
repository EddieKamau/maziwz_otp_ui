import 'package:flutter/material.dart';
import 'package:maziwa_ui/modules/user_module.dart';
import 'package:maziwa_ui/pages/add_business_page.dart';
import 'package:maziwa_ui/pages/payment_reports_page.dart';
import 'package:maziwa_ui/pages/simulate_payment_page.dart';
import 'package:maziwa_ui/pages/sms_report_page.dart';
import 'package:maziwa_ui/pages/verify_otp_page.dart';

class BusinessesPage extends StatefulWidget {
  final BaseModule baseModule;
  BusinessesPage(this.baseModule);
  @override
  _BusinessesPageState createState() => _BusinessesPageState();
}

class _BusinessesPageState extends State<BusinessesPage> {
  bool isSmsLoading = false;
  bool isPaymentLoading = false;
  @override
  Widget build(BuildContext context) {
    List _businesess = widget.baseModule.business;
    return Scaffold(
      body: Center(
        child: Container(
              width: 600,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: RaisedButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (contex)=> AddBusinessPageUi(widget.baseModule)));
                      },
                      child: Text("Add a Business"),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: RaisedButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (contex)=> VerifyOtpPageUi(widget.baseModule)));
                      },
                      child: Text("Verify OTP"),
                    ),
                  ),
                  
                  Expanded(
                    child: ListView.builder(
                      itemCount: _businesess.length,
                      itemBuilder: (BuildContext contex, int index){
                        return Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(_businesess[index]['label'].toString()),
                              trailing: Text(_businesess[index]['shortCode'].toString()),
                              onTap: (){
                                showModalBottomSheet(
                                  context: contex,
                                  builder: (BuildContext contex){
                                    return Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RaisedButton(
                                            onPressed: (){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (contex)=> SimulatePaymentPageUi(widget.baseModule, _businesess[index]['_id'].toString())));
                                            },
                                            child: Text('Simulate'),
                                          ),
                                        ),Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RaisedButton(
                                            onPressed: () async{
                                              setState(() {
                                                isSmsLoading = true;
                                              });
                                              await widget.baseModule.fetchSmsReports(_businesess[index]['_id'].toString());
                                              setState(() {
                                                isSmsLoading = false;
                                              });
                                              Navigator.of(context).push(MaterialPageRoute(builder: (contex)=> SmsReportsPage(widget.baseModule)));
                                            },
                                            child: isSmsLoading ? CircularProgressIndicator() : Text('SMS Reports'),
                                          ),
                                        ),Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RaisedButton(
                                            onPressed: ()async{
                                              setState(() {
                                                isPaymentLoading = true;
                                              });
                                              await widget.baseModule.fetchpaymentReports(_businesess[index]['_id'].toString());
                                              
                                              setState(() {
                                                isPaymentLoading = false;
                                              });
                                              Navigator.of(context).push(MaterialPageRoute(builder: (contex)=> PaymentReportsPage(widget.baseModule)));
                                            },
                                            child: isPaymentLoading ? CircularProgressIndicator() : Text('Payment Reports'),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                );
                              },
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 2,
                              color: Colors.blue,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}