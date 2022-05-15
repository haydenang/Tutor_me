import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutor_me/ListingModel.dart';


class viewListing extends StatelessWidget {
  final ListingModel listingModel;
  const viewListing({Key? key, required this.listingModel}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(listingModel.name),),
      body: Column(
        children: [
          Text(listingModel.time)
        ],),
    );
  }

}