import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tutor_me/Screens/classesEnrolled.dart';
import 'package:tutor_me/input_field.dar.dart';

import 'button.dart';

class MyUpload extends StatefulWidget {
  const MyUpload({Key? key}) : super(key: key);

  @override
  State<MyUpload> createState() => _MyUploadState();
}

class _MyUploadState extends State<MyUpload> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = "10:30 PM";

  final DatabaseRef = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Class",
                style: headingStyle,
              ),
              MyInputField(title: "Title",
                  hint: "Enter the name of your class",
                  widget: widget, controller: _titleController,),
              MyInputField(title: "Location",
                  hint: "Enter the Location",
                  widget: widget,controller: _locationController,),
              MyInputField(title: "Class size",
                  hint: "Enter the class size",
                  widget: widget, controller: _sizeController,),
              MyInputField(
                title: "Date", hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: const Icon(Icons.calendar_today_outlined,
                      color: Colors.grey),
                  onPressed: () {
                    _getDateFromUser();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: MyInputField(title: "Start Time", hint: _startTime, widget: IconButton(
                        onPressed: (){
                          _getTimeFromUser(true);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ) ,)),
                  SizedBox(width: 12,),
                  Expanded(
                      child: MyInputField(title: "End Time", hint: _endTime, widget: IconButton(
                        onPressed: (){
                          _getTimeFromUser(false);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ) ,
                      ),
                  ),
                ],
              ),
              SizedBox(height: 18,),
              Row(
                children: [
                  MyButton(label:"Create Class", onTap: ()=> _validateData())
                    ],
                  )
                ],
          ),
        )
      )
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2121)
    );
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    }
    else {
      print("Its null or something is wrong");
    }
  }
  _getTimeFromUser(bool isStartTime) async {
    var pickedTime = await _showTimePicker();
    String _formattedTime = pickedTime.format(context);
    if(pickedTime == null){
      print("Time cancelled");
    }
    else if(isStartTime == true){
      setState(() {
        _startTime = _formattedTime;
      });
    }
    else if(isStartTime == false){
      setState(() {
        _endTime = _formattedTime;
      });
    }
  }

  _showTimePicker(){
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse((_startTime.split(":")[1].split(" ")[0]),
            )
        )
    );
  }

  _validateData(){
    if(_titleController.text.isNotEmpty&&_locationController.text.isNotEmpty&&_sizeController.text.isNotEmpty){
      _addUploadToDb(_titleController.text,_locationController.text,_sizeController.text,_selectedDate.toString(),_startTime.toString(),_endTime.toString());
      Get.back();
    }
    else if(_titleController.text.isEmpty || _locationController.text.isEmpty || _sizeController.text.isEmpty){
      Get.snackbar("Required", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.red,
        icon: const Icon(Icons.warning_amber_rounded)
      );
    }
  }

  _addUploadToDb(String title, String location, String size, String date, String startTime, String endTime){
    DatabaseRef.push().set({
      "title": title,
      "location": location,
      "size": size,
      "date": date,
      "startTime" : startTime,
      "endTime":endTime
    });

}
}