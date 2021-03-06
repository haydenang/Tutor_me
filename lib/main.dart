import 'package:flutter/material.dart';
import 'package:tutor_me/Screens/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:tutor_me/upload.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: LoginPage()));

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

