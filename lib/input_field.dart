 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutor_me/Screens/classesEnrolled.dart';

class MyInputField extends StatelessWidget{
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const MyInputField({Key? key,
  required this.title,
  required this.hint,
  this.controller,
  this.widget}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(title,
          //   style:headingStyle,
          //   ),
          Container(
            height:52,
            margin: EdgeInsets.only(top: 8),
            decoration:BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0
            ),
              borderRadius: BorderRadius.circular(12)
          ),
            child: Row(
              children: [
                Expanded(child: TextFormField(
                  readOnly: widget==null?false:true,
                  autofocus: false,
                  controller: controller,
                  decoration:  InputDecoration(
                    hintText: hint,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    ),
                  )),
                widget==null? Container() : Container(child: widget),
            ]),
          )]
      ),
    );
  }

}