import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iot_starbhak_client/area_contract.dart';
import 'package:iot_starbhak_client/area_presenter.dart';
import 'package:iot_starbhak_client/constants.dart';
import 'package:iot_starbhak_client/detail_room.dart';
import 'package:iot_starbhak_client/get_area_model.dart';
import 'package:iot_starbhak_client/submit_area_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ManageRoom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ManageRoomState();
  }
}

class ManageRoomState extends State<ManageRoom>
    implements GetAreaContractView, SubmitAreaContractView {
  final formKey = GlobalKey<FormState>();
  List<GetAreaResult> listArea = <GetAreaResult>[];
  TextEditingController roomNameController = TextEditingController();
  Constants constants = Constants();
  AreaPresenter areaPresenter;
  bool loading = false;

  ManageRoomState() {
    areaPresenter =
        AreaPresenter(getAreaContractView: this, submitAreaContractView: this);
  }

  @override
  void initState() {
    super.initState();
    loading = true;
    areaPresenter.loadAreaData();
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
                        key: formKey,
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
                                SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  autovalidateMode: AutovalidateMode.always,
                                  controller: roomNameController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Room's name cannot be empty";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Room's name",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Select Room's Icon",
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
                                          vertical: 10, horizontal: 20),
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
                                            Icons.room_preferences_outlined,
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
                                                color: Colors.blue),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: 6,
                                  gridDelegate:
                                      SliverStaggeredGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 3,
                                    staggeredTileCount: 6,
                                    staggeredTileBuilder: (index) =>
                                        StaggeredTile.fit(1),
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
                                      "Save",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (formKey.currentState.validate()) {
                                        await constants
                                            .progressDialog(context)
                                            .show();
                                        areaPresenter.submitLoadAreaData(
                                            name: roomNameController.text
                                                .trim()
                                                .toString());
                                      } else {}
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
                          ),
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
      body: loading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            )
          : listArea.length > 0
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: StaggeredGridView.builder(
                    itemBuilder: (context, index) {
                      return TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.resolveWith(
                              (states) => EdgeInsets.zero),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: DetailRoom(
                                idArea: listArea[index].id.toString(),
                                nameArea: listArea[index].name,
                              ),
                              type: PageTransitionType.fade,
                            ),
                          );
                        },
                        child: Container(
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
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.room_preferences_outlined,
                                color: Colors.white,
                                size: 70,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                listArea[index].name,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: listArea.length,
                    gridDelegate:
                        SliverStaggeredGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      staggeredTileCount: listArea.length,
                      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                    ),
                    shrinkWrap: true,
                  ),
                )
              : Center(
                  child: Text(
                    "There's No Room",
                  ),
                ),
    );
  }

  @override
  setOnErrorGetAreaData(error) {
    print(error);
  }

  @override
  setOnErrorSubmitAreaData(error) async {
    print(error);
    await constants.progressDialog(context).hide();
    Alert(
      context: context,
      title: "Failed",
      desc: "Failed to Add New Room",
      type: AlertType.warning,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
      style: AlertStyle(
        animationType: AnimationType.grow,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        descStyle: TextStyle(fontWeight: FontWeight.bold),
        descTextAlign: TextAlign.center,
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle: TextStyle(
          color: Colors.red,
        ),
        alertAlignment: Alignment.center,
      ),
    ).show();
  }

  @override
  setOnSuccessGetAreaData(GetAreaModel getAreaModel) {
    if (getAreaModel.success) {
      setState(() {
        listArea = getAreaModel.result;
        loading = false;
      });
    }
  }

  @override
  setOnSuccessSubmitAreaData(SubmitAreaModel submitAreaModel) async {
    if (submitAreaModel.success) {
      await constants.progressDialog(context).hide();
      Navigator.pop(context);
      setState(() {
        loading = true;
      });
      areaPresenter.loadAreaData();
    } else {
      await constants.progressDialog(context).hide();
      Alert(
        context: context,
        title: "Failed",
        desc: "Failed to Add New Room",
        type: AlertType.warning,
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
        style: AlertStyle(
          animationType: AnimationType.grow,
          isCloseButton: false,
          isOverlayTapDismiss: false,
          descStyle: TextStyle(fontWeight: FontWeight.bold),
          descTextAlign: TextAlign.center,
          animationDuration: Duration(milliseconds: 400),
          alertBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Colors.grey,
            ),
          ),
          titleStyle: TextStyle(
            color: Colors.red,
          ),
          alertAlignment: Alignment.center,
        ),
      ).show();
    }
  }
}
