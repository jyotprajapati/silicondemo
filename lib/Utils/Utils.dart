import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:silicondemo/Models/photoModel.dart';

enum sort {
  Time_Latest_first,
}

querySelector(String? value) {
  var query;
  if (value == 'Time - Latest first') {
    query = FirebaseFirestore.instance
        .collection('photos')
        .orderBy("date")
        .snapshots();
  } else if (value == 'TIme - Latest last') {
    query = FirebaseFirestore.instance
        .collection('photos')
        .orderBy("date", descending: true)
        .snapshots();
  } else {
    query = FirebaseFirestore.instance
        .collection('photos')
        .orderBy("name")
        .snapshots();
  }
  return query;
}

//
List<PhotoCard> makeDisplayList(
    {required List checkValue, snapshot, required List authername}) {
  // List<DocumentSnapshot> displayList = [];
  List<PhotoCard> displayList = [];
  if (checkValue.length == 0 || checkValue[0] == true) {
    for (int i = 0; i < snapshot.data!.size; i++) {
      displayList.add(PhotoCard.fromDocument(snapshot.data!.docs[i]));
    }
  } else {
    for (int i = 0; i < snapshot.data!.size; i++) {
      for (int j = 1; j < checkValue.length; j++) {
        if (checkValue[j] == true) {
          if (snapshot.data!.docs[i]['name'] == authername[j]) {
            displayList.add(PhotoCard.fromDocument(snapshot.data!.docs[i]));
          }
        }
      }
    }
  }
  return displayList;
}
