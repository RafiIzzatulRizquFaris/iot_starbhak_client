import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iot_starbhak_client/area_contract.dart';
import 'package:iot_starbhak_client/area_presenter.dart';
import 'package:iot_starbhak_client/device_contract.dart';
import 'package:iot_starbhak_client/device_model.dart';
import 'package:iot_starbhak_client/device_presenter.dart';
import 'package:iot_starbhak_client/get_area_model.dart';
import 'package:iot_starbhak_client/history_contract.dart';
import 'package:iot_starbhak_client/history_model.dart';
import 'package:iot_starbhak_client/history_presenter.dart';
import 'package:iot_starbhak_client/member_contract.dart';
import 'package:iot_starbhak_client/member_model.dart';
import 'package:iot_starbhak_client/member_presenter.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HistoryScreenState();
  }
}

class HistoryScreenState extends State<HistoryScreen>
    implements
        HistoryContractView,
        DeviceContractView,
        GetAreaContractView,
        MemberContractView {
  HistoryPresenter historyPresenter;
  DevicePresenter devicePresenter;
  AreaPresenter areaPresenter;
  MemberPresenter memberPresenter;
  List<HistoryResult> listHistory = <HistoryResult>[];
  List<String> listNameDevice = <String>[];
  List<String> listNameArea = <String>[];
  List<String> listNameMember = <String>[];
  bool isLoading = false;

  HistoryScreenState() {
    historyPresenter = HistoryPresenter(this);
    devicePresenter = DevicePresenter(this);
    areaPresenter = AreaPresenter(getAreaContractView: this);
    memberPresenter = MemberPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    historyPresenter.loadHistoryData();
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
            title: Text(
              "Report Status Device",
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
                  Icons.refresh,
                  color: Colors.blue,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  historyPresenter.loadHistoryData();
                },
              ),
            ],
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            )
          : listHistory.length > 0
              ? ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(
                        listHistory[index].device_id.toString() == "2"
                            ? Icons.sensor_door
                            : Icons.lightbulb,
                        color: listHistory[index].status == "0"
                            ? Colors.grey
                            : Colors.amber,
                        size: 35,
                      ),
                      title: Text(
                        '${listNameDevice[index]}  (${listNameArea[index]})',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Container(
                        padding: EdgeInsets.only(
                          top: 8,
                        ),
                        child: Text(
                          getFormattedDate(listHistory[index].updated_at),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      trailing: Text(
                        listNameMember[index],
                        style: TextStyle(
                          fontSize: 18,
                          // color: listHistory[index].status == "0"
                          //     ? Colors.grey
                          //     : Colors.amber,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                  itemCount: listHistory.length,
                )
              : Center(
                  child: Text(
                    "History List is Empty",
                  ),
                ),
    );
  }

  @override
  setOnErrorHistoryData(error) {
    print(error);
  }

  @override
  setOnSuccessHistoryData(HistoryModel historyModel) {
    if (historyModel.success) {
      setState(() {
        listHistory = historyModel.result.reversed.toList();
      });
      devicePresenter.loadDeviceData();
    }
  }

  @override
  setOnErrorDeviceData(error) {
    print(error);
  }

  @override
  setOnSuccessDeviceData(DeviceModel deviceModel) {
    if (deviceModel.success) {
      for (int i = 0; i < listHistory.length; i++) {
        for (int j = 0; j < deviceModel.result.length; j++) {
          if (listHistory[i].device_id == deviceModel.result[j].id) {
            listNameDevice.add(deviceModel.result[j].name);
          }
        }
      }
      areaPresenter.loadAreaData();
    }
  }

  String getFormattedDate(String date) {
    var newStr = date.substring(0, 10) + ' ' + date.substring(11, 23);
    DateTime dt = DateTime.parse(newStr);
    return DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt);
  }

  @override
  setOnErrorGetAreaData(error) {
    print(error);
  }

  @override
  setOnSuccessGetAreaData(GetAreaModel getAreaModel) {
    if (getAreaModel.success) {
      for (int i = 0; i < listHistory.length; i++) {
        for (int j = 0; j < getAreaModel.result.length; j++) {
          if (listHistory[i].area_id == getAreaModel.result[j].id) {
            listNameArea.add(getAreaModel.result[j].name);
          }
        }
      }
      memberPresenter.loadMemberData();
    }
  }

  @override
  setOnErrorMemberData(error) {
    print(error);
  }

  @override
  setOnSuccessMemberData(MemberModel memberModel) {
    if (memberModel.success) {
      for (int i = 0; i < listHistory.length; i++) {
        for (int j = 0; j < memberModel.result.length; j++) {
          if (listHistory[i].member_id == memberModel.result[j].id) {
            listNameMember.add(memberModel.result[j].username);
          }
        }
      }
      setState(() {
        isLoading = false;
      });
    }
  }
}
