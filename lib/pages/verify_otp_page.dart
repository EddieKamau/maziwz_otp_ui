import 'package:flutter/material.dart';
import 'package:maziwa_ui/modules/user_module.dart';

class VerifyOtpPageUi extends StatefulWidget {
  final BaseModule baseModule;
  VerifyOtpPageUi(this.baseModule);
  @override
  _VerifyOtpPageUiState createState() => _VerifyOtpPageUiState();
}

class _VerifyOtpPageUiState extends State<VerifyOtpPageUi> {
  bool isLoading = false;
  TextEditingController refController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  Map<String, dynamic> _verification;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: 500,
        child: Column(
          children: <Widget>[
            TextField(
              controller: refController,
              decoration: InputDecoration(
                labelText: 'RefNo:'
              ),
            ),
            SizedBox(height: 8,),
            TextField(
              controller: otpController,
              decoration: InputDecoration(
                labelText: 'OTP:'
              ),
            ),
            SizedBox(height: 8,),
            RaisedButton(
              onPressed: ()async{
                setState(() {
                  isLoading = true;
                });
                final Map<String, dynamic> _res = await widget.baseModule.verifyOtp(refController.text, otpController.text);
                setState(() {
                  isLoading = false;
                  _verification = _res;
                });  
              },
            child: isLoading ? CircularProgressIndicator() : Text("verify"),
            color: Colors.blue,
          ),
          SizedBox(height: 5,),
          Card(
            child: _verification == null ? Text(''):
                  _verification['status'] == 111 ? Text('Error: ${_verification["error"]}') :
                  _verification['status'] == 2 ? Text('Error: ${_verification["message"]}') :
                  _verification['status'] == 1 ? Text('Message: ${_verification["message"]}') :
                  Column(
                    children: <Widget>[
                      Text('Amount: ${_verification["body"]["amount"]}'),
                      Text('OTP: ${_verification["body"]["otp"]}'),
                      Text('Business Short Code: ${_verification["body"]["businessShortCode"]}'),
                    ],
                  ),
          )
          ],
        ),
      ),
    );
  }
}