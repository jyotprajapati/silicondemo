import 'package:silicondemo/Service/DatabaseMethods.dart';

class UploadData {
  uploadData(String? name, String imageURL, String? description) {
    bool value = DataBaseMethods().addToCollection("photos", {
      'name': name,
      'imageURL': imageURL,
      'description': description,
      'liked': false,
      'date': DateTime.now()
    });

    return value;
  }
}
