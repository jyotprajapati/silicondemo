import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:silicondemo/Models/photoModel.dart';

import 'package:silicondemo/Service/UpdateData.dart';
import 'package:silicondemo/Service/UploadData.dart';
import 'package:silicondemo/Utils/Colors.dart';
import 'package:silicondemo/Utils/Constant.dart';
import 'package:silicondemo/Utils/Style.dart';
import 'package:silicondemo/Utils/Utils.dart';
import 'package:silicondemo/Widgets/PictureBox.dart';

enum ClassType { A, B, C, D }

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController name = new TextEditingController();
  TextEditingController imageURL = new TextEditingController();
  TextEditingController description = new TextEditingController();
  // var heart = Icons.favorite_border;

  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];
  int sort = 0;

  var query = FirebaseFirestore.instance
      .collection('photos')
      .orderBy("date")
      .snapshots();

  List authors = [];
  List displayList = [];
  List<String> authername = [];
  List<String> authername2 = [];
  List<bool> checkValue = [];

  getAuthers() async {
    var authorsQuery = await FirebaseFirestore.instance
        .collection('photos')
        .orderBy("name")
        .get();
    // var length = await authorsQuery.length;
    authors = authorsQuery.docs.map((e) => e['name']).toList();

    authername2.add("All");
    for (int i = 0; i < authors.length; i++) authername2.add(authors[i]);
    authername = authername2.toSet().toList();

    for (int i = 0; i < authername.length; i++) checkValue.add(false);
  }

  @override
  void initState() {
    super.initState();
    getAuthers();
    checkValue.add(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Galary"),
        backgroundColor: primaryColor,
        actions: [
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: DropdownButton<String>(
              underline: SizedBox(
                width: 0,
              ),
              icon: Icon(
                Icons.filter_list,
                color: Colors.white,
              ),
              onChanged: (String? value) {
                query = querySelector(value);
                setState(() {});
              },
              items: <String>[
                'Time - Latest first',
                'TIme - Latest last',
                'Name'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          DropdownButton<String>(
            underline: SizedBox(
              width: 0,
            ),
            icon: Icon(
              Icons.sort,
              color: Colors.white,
            ),
            onChanged: (String? value) {
              setState(() {});
            },
            items: authername.map((String aname) {
              return DropdownMenuItem<String>(
                  value: aname,
                  child: Row(
                    children: [
                      Checkbox(
                        value: checkValue[authername.indexOf(aname)],
                        onChanged: (value) async {
                          if (checkValue[0] == true &&
                              authername.indexOf(aname) != 0) {
                            checkValue[0] = false;
                          }
                          checkValue[authername.indexOf(aname)] =
                              checkValue[authername.indexOf(aname)] == true
                                  ? false
                                  : true;

                          setState(() {});
                        },
                      ),
                      Text(aname)
                    ],
                  ));
            }).toList(),
          ),
          // Padding(
          //   padding: EdgeInsets.all(defaultPadding),
          //   child: DropdownButton<String>(
          //     underline: SizedBox(),
          //     icon: Icon(
          //       Icons.sort,
          //       color: secondaryColor,
          //     ),
          //     onChanged: (String? value) {
          //       setState(() {});
          //     },
          //     items: authername.map((String aname) {
          //       return DropdownMenuItem<String>(
          //           value: aname,
          //           child: Row(
          //             children: [
          //               Checkbox(
          //                 value: checkValue[authername.indexOf(aname)],
          //                 onChanged: (value) async {
          //                   if (checkValue[0] == true &&
          //                       authername.indexOf(aname) != 0) {
          //                     checkValue[0] = false;
          //                   }
          //                   checkValue[authername.indexOf(aname)] =
          //                       checkValue[authername.indexOf(aname)] == true
          //                           ? false
          //                           : true;

          //                   setState(() {});
          //                 },
          //               ),
          //               Text(aname)
          //             ],
          //           ));
          //     }).toList(),
          //   ),
          // ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: query,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<PhotoCard> displayList = makeDisplayList(
                authername: authername,
                checkValue: checkValue,
                snapshot: snapshot);
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: displayList.length,
              itemBuilder: (
                _,
                index,
              ) {
                return pictureBox(
                    months: months,
                    photoCard: displayList[index],
                    displayList: displayList,
                    setState: () {
                      setState(() {});
                    });
              },
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: buttonColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Center(
                  child: Text(
                "Add Photo",
                style: buttonText,
              )),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: defaultPaddingSmall),
                          child: Text(
                            "Photographer Name ",
                            style: buttonText2,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 30,
                            child: Align(
                              alignment: Alignment.center,
                              child: TextField(
                                controller: name,
                                style: fieldText,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: defaultPaddingSmall2),
                                  hintText: 'Enter Text',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // Text("Image URL "),
                        Padding(
                          padding: const EdgeInsets.only(right: 38),
                          child: Text(
                            "Image URL       ",
                            style: buttonText2,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 30,
                            child: TextField(
                              controller: imageURL,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: defaultPaddingSmall2),
                                hintText: 'Enter Text',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // Text("Description "),
                        Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: Text(
                            "Description ",
                            style: buttonText2,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 30,
                            child: TextField(
                              controller: description,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: defaultPaddingSmall2),
                                hintText: 'Enter Text',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          return Navigator.pop(context);
                        },
                        child: Card(
                          color: buttonColor,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(25, 8, 25, 8),
                            child: Text(
                              "CANCEL",
                              style: buttonText3,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          bool value = UploadData().uploadData(
                              name.text, imageURL.text, description.text);

                          if (value == false) {
                            SnackBar(content: Text("Error"));
                          }
                          Navigator.pop(context);
                        },
                        child: Card(
                          color: buttonColor,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(35, 8, 35, 8),
                            child: Text(
                              "ADD",
                              style: buttonText3,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
