import 'package:flutter/material.dart';
import 'package:tutor_me/Screens/loginPage.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Email and Password Login',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: LoginPage(),
    );
  }
}

