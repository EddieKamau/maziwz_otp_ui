import 'package:flutter/material.dart';
import 'package:maziwa_ui/modules/user_module.dart';
import 'package:maziwa_ui/pages/businesses_list.dart';
import 'package:maziwa_ui/pages/register_account_page_ui.dart';

class LoginPageUi extends StatefulWidget {
  final BaseModule baseModule;
  LoginPageUi(this.baseModule);
  @override
  _LoginPageUiState createState() => _LoginPageUiState();
}

class _LoginPageUiState extends State<LoginPageUi> {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                  RaisedButton(
                    onPressed: ()async{
                      setState(() {
                        isLoading = true;
                      });
                      final bool _res = await widget.baseModule.login(emailController.text, passwordController.text);
                      setState(() {
                        isLoading = false;
                      });        
                      if(_res){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> BusinessesPage(widget.baseModule)));
                      }
                    },
                    child: isLoading ? CircularProgressIndicator() : Text("Login"),
                    color: Colors.blue,
                  ),
                  SizedBox(height: 5,),

                  FlatButton(
                    child: Text('Register'),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> RegisterAccountPageUi(widget.baseModule)));
                    },
                  ),
                  
                ],
              ),
            ),
      ),
    );
  }
}