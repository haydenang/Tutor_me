import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class cameraPage extends StatefulWidget {
  const cameraPage({Key? key}) : super(key: key);

  @override
  State<cameraPage> createState() => _cameraPageState();
}

class _cameraPageState extends State<cameraPage> {
  File? pictureFile;

  //AlertDialog to select camera or gallery
  Future<void> showDialogChoices(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Take Picture from:"),
            content: SingleChildScrollView(
                child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text("Gallery"),
                  onTap: () {
                    openGallery(context);
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text("Camera"),
                  onTap: () {
                    openCamera(context);
                  },
                ),
              ],
            )),
          );
        });
  }

  openGallery(BuildContext context) async {
    XFile? picture =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);
    this.setState(() {
      pictureFile = File(picture!.path);
    });
    Navigator.of(context).pop();
  }

  openCamera(BuildContext context) async {
    XFile? picture =
        await ImagePicker.platform.getImage(source: ImageSource.camera);
    this.setState(() {
      pictureFile = File(picture!.path);
    });
    Navigator.of(context).pop();
  }

  Widget decideImageView(File? pic) {
    if (pic == null) {
      return Icon(
        Icons.person_outline,
        size: 400,
      );
    } else {
      return Image.file(
        pic,
        width: 400,
        height: 400,
      );
    }
    // if (pictureFile == null) {
    //   return Icons.person_outline;
    // } else {
    //   return pictureFile;
    // }
  }

  @override
  Widget build(BuildContext context) {
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(16),
      color: Colors.blueAccent,
      shadowColor: Colors.amber,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {},
        child: Text(
          "Submit",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white60, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Verification Process"),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            decideImageView(pictureFile),
            SizedBox(
              height: 10,
            ),
            Center(
                child: RawMaterialButton(
              onPressed: () {
                showDialogChoices(context);
              },
              fillColor: Colors.blueAccent,
              elevation: 3,
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(10.0),
              shape: CircleBorder(),
            )),
            SizedBox(
              height: 20,
            ),
            Center(child: loginButton),
            SizedBox(
              height: 30,
            ),
          ]),
    );
  }
}
