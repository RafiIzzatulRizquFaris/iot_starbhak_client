import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:iot_starbhak_client/device_model.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Constants {
  static const kBackgroundColor = Color(0xFFF1EFF1);
  static const kPrimaryColor = Color(0xFF035AA6);
  static const kSecondaryColor = Color(0xFFFFA41B);
  static const kTextColor = Color(0xFF000839);
  static const kTextLightColor = Color(0xFF747474);
  static const kBlueColor = Color(0xFF40BAD5);

  static const String BASE_URL = "http://iot.starbhak.store/api/";
  static const String TOKEN = "TOKEN";
  static const String NAME = "NAME";

  static const kDefaultPadding = 20.0;

  static const kDefaultShadow = BoxShadow(
    offset: Offset(0, 15),
    blurRadius: 27,
    color: Colors.black12,
  );

  String getFormattedMoney(String unformattedText) {
    MoneyMaskedTextController moneyMaskedTextController =
    MoneyMaskedTextController(
      thousandSeparator: ",",
      precision: 0,
      decimalSeparator: "",
      initialValue: double.parse(unformattedText),
      leftSymbol: "Rp. ",
    );
    return moneyMaskedTextController.text;
  }

  List<String> getListDevice(List<DeviceResult> deviceResult) {
    List<String> list = <String>[];
    for (int i = 0; i < deviceResult.length; i++) {
      list.add(deviceResult[i].name);
    }
    return list;
  }

  ProgressDialog progressDialog(BuildContext ctx) {
    ProgressDialog loadingDialog = ProgressDialog(
      ctx,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    );
    loadingDialog.style(
      message: "Loading",
      progressWidget: Container(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          backgroundColor: Colors.blue,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      messageTextStyle: TextStyle(
        color: Colors.blue,
      ),
    );
    return loadingDialog;
  }

  successAlert(String title, String subtitle, BuildContext ctx) {
    return Alert(
      context: ctx,
      title: title,
      desc: subtitle,
      type: AlertType.success,
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.pop(ctx);
          },
          child: Text(
            "Ok",
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
          color: Colors.blue,
        ),
        alertAlignment: Alignment.center,
      ),
    ).show();
  }

  errorAlert(String title, String subtitle, BuildContext ctx) {
    return Alert(
      context: ctx,
      title: title,
      desc: subtitle,
      type: AlertType.warning,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(ctx),
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