import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutor_me/ListingClass.dart';


class viewListing extends StatelessWidget {
  final ListingClass listingclass;
  const viewListing({Key? key, required this.listingclass}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(listingclass.name),),
      body: Column(
        children: [
          Text(listingclass.time)
        ],),
    );
  }

}