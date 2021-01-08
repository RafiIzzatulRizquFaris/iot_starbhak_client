class HistoryModel {
    String message;
    List<HistoryResult> result;
    bool success;

    HistoryModel({this.message, this.result, this.success});

    factory HistoryModel.fromJson(Map<String, dynamic> json) {
        return HistoryModel(
            message: json['message'], 
            result: json['result'] != null ? (json['result'] as List).map((i) => HistoryResult.fromJson(i)).toList() : null,
            success: json['success'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['success'] = this.success;
        if (this.result != null) {
            data['result'] = this.result.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class HistoryResult {
    int area_id;
    int client_id;
    String created_at;
    int device_id;
    int id;
    int member_id;
    String status;
    String updated_at;

    HistoryResult({this.area_id, this.client_id, this.created_at, this.device_id, this.id, this.member_id, this.status, this.updated_at});

    factory HistoryResult.fromJson(Map<String, dynamic> json) {
        return HistoryResult(
            area_id: json['area_id'], 
            client_id: json['client_id'], 
            created_at: json['created_at'],
            device_id: json['device_id'], 
            id: json['id'], 
            member_id: json['member_id'], 
            status: json['status'], 
            updated_at: json['updated_at'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['area_id'] = this.area_id;
        data['client_id'] = this.client_id;
        data['created_at'] = this.created_at;
        data['device_id'] = this.device_id;
        data['id'] = this.id;
        data['member_id'] = this.member_id;
        data['status'] = this.status;
        data['updated_at'] = this.updated_at;
        return data;
    }
}