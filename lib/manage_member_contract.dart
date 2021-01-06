import 'package:iot_starbhak_client/member_model.dart';

class ManageMemberContractView {
  setOnSuccessMemberData(MemberModel memberModel) {}
  setOnSuccessAddMember() {}
  setOnErrorMemberData(error) {}
}

class ManageMemberContractPresenter {
  addMemberData(String email, String password, String username) {}
  loadAddMemberData(String email, String password, String username) {}
  getMemberData() {}
  loadMemberData() {}
  deleteMemberData(String clientId) {}
  loadDeleteMemberData(String clientId) {}
}
