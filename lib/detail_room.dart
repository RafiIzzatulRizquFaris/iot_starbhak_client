import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailRoom extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DetailRoomState();
  }

}

class DetailRoomState extends State<DetailRoom>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "Manage Bathroom",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
              },
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.blue,
                  size: 30,
                ),
                onPressed: () {
                  ScrollController scrollController = ScrollController();
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return Form(
                        autovalidateMode: AutovalidateMode.always,
                        child: Container(
                            child: SingleChildScrollView(
                              controller: scrollController,
                              padding: EdgeInsets.all(20),
                              reverse: true,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .top),
                                  ),
                                  Text(
                                    "Add New Device",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Enter Device's Name",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8,),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "Device's name",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  Text(
                                    "Select Device's Icon",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8,),
                                  GridView.builder(
                                    controller: scrollController,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(right: 10, left: 10, bottom: 10, top: 10),
                                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.blue,
                                            style: BorderStyle.solid,
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Icon(
                                                Icons.lightbulb_outline,
                                                color: Colors.blue,
                                                size: 40,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Bathroom",
                                              maxLines: 1,
                                              softWrap: false,
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(fontSize: 14, color: Colors.blue),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: 6,
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                                    shrinkWrap: true,
                                  ),
                                  SizedBox(height: 15,),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.all(8)),
                                        shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),)),
                                        backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.blue),
                                      ),
                                      child: Text(
                                        "Save",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                  ),
                                ],
                              ),
                            )
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: GridView.builder(
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              margin: (index % 2) == 0
                  ? EdgeInsets.only(right: 10, bottom: 10, top: 10)
                  : EdgeInsets.only(left: 10, bottom: 10, top: 10),
              padding:
              EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.lightbulb,
                    color: Colors.amber,
                    size: 50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Main Light Bulb",
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Status : ",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "ON",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.amber,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              padding:
                              MaterialStateProperty.resolveWith(
                                      (states) => EdgeInsets.all(8)),
                              shape: MaterialStateProperty.resolveWith(
                                      (states) => RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(5),
                                  )),
                              backgroundColor:
                              MaterialStateProperty.resolveWith(
                                      (states) => Colors.blue),
                            ),
                            child: Text(
                              "Turn Off",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          itemCount: 11,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          shrinkWrap: true,
        ),
      ),
    );
  }

}