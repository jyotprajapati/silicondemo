import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  //Add data to firestore collection and doc by doc id
  Future<void> addToFireStoreDocId(
      String collectionName, String docId, Map<String, dynamic> dataMap) async {
    try {
      var result = await _db.collection(collectionName).doc(docId).set(dataMap);
      return result;
    } catch (e) {
      print(e);
    }
  }

  addToCollection(
    String collectionName,
    Map<String, dynamic> dataMap,
  ) async {
    return await FirebaseFirestore.instance
        .collection(collectionName)
        .add(dataMap)
        .catchError((e) {
      print(e.toString());
    });
  }
}
