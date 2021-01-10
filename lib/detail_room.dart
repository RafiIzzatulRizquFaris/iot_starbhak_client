import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iot_starbhak_client/add_device_modal_bottom_sheet.dart';
import 'package:iot_starbhak_client/get_usage_contract.dart';
import 'package:iot_starbhak_client/get_usage_model.dart';
import 'package:iot_starbhak_client/get_usage_presenter.dart';
import 'package:iot_starbhak_client/switch_device_contract.dart';
import 'package:iot_starbhak_client/switch_device_presenter.dart';

class DetailRoom extends StatefulWidget {
  final String idArea;
  final String nameArea;

  DetailRoom({this.idArea, this.nameArea});

  @override
  State<StatefulWidget> createState() {
    return DetailRoomState();
  }
}

class DetailRoomState extends State<DetailRoom>
    implements
        GetUsageContractView,
        SwitchDeviceContractView {
  GetUsagePresenter getUsagePresenter;
  SwitchDevicePresenter switchDevicePresenter;
  bool isLoading = false;
  List<GetUsageResult> listResultUsage = <GetUsageResult>[];

  DetailRoomState() {
    getUsagePresenter = GetUsagePresenter(this);
    switchDevicePresenter = SwitchDevicePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
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
            title: Text(
              "Manage ${widget.nameArea}",
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
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return AddDeviceModalBottomSheet(areaId: widget.idArea,);
                    },
                  ).then((value) {
                    setState(() {
                      isLoading = true;
                    });
                    listResultUsage.clear();
                    getUsagePresenter.loadGetUsageData();
                  });
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
          : listResultUsage.length > 0
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: StaggeredGridView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
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
                              color: listResultUsage[index].status == "1"
                                  ? Colors.amber
                                  : Colors.grey,
                              size: 50,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  listResultUsage[index].device.name,
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
                                      listResultUsage[index].status == "1"
                                          ? "ON"
                                          : "OFF",
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
                                      listResultUsage[index].status == "1"
                                          ? "Turn Off"
                                          : "Turn On",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () {
                                      switchDevicePresenter
                                          .loadSwitchDeviceData(listResultUsage[index].device_id.toString(), widget.idArea);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: listResultUsage.length,
                    gridDelegate:
                        SliverStaggeredGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      staggeredTileCount: listResultUsage.length,
                      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                    ),
                    shrinkWrap: true,
                  ),
                )
              : Center(
                  child: Text(
                    "Device is Empty",
                  ),
                ),
    );
  }

  @override
  setOnErrorGetUsageData(error) {
    print(error);
  }

  @override
  setOnSuccessGetUsageData(GetUsageModel getUsageModel) {
    if (getUsageModel.success) {
      print(getUsageModel);
      if (getUsageModel.result.length > 0) {
        print(getUsageModel.result);
        for (int i = 0; i < getUsageModel.result.length; i++) {
          if (getUsageModel.result[i].area_id.toString() == widget.idArea) {
            listResultUsage.add(getUsageModel.result[i]);
          }
        }
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  setOnErrorSwitchDeviceData(error) {
    print(error);
  }

  @override
  setOnSuccessSwitchDeviceData(int statusCode) {
    print(statusCode);
    setState(() {
      isLoading = true;
    });
    listResultUsage.clear();
    getUsagePresenter.loadGetUsageData();
  }
}
