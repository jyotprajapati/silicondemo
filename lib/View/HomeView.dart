import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:silicondemo/Common/DatabaseMethods.dart';
import 'package:silicondemo/Service/UploadData.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController name = new TextEditingController();
  TextEditingController imageURL = new TextEditingController();
  TextEditingController description = new TextEditingController();
  var heart = Icons.favorite_border;
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Galary"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.filter_list),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.sort),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('photos').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (_, index) {
                DocumentSnapshot doc = snapshot.data!.docs[index];

                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Image.network(
                            doc['imageURL'],
                          )),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                                child: IconButton(
                                    onPressed: () {
                                      heart == Icons.favorite
                                          ? Icons.favorite_border
                                          : Icons.favorite;
                                      setState(() {});
                                    },
                                    icon: Icon(heart))),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.black.withOpacity(0.3),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      doc['description'],
                                      textAlign: TextAlign.start,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // DateFormat('yyyy-MM-dd – kk:mm').format(now);
                                      Text(
                                          "${doc['date']} ${months[doc['month'] - 1]} ${doc['year']}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10)),
                                      //  months.indexOf(doc['date'].split(' ')[0]) + 1, int.parse(doc['date'].substring(doc['date'].length - 8, doc['date'].length - 6))}"),
                                      Text(
                                        "-${doc['name']}",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                );
              },
              itemCount: snapshot.data!.size,
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFF68F50),
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Center(
                  child: Text(
                "Add Photo",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              content:
                  //  Row(
                  //   children: [
                  //     Column(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         Text("Photographer Name "),
                  //         Text("Image URL "),
                  //         Text("Description ")
                  //       ],
                  //     ),
                  //     Expanded(
                  //       child: Column(
                  //         children: [
                  //           TextField(
                  //             decoration: InputDecoration(
                  //               hintText: 'Enter Text',
                  //               border: OutlineInputBorder(),
                  //             ),
                  //           ),
                  //           TextField(
                  //             decoration: InputDecoration(
                  //               hintText: 'Enter Text',
                  //               border: OutlineInputBorder(),
                  //             ),
                  //           ),
                  //           TextField(
                  //             decoration: InputDecoration(
                  //               hintText: 'Enter Text',
                  //               border: OutlineInputBorder(),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     )
                  //   ],
                  // ),
                  Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("Photographer Name "),
                        Expanded(
                          child: TextField(
                            controller: name,
                            decoration: InputDecoration(
                              hintText: 'Enter Text',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("Image URL "),
                        Expanded(
                          child: TextField(
                            controller: imageURL,
                            decoration: InputDecoration(
                              hintText: 'Enter Text',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("Description "),
                        Expanded(
                          child: TextField(
                            controller: description,
                            decoration: InputDecoration(
                              hintText: 'Enter Text',
                              border: OutlineInputBorder(),
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
                          color: Color(0xFFF68F50),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "CANCEL",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          UploadData().uploadData(
                              name.text, imageURL.text, description.text);
                          Navigator.pop(context);
                        },
                        child: Card(
                          color: Color(0xFFF68F50),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "ADD",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
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
