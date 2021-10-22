import 'package:silicondemo/Common/DatabaseMethods.dart';

class UploadData {
  uploadData(String? name, String imageURL, String? description) {
    DataBaseMethods().addToCollection("photos", {
      'name': name,
      'imageURL': imageURL,
      'description': description,
      'liked': false,
      'date': "${DateTime.now().day}",
      'month': DateTime.now().month,
      'year': "${DateTime.now().year}",
    });
  }
}
