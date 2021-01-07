import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iot_starbhak_client/switch_device_contract.dart';
import 'package:iot_starbhak_client/switch_device_presenter.dart';
import 'package:shimmer/shimmer.dart';

import 'constants.dart';
import 'device_contract.dart';
import 'device_model.dart';
import 'device_presenter.dart';

class AddDeviceModalBottomSheet extends StatefulWidget{

  final String areaId;

  const AddDeviceModalBottomSheet({Key key, this.areaId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddDeviceModalBottomSheetState();
  }

}

class AddDeviceModalBottomSheetState extends State<AddDeviceModalBottomSheet> implements DeviceContractView, SwitchDeviceContractView {

  ScrollController scrollController = ScrollController();
  bool isLoadingDevice = false;
  List<DeviceResult> listResultDevice = <DeviceResult>[];
  DevicePresenter devicePresenter;
  SwitchDevicePresenter switchDevicePresenter;
  Constants constants = Constants();
  String dropdownFilterValue;
  String selectedItemDropdown;

  AddDeviceModalBottomSheetState(){
    devicePresenter = DevicePresenter(this);
    switchDevicePresenter = SwitchDevicePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    isLoadingDevice = true;
    devicePresenter.loadDeviceData();
  }

  @override
  Widget build(BuildContext context) {
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
                  bottom:
                  MediaQuery.of(context).viewInsets.top,
                ),
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
              SizedBox(
                height: 8,
              ),
              isLoadingDevice
                  ? Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                enabled: isLoadingDevice,
                child: DropdownSearch<String>(
                  mode: Mode.MENU,
                  selectedItem: "Choose One",
                  items: [
                    'Empty',
                  ],
                ),
              )
                  : DropdownSearch<String>(
                mode: Mode.MENU,
                showSearchBox: true,
                onChanged: (value) {
                  for (int i = 0;
                  i < listResultDevice.length;
                  i++) {
                    if (value.contains(
                        listResultDevice[i].name)) {
                      setState(() {
                        dropdownFilterValue =
                            listResultDevice[i]
                                .id
                                .toString()
                                .trim();
                        selectedItemDropdown =
                            listResultDevice[i].name;
                      });
                    }
                  }
                  print(dropdownFilterValue);
                },
                selectedItem:
                selectedItemDropdown != null
                    ? selectedItemDropdown
                    : "Choose One",
                validator: (String item) {
                  if (item == null)
                    return "Required field";
                  else
                    return null;
                },
                items: constants
                    .getListDevice(listResultDevice),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Select Device's Icon",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              StaggeredGridView.builder(
                controller: scrollController,
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                        style: BorderStyle.solid,
                      ),
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          color: Colors.blue,
                          size: 40,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Bathroom",
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: 6,
                gridDelegate:
                SliverStaggeredGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  staggeredTileBuilder: (index) =>
                      StaggeredTile.fit(1),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  staggeredTileCount: 6,
                ),
                shrinkWrap: true,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding:
                    MaterialStateProperty.resolveWith(
                            (states) => EdgeInsets.all(8)),
                    shape: MaterialStateProperty
                        .resolveWith((states) =>
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(5),
                        )),
                    backgroundColor:
                    MaterialStateProperty.resolveWith(
                            (states) => Colors.blue),
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
                    switchDevicePresenter
                        .loadSwitchDeviceData(
                        dropdownFilterValue,
                        widget.areaId);
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context)
                      .viewInsets
                      .bottom,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  setOnErrorDeviceData(error) {
    print(error);
  }

  @override
  setOnSuccessDeviceData(DeviceModel deviceModel) {
    if (deviceModel.success) {
      setState(() {
        listResultDevice = deviceModel.result;
        isLoadingDevice = false;
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
  }

}