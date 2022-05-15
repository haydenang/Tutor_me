import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_me/ListingClass.dart';


main() {
  runApp(MaterialApp(
      home: viewListing(
        listingclass: ListingClass("Algo","22-05-2022","Tampines",'20','730pm'),)
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
          Text("Date and Time: " + listingclass.date + "    " + listingclass.time,
              style: subHeadingStyle),
          const SizedBox(
            height: 5,
          ),
          Text("Class size: " + listingclass.size,
              style: subHeadingStyle
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