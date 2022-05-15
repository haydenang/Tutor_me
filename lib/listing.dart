import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutor_me/ListingClass.dart';
import 'package:tutor_me/viewListing.dart';

class Listing extends StatefulWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  _ListingState createState() => _ListingState();
}

class _ListingState extends State<Listing> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget._firestore.collection('listing').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData){
          return Text('Loading...');
        }
        return ListView.builder(
          itemCount: snapshot.data?.docs.length, //QuerySnapshot.size,
          itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(snapshot.data!.docs[index]['name']),
              leading: const SizedBox(
                width: 50,
                height: 50,
              ),
              onTap: (){
                ListingClass listingclass = new ListingClass(snapshot.data!.docs[index]['name'], snapshot.data!.docs[index]['date'], snapshot.data!.docs[index]['location'], snapshot.data!.docs[index]['size'], snapshot.data!.docs[index]['time']);
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>viewListing(listingclass: listingclass, )));
              },
            ),);
        });
      },
    );
  }
}

