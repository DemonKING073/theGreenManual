class Profile {
  String? status;
  Data? data;

  Profile({this.status, this.data});

  Profile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? uuid;
  String? role;
  String? email;
  String? provider;
  String? createdAt;
  int? iV;
  String? designation;
  String? language;
  String? name;

  User(
      {this.sId,
      this.uuid,
      this.role,
      this.email,
      this.provider,
      this.createdAt,
      this.iV,
      this.designation,
      this.language,
      this.name});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    uuid = json['uuid'];
    role = json['role'];
    email = json['email'];
    provider = json['provider'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    designation = json['designation'];
    language = json['language'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['uuid'] = this.uuid;
    data['role'] = this.role;
    data['email'] = this.email;
    data['provider'] = this.provider;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['designation'] = this.designation;
    data['language'] = this.language;
    data['name'] = this.name;
    return data;
  }
}