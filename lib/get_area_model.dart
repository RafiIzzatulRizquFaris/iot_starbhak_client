class GetAreaModel {
    String message;
    List<GetAreaResult> result;
    bool success;

    GetAreaModel({this.message, this.result, this.success});

    factory GetAreaModel.fromJson(Map<String, dynamic> json) {
        return GetAreaModel(
            message: json['message'], 
            result: json['result'] != null ? (json['result'] as List).map((i) => GetAreaResult.fromJson(i)).toList() : null, 
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

class GetAreaResult {
    int client_id;
    int id;
    String name;
    String status;

    GetAreaResult({this.client_id, this.id, this.name, this.status});

    factory GetAreaResult.fromJson(Map<String, dynamic> json) {
        return GetAreaResult(
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