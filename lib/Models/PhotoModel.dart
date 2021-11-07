import 'package:cloud_firestore/cloud_firestore.dart';

class PhotoCard {
  String? name;
  Timestamp? uploadTime;
  String? desc;
  String? imageURL;
  bool? like;
  String docId;

  PhotoCard(
      {required this.name,
      required this.uploadTime,
      required this.desc,
      required this.imageURL,
      required this.docId,
      this.like});

  factory PhotoCard.fromDocument(DocumentSnapshot doc) {
    Map? data = doc.data() as Map?;
    return PhotoCard(
        name: data!['name'],
        uploadTime: data['date'],
        desc: data['description'],
        imageURL: data['imageURL'],
        docId: doc.id);
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'name': name,
      'imageURL': imageURL,
      'description': desc,
      'liked': like,
      'date': uploadTime,
      'docId': docId
    };
    return data;
  }
}
