import 'package:silicondemo/Service/DatabaseMethods.dart';

class UpdateData {
  updateData({
    collectionName,
    docId,
    name,
    imageURL,
    description,
    liked,
    date,
  }) {
    DataBaseMethods().addToFireStoreDocId(collectionName, docId, {
      'name': name,
      'imageURL': imageURL,
      'description': description,
      'liked': liked,
      'date': date,
    });
  }
}
