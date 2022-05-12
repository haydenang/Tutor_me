import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "LoginPage",
      home: LoginWidget(),
    );
  }
}

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            Column(
                children: <Widget>[
                  SizedBox(height: 80,),
                  Image.asset('assets/icons8-login-60.png'),
                  SizedBox(height: 40,),
                  Text('Material Login',style: TextStyle(fontSize: 25,color:Colors.green),)
                ]
            ),
            SizedBox(height: 60.0,),
            TextField(
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(fontSize: 20),
                filled: true,
              ),
            ),
            SizedBox(height: 20.0,),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(fontSize: 20),
                filled: true,
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    onPrimary: Colors.black54,
                    onSurface: Colors.grey,
                    elevation: 5,
                    textStyle: TextStyle(fontSize: 20),
                    shadowColor: Colors.amber
                  ),
                  onPressed: (){print("pressed");},
                  onLongPress: (){},
                  child: Text("Login"),
                    ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent,
                      onPrimary: Colors.black54,
                      onSurface: Colors.grey,
                      elevation: 5,
                      textStyle: TextStyle(fontSize: 20),
                      shadowColor: Colors.amber
                  ),
                  onPressed: (){print("Register");},
                  onLongPress: (){},
                  child: Text("Register"),
                )
                  ]
                )
              ],
        ),
      ),
    );
  }
}

