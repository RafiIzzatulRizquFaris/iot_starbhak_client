class DeviceModel {
    String message;
    List<DeviceResult> result;
    bool success;

    DeviceModel({this.message, this.result, this.success});

    factory DeviceModel.fromJson(Map<String, dynamic> json) {
        return DeviceModel(
            message: json['message'], 
            result: json['result'] != null ? (json['result'] as List).map((i) => DeviceResult.fromJson(i)).toList() : null, 
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

class DeviceResult {
    int id;
    String name;
    String type;
    String value;

    DeviceResult({this.id, this.name, this.type, this.value});

    factory DeviceResult.fromJson(Map<String, dynamic> json) {
        return DeviceResult(
            id: json['id'], 
            name: json['name'], 
            type: json['type'], 
            value: json['value'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['name'] = this.name;
        data['type'] = this.type;
        data['value'] = this.value;
        return data;
    }
}