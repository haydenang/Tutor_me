import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutor_me/listingModel.dart';
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
<<<<<<< Updated upstream
        return ListView.builder(itemBuilder: (context, index) {
          String itemTitle = snapshot.data!.docs[index]['name'];
          return CardItem(itemTitle: itemTitle,);
=======
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
                ListingModel listingModel2 = new ListingModel(snapshot.data!.docs[index]['name'], snapshot.data!.docs[index]['date'], snapshot.data!.docs[index]['location'], snapshot.data!.docs[index]['size'], snapshot.data!.docs[index]['time']);
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>viewListing(listingModel: listingModel2, )));
              },
            ),);
>>>>>>> Stashed changes
        });
      },
    );
  }
}

<<<<<<< Updated upstream
class CardItem extends StatefulWidget {
  String itemTitle;
  CardItem({required this.itemTitle});
  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.itemTitle),
        trailing: Checkbox(
          value: isChecked,
          onChanged: (bool) {
            isChecked = !isChecked;
          },
        ),
      ),
    );
  }
}
=======
>>>>>>> Stashed changes
