import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_starbhak_client/account.dart';
import 'package:iot_starbhak_client/history_screen.dart';
import 'package:iot_starbhak_client/info.dart';
import 'package:iot_starbhak_client/manage_member.dart';
import 'package:iot_starbhak_client/manage_room.dart';
import 'package:iot_starbhak_client/member_contract.dart';
import 'package:iot_starbhak_client/member_model.dart';
import 'package:iot_starbhak_client/member_presenter.dart';
import 'package:page_transition/page_transition.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home>
    with TickerProviderStateMixin
    implements MemberContractView {
  AnimationController logoAnimationController;
  Animation logoAnimation;
  ScrollController scrollController;
  MemberPresenter memberPresenter;
  String _area = "Name";

  HomeState() {
    memberPresenter = MemberPresenter(this);
  }

  @override
  void initState() {
    logoAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 1,
      ),
      value: 0.1,
    );
    logoAnimation = CurvedAnimation(
      curve: Curves.easeInCirc,
      parent: logoAnimationController,
    );
    super.initState();
    scrollController = ScrollController();
    memberPresenter.loadMemberData();
  }

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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Star",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "IOT",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: SvgPicture.asset(
                    "assets/drawer.svg",
                    width: 28,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                    logoAnimationController.forward();
                  },
                );
              },
            ),
            actions: [
              IconButton(
                icon: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(1000),
                  ),
                  child: SizedBox.expand(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(1000)),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/health-shelter.appspot.com/o/800px-Image_created_with_a_mobile_phone.png?alt=media&token=5461c81c-7aae-4dd5-b43b-c8c7a82bad44"),
                      ),
                    ),
                  ),
                ),
                padding: EdgeInsets.all(0),
                onPressed: () {
                  logoAnimationController.reverse();
                  Navigator.push(
                    context,
                    PageTransition(
                      child: Account(),
                      type: PageTransitionType.scale,
                      duration: Duration(
                        milliseconds: 500,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome To\n$_area's Place",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue.shade400,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.sensor_door_rounded,
                                color: Colors.white,
                                size: 50,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "The front door is locked!",
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.amber,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Would you like to unlocked it?",
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RawMaterialButton(
                            onPressed: () {},
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            fillColor: Colors.blue,
                            child: Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(10),
                            shape: CircleBorder(),
                            constraints:
                                BoxConstraints.expand(width: 42, height: 42),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "General Environment",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                StaggeredGridView.builder(
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    return Container(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.lightbulb,
                            color: Colors.amber,
                            size: 50,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              SizedBox(
                                height: 8,
                              ),
                              Row(
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
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.resolveWith(
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
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "On for last 3 Hours",
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: 2,
                  gridDelegate:
                      SliverStaggeredGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                          staggeredTileCount: 2,
                          crossAxisSpacing: 10),
                  shrinkWrap: true,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.list,
                            color: Colors.amber,
                            size: 50,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "January 19 Bill",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Due Date : ",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      "6 Days",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.amber),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            children: [
                              Text(
                                "450",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "Units",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.monetization_on_rounded,
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text("Bill Amount"),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Rp. 400,500.00",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "View Breakdown",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            onPressed: () {},
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.resolveWith(
                                  (states) => EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 10,
                                      )),
                              shape: MaterialStateProperty.resolveWith(
                                  (states) => RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      )),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => Colors.blue),
                            ),
                            child: Text(
                              "Pay Bill",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(10),
          ),
          child: Drawer(
            elevation: 0,
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              children: [
                DrawerHeader(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Star",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "IOT",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onTap: () {
                    logoAnimationController.reverse();
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    Icons.dashboard,
                    size: 30,
                  ),
                  title: Text(
                    "Dashboard",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  tileColor: Colors.blue.withAlpha(50),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        PageTransition(
                            child: ManageRoom(),
                            type: PageTransitionType.leftToRightWithFade,
                            duration: Duration(milliseconds: 500)));
                  },
                  leading: Icon(
                    Icons.room_preferences,
                    size: 30,
                  ),
                  title: Text(
                    "Manage Room",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        PageTransition(
                            child: ManageMember(),
                            type: PageTransitionType.leftToRightWithFade,
                            duration: Duration(milliseconds: 500)));
                  },
                  leading: Icon(
                    Icons.accessibility_rounded,
                    size: 30,
                  ),
                  title: Text(
                    "Manage Client Member",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        PageTransition(
                            child: HistoryScreen(),
                            type: PageTransitionType.leftToRightWithFade,
                            duration: Duration(milliseconds: 500)));
                  },
                  leading: Icon(
                    Icons.toc,
                    size: 30,
                  ),
                  title: Text(
                    "Report Status Device",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      PageTransition(
                        child: Info(),
                        type: PageTransitionType.leftToRightWithFade,
                      ),
                    );
                  },
                  leading: Icon(
                    Icons.info,
                    size: 30,
                  ),
                  title: Text(
                    "Info",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  setOnErrorMemberData(error) {
    print(error);
  }

  @override
  setOnSuccessMemberData(MemberModel memberModel) {
    if (memberModel.success) {
      setState(() {
        _area = memberModel.message.replaceAll("members", "").trim();
      });
    } else {
      print(memberModel.message);
    }
  }
}
