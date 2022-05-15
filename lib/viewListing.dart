import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_me/Classes/ListingClass.dart';
import 'package:firebase_auth/firebase_auth.dart';


main() {
  runApp(MaterialApp(
      home: viewListing(
        listingclass: ListingClass("Algo", "prof", "22-05-2022","Tampines",'20','730pm', '830pm'),)
  ));
}

class viewListing extends StatelessWidget {
  final ListingClass listingclass;
  const viewListing({Key? key, required this.listingclass}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(listingclass.name),),
      body: Container(
        margin: EdgeInsets.only(left: 5),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text("Location: " + listingclass.location,
          style: subHeadingStyle),
          const SizedBox(
            height: 5,
          ),
          Text("Tutor: " + listingclass.tutorName,
                  style: subHeadingStyle),
              const SizedBox(
                height: 5,
              ),
          Text("Date: " + listingclass.date,
              style: subHeadingStyle),
          const SizedBox(
            height: 5,
          ),
          Text("Time: " + listingclass.start_time + " - " + listingclass.end_time,
              style: subHeadingStyle),
          const SizedBox(
            height: 5,
          ),
          Text("Class size: " + listingclass.size,
              style: subHeadingStyle
          ),

          ElevatedButton(
                child: Text('Enroll for this'),
                onPressed: () {
                  
                },
              ),

        ],),
        

    ));
  }

}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        // color: Colors.grey,
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



