class GetUsageModel {
    String message;
    List<GetUsageResult> result;
    bool success;

    GetUsageModel({this.message, this.result, this.success});

    factory GetUsageModel.fromJson(Map<String, dynamic> json) {
        return GetUsageModel(
            message: json['message'], 
            result: json['result'] != null ? (json['result'] as List).map((i) => GetUsageResult.fromJson(i)).toList() : null, 
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

class GetUsageResult {
    Area area;
    int area_id;
    int client_id;
    Device device;
    int device_id;
    int id;
    int member_id;
    String status;

    GetUsageResult({this.area, this.area_id, this.client_id, this.device, this.device_id, this.id, this.member_id, this.status});

    factory GetUsageResult.fromJson(Map<String, dynamic> json) {
        return GetUsageResult(
            area: json['area'] != null ? Area.fromJson(json['area']) : null, 
            area_id: json['area_id'], 
            client_id: json['client_id'], 
            device: json['device'] != null ? Device.fromJson(json['device']) : null, 
            device_id: json['device_id'], 
            id: json['id'], 
            member_id: json['member_id'], 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['area_id'] = this.area_id;
        data['client_id'] = this.client_id;
        data['device_id'] = this.device_id;
        data['id'] = this.id;
        data['member_id'] = this.member_id;
        data['status'] = this.status;
        if (this.area != null) {
            data['area'] = this.area.toJson();
        }
        if (this.device != null) {
            data['device'] = this.device.toJson();
        }
        return data;
    }
}

class Area {
    int client_id;
    int id;
    String name;
    String status;

    Area({this.client_id, this.id, this.name, this.status});

    factory Area.fromJson(Map<String, dynamic> json) {
        return Area(
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

class Device {
    int id;
    String name;
    String type;
    Object value;

    Device({this.id, this.name, this.type, this.value});

    factory Device.fromJson(Map<String, dynamic> json) {
        return Device(
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