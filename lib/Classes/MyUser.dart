import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  String firstname = "";
  String surname = "";
  String email = "";
  String password = "";
  String uid = "";
  String profilePic = "";

  MyUser(String firstname, String surname, String email, String password,
      String uid) {
    setFirstName(firstname);
    setSurname(surname);
    setEmail(email);
    setPassword(password);
    setUID(uid);
  }

  String getFirstName() {
    return this.firstname;
  }

  void setFirstName(String firstname) {
    this.firstname = firstname;
  }

  String getSurname() {
    return this.surname;
  }

  void setSurname(String surname) {
    this.surname = surname;
  }

  String getEmail() {
    return this.email;
  }

  void setEmail(String email) {
    this.email = email;
  }

  String? getPassword() {
    return this.password;
  }

  void setPassword(String password) {
    this.password = password;
  }

  String getUID() {
    return this.uid;
  }

  void setUID(uid) {
    this.uid = uid;
  }

  String getPic() {
    if (this.profilePic.isEmpty || this.profilePic == null) {
      return "";
    }
    return this.profilePic;
  }

  void setPic(pic) {
    this.profilePic = pic;
  }

  String getFullname() {
    String first = getFirstName();
    String last = getSurname();
    return "${first} ${last}";
  }

  MyUser.FromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options)
      : firstname = snapshot.data()?["firstName"],
        surname = snapshot.data()?["surname"],
        email = snapshot.data()?["email"],
        password = snapshot.data()?["password"],
        uid = snapshot.data()?["uid"],
        profilePic = snapshot.data()?["profilePic"];

  Map<String, dynamic> toFirestore() {
    return {
      if (getFirstName() != null) "firstName": getFirstName(),
      if (getSurname() != null) "surname": getSurname(),
      if (getEmail() != null) "email": getEmail(),
      if (getPassword() != null) "password": getPassword(),
      if (getUID() != null) "uid": getUID(),
      if (getPic() != null) "profilePic": getPic()
    };
  }
}
