import 'package:flutter/material.dart';
import 'package:maziwa_ui/modules/user_module.dart';

class AddBusinessPageUi extends StatefulWidget {
  final BaseModule baseModule;
  AddBusinessPageUi(this.baseModule);
  @override
  _AddBusinessPageUiState createState() => _AddBusinessPageUiState();
}

class _AddBusinessPageUiState extends State<AddBusinessPageUi> {
  bool isLoading = false;
  TextEditingController labelController = TextEditingController();
  TextEditingController shortCodeController = TextEditingController();
  TextEditingController keyController = TextEditingController();
  TextEditingController secretController = TextEditingController();

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
                controller: labelController,
                decoration: InputDecoration(
                  labelText: 'Business lable:'
                ),
              ),
              SizedBox(height: 8,),
              TextField(
                controller: shortCodeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Mpesa ShortCode:'
                ),
              ),
              SizedBox(height: 8,),
              TextField(
                controller: keyController,
                decoration: InputDecoration(
                  labelText: 'ConsumerKey:'
                ),
              ),
              SizedBox(height: 8,),
              TextField(
                controller: secretController,
                decoration: InputDecoration(
                  labelText: 'ConsumerSecret:'
                ),
              ),
              SizedBox(height: 8,),
              
              RaisedButton(
                onPressed: ()async{
                  setState(() {
                  isLoading = true;
                  });
                  final bool _res = await widget.baseModule.createBusinesses(
                    labelController.text,
                    shortCodeController.text,
                    keyController.text,
                    secretController.text
                  );
                  setState(() {
                    isLoading = false;
                  });        
                  if(_res){
                    Navigator.of(context).pop();
                  }
                  
                },
                child: isLoading ? CircularProgressIndicator() : Text("Add"),
                color: Colors.blue,
              ),

              
            ],
          ),
        ),
      ),
    );
  }
}