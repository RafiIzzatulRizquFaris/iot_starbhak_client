import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iot_starbhak_client/manage_member_contract.dart';
import 'package:iot_starbhak_client/manage_member_presenter.dart';
import 'package:iot_starbhak_client/member_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ManageMember extends StatefulWidget {
  ManageMember({Key key}) : super(key: key);

  @override
  ManageMemberState createState() => ManageMemberState();
}

class ManageMemberState extends State<ManageMember>
    implements ManageMemberContractView {
  bool loading = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController memberName = TextEditingController();
  TextEditingController memberPassword = TextEditingController();
  TextEditingController memberEmail = TextEditingController();
  MemberModel memberModel;
  ManageMemberPresenter manageMemberPresenter;

  ManageMemberState() {
    manageMemberPresenter = ManageMemberPresenter(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = true;
    manageMemberPresenter.loadMemberData();
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
              "Manage Member",
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
                                  "Add New Member",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Enter Member Email",
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
                                  controller: memberEmail,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Email Cannot Be empty";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Enter Member Username",
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
                                  controller: memberName,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Username Cannot Be empty";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Username",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Enter Member password",
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
                                  controller: memberPassword,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "password Cannot Be empty";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "password",
                                    border: OutlineInputBorder(),
                                  ),
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
                                    onPressed: () {
                                      print(memberEmail.value.text);
                                      print(memberName.value.text);
                                      print(memberPassword.value.text);
                                      setState(() {
                                        loading = true;
                                        manageMemberPresenter.loadAddMemberData(
                                            memberEmail.value.text,
                                            memberPassword.value.text,
                                            memberName.value.text);
                                      });
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
          : memberModel.result.length > 0
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: StaggeredGridView.builder(
                    itemBuilder: (context, index) {
                      return Material(
                        child: InkWell(
                          onLongPress: () {
                            Alert(
                              context: context,
                              title: "Yakin Menghapus",
                              desc: "Yakin nggaak Nih",
                              type: AlertType.warning,
                              buttons: [
                                DialogButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "no",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                                DialogButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      print("delete");
                                      loading = true;
                                      manageMemberPresenter
                                          .loadDeleteMemberData(memberModel
                                              .result[index].id
                                              .toString());
                                    });
                                  },
                                  child: Text(
                                    "yes",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ],
                              style: AlertStyle(
                                animationType: AnimationType.grow,
                                isCloseButton: false,
                                isOverlayTapDismiss: false,
                                descStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                descTextAlign: TextAlign.center,
                                animationDuration: Duration(milliseconds: 400),
                                alertBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                titleStyle: TextStyle(
                                  color: Colors.blue,
                                ),
                                alertAlignment: Alignment.center,
                              ),
                            ).show();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue,
                                style: BorderStyle.solid,
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                  size: 70,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  memberModel.result[index].username,
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.blue),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: memberModel.result.length,
                    gridDelegate:
                        SliverStaggeredGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      staggeredTileCount: memberModel.result.length,
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
  setOnErrorMemberData(error) {
    // TODO: implement setOnErrorMemberData
    print("error : ${error.toString()}");
  }

  @override
  setOnSuccessMemberData(MemberModel memberModel) {
    setState(() {
      this.memberModel = memberModel;
      loading = false;
    });
  }

  @override
  setOnSuccessAddMember() {
    setState(() {
      loading = true;
      manageMemberPresenter.loadMemberData();
    });
  }
}
