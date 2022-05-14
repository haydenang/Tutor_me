import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyUpload());
}

class MyUpload extends StatefulWidget {
  const MyUpload({Key? key}) : super(key: key);

  @override
  State<MyUpload> createState() => _MyUploadState();
}

class _MyUploadState extends State<MyUpload> {
  var namecontroller = new TextEditingController();
  var sizecontroller = new TextEditingController();
  var datecontroller = new TextEditingController();
  var locationcontroller = new TextEditingController();
  var timecontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomInset: false,
      body: SafeArea(child: Column(children: [
        Text(
        "Add Classes",
        style: TextStyle(fontSize: 28),
        ),
        SizedBox(
          height: 30,
        ),
        TextFormField(
          controller: namecontroller,
          decoration: InputDecoration(
              labelText: 'Class Name',border: OutlineInputBorder()),
        ),
        SizedBox(
          height: 30,
        ),
        TextFormField(
          controller: sizecontroller,
          decoration: InputDecoration(
              labelText: 'Class Size',border: OutlineInputBorder()),
        ),
        SizedBox(
          height: 30,
        ),
        TextFormField(
          controller: datecontroller,
          decoration: InputDecoration(
              labelText: 'Date',border: OutlineInputBorder()),
        ),
        SizedBox(
          height: 30,
        ),
        TextFormField(
          controller: locationcontroller,
          decoration: InputDecoration(
              labelText: 'Location',border: OutlineInputBorder()),
        ),
        SizedBox(
          height: 30,
        ),
        TextFormField(
          controller: timecontroller,
          decoration: InputDecoration(
              labelText: 'Time',border: OutlineInputBorder()),
        ),
        SizedBox(
          height: 50,
        ),
        OutlinedButton(onPressed: () {
          if(namecontroller.text.isNotEmpty && sizecontroller.text.isNotEmpty && datecontroller.text.isNotEmpty && locationcontroller.text.isNotEmpty && timecontroller.text.isNotEmpty){
            print("Adding data.....");
            insertData(namecontroller.text, sizecontroller.text, datecontroller.text, locationcontroller.text, timecontroller.text);
          }}, child: Text(
          "Add Class",
          style: TextStyle(fontSize: 18),
        ))
      ],
    ),
    )
    ),
    );
  }

  Future<void> insertData(String name, String size, String date, String location, String time) async {
    await FirebaseFirestore.instance.collection("listing").doc('default').set({
      "name": name,
      "size": size,
      "date": date,
      "location": location,
      "time" : time
    });
  }
}
