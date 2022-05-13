import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tutor_me/Screens/loginPage.dart';

// main() {
//   runApp(MyClassesEnrolled());
// }

// class MyClassesEnrolled extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MaterialApp(
//       home: ClassesEnrolled(),
//     );
//     //throw UnimplementedError();
//   }
// }

class ClassesEnrolled extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    //throw UnimplementedError();
    return _ClassesEnrolledState();
  }
}

class _ClassesEnrolledState extends State<ClassesEnrolled> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Scaffold(
      body: Column(children: [
        _addTaskBar(context),
        _addDateBar(),
      ]),
    );
  }
}

_addTaskBar(BuildContext context) {
  return Container(
    alignment: Alignment.topLeft,
    margin: const EdgeInsets.only(top: 30, left: 5),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMMd().format(DateTime.now()),
              style: subHeadingStyle,
            ),
            Text(
              "Today",
              style: headingStyle,
            ),
          ],
        ),
        //Logout Button
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.grey,
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  });
                }),
          ],
        ),
      ],
    ),
  );
}

_addDateBar() {
  return Container(
      margin: const EdgeInsets.only(top: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.blueAccent,
        selectedTextColor: Colors.white,
        dateTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ));
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  ));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ));
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  ));
}
