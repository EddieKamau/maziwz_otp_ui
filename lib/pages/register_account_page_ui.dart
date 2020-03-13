import 'package:flutter/material.dart';
import 'package:maziwa_ui/modules/user_module.dart';
import 'package:maziwa_ui/pages/businesses_list.dart';
import 'package:maziwa_ui/pages/login_page_ui.dart';

class RegisterAccountPageUi extends StatefulWidget {
  final BaseModule baseModule;
  RegisterAccountPageUi(this.baseModule);
  @override
  _RegisterAccountPageUiState createState() => _RegisterAccountPageUiState();
}

class _RegisterAccountPageUiState extends State<RegisterAccountPageUi> {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

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
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email:'
                    ),
                  ),
                  SizedBox(height: 8,),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password:'
                    ),
                  ),
                  SizedBox(height: 8,),
                  TextField(
                    obscureText: true,
                    controller: confirmController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password:'
                    ),
                  ),
                  SizedBox(height: 8,),
                  
                  RaisedButton(
                    onPressed: ()async{
                      if(confirmController.text == passwordController.text){
                        setState(() {
                          isLoading = true;
                        });
                        final bool _res = await widget.baseModule.registerAcc(emailController.text, passwordController.text);
                        setState(() {
                          isLoading = false;
                        });        
                        if(_res){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> BusinessesPage(widget.baseModule)));
                        }
                      }
                    },
                    child: isLoading ? CircularProgressIndicator() : Text("Register"),
                    color: Colors.blue,
                  ),
                  SizedBox(height: 5,),

                  FlatButton(
                    child: Text('Login'),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginPageUi(widget.baseModule)));
                    },
                  ),
                  
                ],
              ),
            ),
      ),
    );
  }
}