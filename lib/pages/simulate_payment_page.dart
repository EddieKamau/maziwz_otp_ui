import 'package:flutter/material.dart';
import 'package:maziwa_ui/modules/user_module.dart';

class SimulatePaymentPageUi extends StatefulWidget {
  final BaseModule baseModule;
  final String businessId;
  SimulatePaymentPageUi(this.baseModule, this.businessId);
  @override
  _SimulatePaymentPageUiState createState() => _SimulatePaymentPageUiState();
}

class _SimulatePaymentPageUiState extends State<SimulatePaymentPageUi> {
  bool isLoading = false;
  TextEditingController referenceController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: referenceController,
                decoration: InputDecoration(
                  labelText: 'Transaction reference:'
                ),
              ),
              SizedBox(height: 8,),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount:'
                ),
              ),
              
              RaisedButton(
                onPressed: ()async{
                  setState(() {
                    isLoading = true;
                  });
                  final bool _res = await widget.baseModule.simulatePayment(
                    widget.businessId,
                    amountController.text,
                    referenceController.text                   
                  );
                  setState(() {
                    isLoading = false;
                  });        
                  if(_res){
                    Navigator.of(context).pop();
                  }
                },
                child: isLoading ? CircularProgressIndicator() : Text("Simulate"),
                color: Colors.blue,
              ),

              
            ],
          ),
        ),
      ),
    );
  }
}