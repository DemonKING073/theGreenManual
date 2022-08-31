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
  Addresses? addresses;
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
  String? gender;

  User(
      {this.addresses,
      this.sId,
      this.uuid,
      this.role,
      this.email,
      this.provider,
      this.createdAt,
      this.iV,
      this.designation,
      this.language,
      this.name,
      this.gender});

  User.fromJson(Map<String, dynamic> json) {
    addresses = json['addresses'] != null
        ? new Addresses.fromJson(json['addresses'])
        : null;
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
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.toJson();
    }
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
    data['gender'] = this.gender;
    return data;
  }
}

class Addresses {
  String? address1;
  String? address2;

  Addresses({this.address1, this.address2});

  Addresses.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'];
    address2 = json['address2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    return data;
  }
}