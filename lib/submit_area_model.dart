class SubmitAreaModel {
    String message;
    SubmitAreaResult result;
    bool success;

    SubmitAreaModel({this.message, this.result, this.success});

    factory SubmitAreaModel.fromJson(Map<String, dynamic> json) {
        return SubmitAreaModel(
            message: json['message'], 
            result: json['result'] != null ? SubmitAreaResult.fromJson(json['result']) : null, 
            success: json['success'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['success'] = this.success;
        if (this.result != null) {
            data['result'] = this.result.toJson();
        }
        return data;
    }
}

class SubmitAreaResult {
    int client_id;
    int id;
    String name;
    String status;

    SubmitAreaResult({this.client_id, this.id, this.name, this.status});

    factory SubmitAreaResult.fromJson(Map<String, dynamic> json) {
        return SubmitAreaResult(
            client_id: json['client_id'], 
            id: json['id'], 
            name: json['name'], 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['client_id'] = this.client_id;
        data['id'] = this.id;
        data['name'] = this.name;
        data['status'] = this.status;
        return data;
    }
}