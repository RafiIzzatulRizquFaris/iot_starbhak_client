import 'package:iot_starbhak_client/submit_area_model.dart';

import 'get_area_model.dart';

class SubmitAreaContractView{
  setOnSuccessSubmitAreaData(SubmitAreaModel submitAreaModel) {}
  setOnErrorSubmitAreaData(error) {}
}

class GetAreaContractView{
  setOnSuccessGetAreaData(GetAreaModel getAreaModel) {}
  setOnErrorGetAreaData(error) {}
}

class SubmitAreaContractPresenter{
  submitAreaData({String name}) {}
  submitLoadAreaData({String name}) {}
}

class GetAreaContractPresenter{
  getAreaData() {}
  loadAreaData() {}
}

