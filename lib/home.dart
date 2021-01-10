import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_starbhak_client/account.dart';
import 'package:iot_starbhak_client/area_contract.dart';
import 'package:iot_starbhak_client/area_presenter.dart';
import 'package:iot_starbhak_client/constants.dart';
import 'package:iot_starbhak_client/get_area_model.dart';
import 'package:iot_starbhak_client/get_usage_contract.dart';
import 'package:iot_starbhak_client/get_usage_model.dart';
import 'package:iot_starbhak_client/get_usage_presenter.dart';
import 'package:iot_starbhak_client/history_screen.dart';
import 'package:iot_starbhak_client/info.dart';
import 'package:iot_starbhak_client/manage_member.dart';
import 'package:iot_starbhak_client/manage_room.dart';
import 'package:iot_starbhak_client/member_contract.dart';
import 'package:iot_starbhak_client/member_model.dart';
import 'package:iot_starbhak_client/member_presenter.dart';
import 'package:iot_starbhak_client/switch_device_contract.dart';
import 'package:iot_starbhak_client/switch_device_presenter.dart';
import 'package:page_transition/page_transition.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home>
    with TickerProviderStateMixin
    implements
        MemberContractView,
        GetUsageContractView,
        SwitchDeviceContractView, GetAreaContractView {
  Constants constants = Constants();
  AnimationController logoAnimationController;
  Animation logoAnimation;
  ScrollController scrollController;
  MemberPresenter memberPresenter;
  GetUsagePresenter getUsagePresenter;
  SwitchDevicePresenter switchDevicePresenter;
  AreaPresenter areaPresenter;
  List<GetUsageResult> _listMainLamp = <GetUsageResult>[];
  List<String> _listAreaName = <String>[];
  bool isLoadingDoor = false;
  bool isLocked;
  String _area = "Name";
  String _membershipPrice = "99999999";
  String _countDevice = "999";
  String _doorArea;
  String _doorId;

  HomeState() {
    memberPresenter = MemberPresenter(this);
    getUsagePresenter = GetUsagePresenter(this);
    switchDevicePresenter = SwitchDevicePresenter(this);
    areaPresenter = AreaPresenter(getAreaContractView: this);
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
    isLoadingDoor = true;
    scrollController = ScrollController();
    memberPresenter.loadMemberData();
    getUsagePresenter.loadGetUsageData();
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
                                isLoadingDoor
                                    ? "Loading"
                                    : isLocked
                                        ? "The front door is locked!"
                                        : "The front door is unlocked!",
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
                                isLoadingDoor
                                    ? "Loading"
                                    : isLocked
                                        ? "Would you like to unlock it?"
                                        : "Would you like to lock it?",
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
                            onPressed: () {
                              setState(() {
                                isLoadingDoor = true;
                              });
                              switchDevicePresenter.loadSwitchDeviceData(_doorId, _doorArea);
                            },
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            fillColor: Colors.blue,
                            child: Icon(
                              isLoadingDoor
                                  ? Icons.refresh
                                  : isLocked
                                      ? Icons.lock_open
                                      : Icons.lock,
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
                            color: _listMainLamp.length > 0 ? _listMainLamp[index].status == "0" ? Colors.grey : Colors.amber : Colors.grey,
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
                                _listMainLamp.length > 0 ? _listMainLamp[index].device.name : "Main Light Bulb",
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
                                    _listMainLamp.length > 0 ? _listMainLamp[index].status == "0" ? "OFF" : "ON" : "Empty",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: _listMainLamp.length > 0 ? _listMainLamp[index].status == "0" ? Colors.grey : Colors.amber : Colors.grey,
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
                                    _listMainLamp.length > 0 ? _listMainLamp[index].status == "1"
                                        ? "Turn Off"
                                        : "Turn On" : "Loading",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_listMainLamp.length > 0){
                                      switchDevicePresenter.loadSwitchDeviceData(_listMainLamp[index].device_id.toString(), _listMainLamp[index].area_id.toString());
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                _listAreaName.length > 0 ? _listAreaName[index] : "Loading",
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
                  itemCount: _listMainLamp.length > 0 ? _listMainLamp.length : 2,
                  gridDelegate:
                      SliverStaggeredGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                    staggeredTileCount: _listMainLamp.length > 0 ? _listMainLamp.length : 2,
                    crossAxisSpacing: 10,
                  ),
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
                                _countDevice,
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
                            constants.getFormattedMoney(_membershipPrice),
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
                          TextButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.zero),
                            ),
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
        _membershipPrice = memberModel.service.price.toString();
      });
    } else {
      print(memberModel.message);
    }
  }

  @override
  setOnErrorGetUsageData(error) {
    print(error);
  }

  @override
  setOnSuccessGetUsageData(GetUsageModel getUsageModel) {
    if (getUsageModel.success) {
      setState(() {
        _countDevice = getUsageModel.result.length.toString();
        _listMainLamp = getUsageModel.result.take(2).toList();
      });
      for (int i = 0; i < getUsageModel.result.length; i++) {
        if (getUsageModel.result[i].device.name == "door") {
          setState(() {
            if (getUsageModel.result[i].status == "0") {
              isLocked = true;
            } else {
              isLocked = false;
            }
            _doorArea = getUsageModel.result[i].area_id.toString();
            _doorId = getUsageModel.result[i].device_id.toString();
            isLoadingDoor = false;
          });
        }
      }
      areaPresenter.loadAreaData();
    }
  }

  @override
  setOnErrorSwitchDeviceData(error) {
    print(error);
  }

  @override
  setOnSuccessSwitchDeviceData(int statusCode) {
    if (statusCode == 200){
      _listMainLamp.clear();
      getUsagePresenter.loadGetUsageData();
    }
  }

  @override
  setOnErrorGetAreaData(error) {
    print(error);
  }

  @override
  setOnSuccessGetAreaData(GetAreaModel getAreaModel) {
    if (getAreaModel.success){
      _listAreaName.clear();
      for (int i = 0; i < _listMainLamp.length; i++){
        for (int j = 0; j < getAreaModel.result.length; j++){
          if (_listMainLamp[i].area_id == getAreaModel.result[j].id){
            _listAreaName.add(getAreaModel.result[j].name);
          }
        }
      }
    }
    print(_listAreaName);
  }
}
