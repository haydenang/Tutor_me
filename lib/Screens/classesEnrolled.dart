import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tutor_me/Screens/loginPage.dart';
import 'package:tutor_me/listing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutor_me/ListingClass.dart';
import 'package:tutor_me/viewListing.dart';

import '../upload.dart';

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
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    //throw UnimplementedError();
    return _ClassesEnrolledState();
  }
}

class _ClassesEnrolledState extends State<ClassesEnrolled> {
  //For datepicker,
  DateTime? selectedDate;

  //For nav bar,
  int currentIndex = 0; //Current icon selected
  Scaffold? selectScreen(int index) {
    if (index == 0) {
      return Scaffold(
          body: StreamBuilder<QuerySnapshot>(
        stream: widget._firestore.collection('listing').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('Loading...');
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length, //QuerySnapshot.size,
            itemBuilder: (context, index) {
              print(snapshot.data!.docs[index]['date']);
              if (selectedDate
                  .toString()
                  .contains(snapshot.data!.docs[index]['date'])) {
                return Card(
                    child: ListTile(
                  title: Text(snapshot.data!.docs[index]['name']),
                  leading: const Icon(
                    Icons.person,
                    size: 50,
                  ),
                  trailing: Text(snapshot.data!.docs[index]['date']),
                  subtitle: Text(snapshot.data!.docs[index]['location']),
                  onTap: () {
                    ListingClass listingclass = new ListingClass(
                        snapshot.data!.docs[index]['name'],
                        snapshot.data!.docs[index]['date'],
                        snapshot.data!.docs[index]['location'],
                        snapshot.data!.docs[index]['size'],
                        snapshot.data!.docs[index]['start time'],
                        snapshot.data!.docs[index]['end time']);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => viewListing(
                              listingclass: listingclass,
                            )));
                  },
                ));
              } else {
                return SizedBox(
                  height: 0,
                );
              }
            },
          );
        },
      ));
    } else if (index == 1) {
      //Need to implement the feature of filtering by enrollment
      return Scaffold(
          body: StreamBuilder<QuerySnapshot>(
        stream: widget._firestore.collection('listing').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('Loading...');
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length, //QuerySnapshot.size,
            itemBuilder: (context, index) {
              if (selectedDate
                  .toString()
                  .contains(snapshot.data!.docs[index]['date'])) {
                return Card(
                    child: ListTile(
                  title: Text(snapshot.data!.docs[index]['name']),
                  leading: const Icon(
                    Icons.person,
                    size: 50,
                  ),
                  trailing: Text(snapshot.data!.docs[index]['date']),
                  subtitle: Text(snapshot.data!.docs[index]['location']),
                  onTap: () {
                    ListingClass listingclass = new ListingClass(
                        snapshot.data!.docs[index]['name'],
                        snapshot.data!.docs[index]['date'],
                        snapshot.data!.docs[index]['location'],
                        snapshot.data!.docs[index]['size'],
                        snapshot.data!.docs[index]['start time'],
                        snapshot.data!.docs[index]['end time']);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => viewListing(
                              listingclass: listingclass,
                            )));
                  },
                ));
              } else {
                return SizedBox(
                  height: 0,
                );
              }
            },
          );
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Scaffold(
      body: Column(children: [
        _addTaskBar(context),
        //Replaced the _addDateBar() with the actual UI, not so sure how to implement onDateChange: otherwise.
        Container(
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
              onDateChange: (date) {
                setState(() {
                  print(date.toString());
                  selectedDate = date;
                });
              },
            )),
        Container(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height - 343.4,
              maxWidth: MediaQuery.of(context).size.width),
          child: selectScreen(currentIndex),
        ),
        BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 2,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          iconSize: 25,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "All Classes",
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_added),
                label: "Enrolled",
                backgroundColor: Colors.black)
          ],
        )
      ]),
    );
  }
}

_addTaskBar(BuildContext context) {
  return Column(
    children: [
      Container(
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
                        Fluttertoast.showToast(
                            msg: "Successfully Logged Out",
                            gravity: ToastGravity.BOTTOM,
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.black87,
                            fontSize: 16);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      });
                    }),
                const SizedBox(
                  height: 40,
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyUpload()));
                  },
                  child: const Text(
                    " Add a class ",
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

//Missing onDateChange
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
