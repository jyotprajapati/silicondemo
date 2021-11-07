import 'package:flutter/material.dart';
import 'package:silicondemo/Models/photoModel.dart';
import 'package:silicondemo/Service/UpdateData.dart';
import 'package:silicondemo/Utils/Colors.dart';
import 'package:silicondemo/Utils/Constant.dart';
import 'package:silicondemo/Utils/Style.dart';

pictureBox({
  //PhotoCard
  //photoCard.imageURL
  var displayList,
  required PhotoCard photoCard,
  required List months,
  // required int index,
  Function? setState,
}) {
  return Stack(
    children: [
      Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: AspectRatio(
            aspectRatio: 1 / 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: FittedBox(
                fit: BoxFit.fill,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    photoCard.imageURL ?? "",
                    // displayList[index]['imageURL'],
                  ),
                ),
              ),
            )),
      ),
      Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 10,
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                child: IconButton(
                  onPressed: () {
                    final photoMap = photoCard.toMap();
                    photoCard.like == true
                        ? UpdateData().updateData(
                            collectionName: 'photos',
                            docId: photoMap['docId'],
                            date: photoMap['date'],
                            description: photoMap['description'],
                            imageURL: photoMap['imageURL'],
                            liked: false,
                            name: photoMap['name'],
                          )
                        : UpdateData().updateData(
                            collectionName: 'photos',
                            docId: photoMap['docId'],
                            date: photoMap['date'],
                            description: photoMap['description'],
                            imageURL: photoMap['imageURL'],
                            liked: true,
                            name: photoMap['name'],
                          );
                    setState!();
                  },
                  icon: Icon(
                    photoCard.like == false
                        ? Icons.favorite_border
                        : Icons.favorite,
                    color: photoCard.like == false ? secondaryColor : likeColor,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          photoCard.desc ?? "",
                          // displayList[index]['description'],
                          textAlign: TextAlign.start,
                          style: normalText,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                  "${DateTime.parse(photoCard.uploadTime!.toDate().toString()).day} ${months[DateTime.parse(photoCard.uploadTime!.toDate().toString()).month - 1]} ${DateTime.parse(photoCard.uploadTime!.toDate().toString()).year}",
                                  style: dateText),
                            ),
                            Text(
                              "-by ${photoCard.name}",
                              textAlign: TextAlign.end,
                              style: nameText,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ],
  );
}
