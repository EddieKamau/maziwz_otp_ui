import 'package:flutter/material.dart';
import 'package:maziwa_ui/modules/user_module.dart';
import 'package:maziwa_ui/pages/login_page_ui.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider.value(
      value: BaseModule(),
        child: Consumer<BaseModule>(
            builder: (context, baseModule, _){
            return LoginPageUi(baseModule);
          }
        )
      ),
    );
  }
}
