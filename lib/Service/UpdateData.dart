import 'package:silicondemo/Common/DatabaseMethods.dart';

class UpdateData {
  updateData(
      {collectionName,
      docId,
      name,
      imageURL,
      description,
      liked,
      date,
      month,
      year}) {
    DataBaseMethods().addToFireStoreDocId(collectionName, docId, {
      'name': name,
      'imageURL': imageURL,
      'description': description,
      'liked': liked,
      'date': date,
      'month': month,
      'year': year,
    });
  }
}
