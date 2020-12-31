import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_starbhak_client/detail_room.dart';
import 'package:page_transition/page_transition.dart';

class ManageRoom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ManageRoomState();
  }
}

class ManageRoomState extends State<ManageRoom> {
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
              "Manage Room",
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
                                  "Add New Room",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Enter Room's Name",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8,),
                                TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "Room's name",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                SizedBox(height: 15,),
                                Text(
                                  "Select Room's Icon",
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
                                              Icons.room_preferences_outlined,
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
            return FlatButton(
              padding: EdgeInsets.zero,
              onPressed: (){
                Navigator.push(context, PageTransition(child: DetailRoom(), type: PageTransitionType.fade));
              },
              child: Container(
                alignment: Alignment.center,
                margin: (index % 2) == 0
                    ? EdgeInsets.only(right: 10, bottom: 10, top: 10)
                    : EdgeInsets.only(left: 10, bottom: 10, top: 10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    style: BorderStyle.solid,
                  ),
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Icon(
                        Icons.room_preferences_outlined,
                        color: Colors.white,
                        size: 70,
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
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "3 Devices",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: 10,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          shrinkWrap: true,
        ),
      ),
    );
  }
}
