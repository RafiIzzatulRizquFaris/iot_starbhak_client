class LoginModel {
    String message;
    Result result;
    bool success;

    LoginModel({this.message, this.result, this.success});

    factory LoginModel.fromJson(Map<String, dynamic> json) {
        return LoginModel(
            message: json['message'], 
            result: json['result'] != null ? Result.fromJson(json['result']) : null, 
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

class Result {
    int client_id;
    String created_at;
    String email;
    int id;
    String member_token;
    String password;
    String role;
    String updated_at;
    String username;

    Result({this.client_id, this.created_at, this.email, this.id, this.member_token, this.password, this.role, this.updated_at, this.username});

    factory Result.fromJson(Map<String, dynamic> json) {
        return Result(
            client_id: json['client_id'], 
            created_at: json['created_at'],
            email: json['email'], 
            id: json['id'], 
            member_token: json['member_token'], 
            password: json['password'], 
            role: json['role'], 
            updated_at: json['updated_at'], 
            username: json['username'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['client_id'] = this.client_id;
        data['email'] = this.email;
        data['id'] = this.id;
        data['member_token'] = this.member_token;
        data['password'] = this.password;
        data['role'] = this.role;
        data['updated_at'] = this.updated_at;
        data['username'] = this.username;
        data['created_at'] = this.created_at;
        return data;
    }
}