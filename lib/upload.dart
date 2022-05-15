import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tutor_me/input_field.dart';

import 'Classes/MyUser.dart';
import 'Screens/classesEnrolled.dart';

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
  String _selectedDate = "  Date";
  //DateTime.now();
  String _startTime = "   Start Time";
  //DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = "   End Time";
  //"10:00 PM";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Builder(
          builder: (context) => Column(
            children: [
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
                    labelText: 'Class Name', border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: sizecontroller,
                decoration: InputDecoration(
                    labelText: 'Class Size', border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 30,
              ),
              // TextFormField(
              //   controller: datecontroller,
              //   decoration: InputDecoration(
              //       labelText: 'Date', border: OutlineInputBorder()),
              // ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: locationcontroller,
                decoration: InputDecoration(
                    labelText: 'Location', border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 30,
              ),
              MyInputField(
                  title: "Date",
                  hint: _selectedDate,
                  widget: IconButton(
                      icon: Icon(Icons.calendar_today_outlined),
                      onPressed: () {
                        _getDateFromUser(context);
                      })),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                      child: MyInputField(
                    title: "Start Time",
                    hint: _startTime,
                    widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(context, true);
                        },
                        icon: Icon(
                          Icons.access_time_filled_rounded,
                          color: Colors.grey,
                        )),
                  )),
                  SizedBox(width: 14),
                  Expanded(
                      child: MyInputField(
                    title: "End Time",
                    hint: _endTime,
                    widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(context, false);
                        },
                        icon: Icon(
                          Icons.access_time_filled_rounded,
                          color: Colors.grey,
                        )),
                  ))
                ],
              ),
              // TextFormField(
              //   controller: timecontroller,
              //   decoration: InputDecoration(
              //       labelText: 'Time', border: OutlineInputBorder()),
              // ),
              SizedBox(
                height: 50,
              ),
              OutlinedButton(
                  onPressed: () {
                    if (namecontroller.text.isNotEmpty &&
                        sizecontroller.text.isNotEmpty &&
                        locationcontroller.text.isNotEmpty) {
                      print("Adding data.....");
                      insertData(namecontroller.text, sizecontroller.text,
                          locationcontroller.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClassesEnrolled()));
                    }
                  },
                  child: Text(
                    "Add Class",
                    style: TextStyle(fontSize: 18),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> insertData(String name, String size, String location) async {
    MyUser? user;
    final ref = FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .withConverter(
          fromFirestore: MyUser.FromFirestore,
          toFirestore: (MyUser user, _) => user.toFirestore(),
        );
    final docSnap = await ref.get();
    user = docSnap.data();

    await FirebaseFirestore.instance.collection("listing").doc().set({
      "uid": FirebaseAuth.instance.currentUser!.uid,
      "tutorName": user?.getFullname(),
      "name": name,
      "size": size,
      "date": _selectedDate,
      "location": location,
      "start time": _startTime,
      "end time": _endTime,
    });
  }

  _getDateFromUser(context) async {
    DateTime? _pickDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2024));
    if (_pickDate != null) {
      setState(() {
        _selectedDate = DateFormat('yyyy-MM-dd').format(_pickDate);
      });
    } else {
      print("NULL date");
    }
  }

  _getTimeFromUser(context, isStartTime) async {
    String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
    var pickTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
          hour: int.parse(startTime.split(":")[0]),
          minute: int.parse(startTime.split(":")[1].split(" ")[0])),
      initialEntryMode: TimePickerEntryMode.input,
    );
    // final localizations = MaterialLocalizations.of(context);
    // final formattedTimeOfDay = localizations.formatTimeOfDay(pickTime);
    String _formattedTime = pickTime!.format(context);
    if (pickTime == null) {
      print("No time");
    } else if (isStartTime) {
      setState(() {
        _startTime = _formattedTime;
        print(_startTime);
      });
    } else if (!isStartTime) {
      setState(() {
        _endTime = _formattedTime;
        print(_endTime);
      });
    }
  }
}
