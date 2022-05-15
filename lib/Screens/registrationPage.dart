import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tutor_me/Screens/classesEnrolled.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  //Form key
  final _formKey = GlobalKey<FormState>();

  //editing Controller
  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Declaration of Text Fields
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.emailAddress,
      //validator: (){},
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondNameEditingController,
      keyboardType: TextInputType.emailAddress,
      //validator: (){},
      onSaved: (value) {
        secondNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Surname",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      //validator: (){},
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordEditingController,
      keyboardType: TextInputType.emailAddress,
      //validator: (){},
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password, Min 6 Characters Long",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final confirmField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: confirmPasswordEditingController,
      keyboardType: TextInputType.emailAddress,
      //validator: (){},
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm your Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //Register Button
    final registerButoon = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(16),
      color: Colors.blueAccent,
      shadowColor: Colors.amber,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () => {
          if (emailEditingController.text.isNotEmpty &&
              firstNameEditingController.text.isNotEmpty &&
              secondNameEditingController.text.isNotEmpty &&
              passwordEditingController.text ==
                  confirmPasswordEditingController.text &&
              passwordEditingController.text.isNotEmpty)
            {
              FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: emailEditingController.text,
                      password: passwordEditingController.text)
                  .then((value) {
                if (value != null && value.user != null) {
                  insertData(
                      firstNameEditingController.text,
                      secondNameEditingController.text,
                      emailEditingController.text,
                      passwordEditingController.text,
                      value.user!.uid);
                  print("Successfully created Account");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClassesEnrolled()));
                }
              }).onError((error, stackTrace) {
                print('Error ${error.toString()}');
                throw NullThrownError();
              })
            }
          else if (emailEditingController.text.isEmpty)
            {
              Fluttertoast.showToast(
                  msg: "Please fill in your Email",
                  gravity: ToastGravity.BOTTOM,
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.black87,
                  fontSize: 16)
            }
          else if (firstNameEditingController.text.isEmpty ||
              secondNameEditingController.text.isEmpty)
            {
              Fluttertoast.showToast(
                  msg: "Please fill in your Name/Surname",
                  gravity: ToastGravity.BOTTOM,
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.black87,
                  fontSize: 16)
            }
          else if (passwordEditingController.text !=
              confirmPasswordEditingController.text)
            {
              Fluttertoast.showToast(
                  msg: "Passwords do not match!",
                  gravity: ToastGravity.BOTTOM,
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.black87,
                  fontSize: 16)
            }
        },
        child: Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white60, fontWeight: FontWeight.bold),
        ),
      ),
    );

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 100,
                        child: Image.asset(
                          "assets/icons8-graduation-64.png",
                          fit: BoxFit.fill,
                        )),
                    //Email Field SizedBox
                    SizedBox(
                      height: 45,
                    ),
                    firstNameField,
                    SizedBox(
                      height: 25,
                    ),
                    secondNameField,
                    SizedBox(
                      height: 25,
                    ),
                    emailField,
                    SizedBox(
                      height: 25,
                    ),
                    passwordField,
                    SizedBox(
                      height: 25,
                    ),
                    confirmField,
                    SizedBox(
                      height: 35,
                    ),
                    registerButoon,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> insertData(String firstName, String surname, String email,
      String password, String uid) async {
    await FirebaseFirestore.instance.collection("Users").doc("${uid}").set({
      "firstName": firstName,
      "surname": surname,
      "email": email,
      "password": password,
      "profilePic": "",
      "uid": uid
    });
  }
}
