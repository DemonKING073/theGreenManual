class ClientInventoryResponse {
  String? status;
  int? results;
  Data? data;

  ClientInventoryResponse({this.status, this.results, this.data});

  ClientInventoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['results'] = this.results;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Products>? products;

  Data({this.products});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? sId;
  String? subscriptionId;
  String? name;
  String? model;
  Company? company;
  String? category;
  String? subcategory;
  String? description;
  String? qrcode;
  List<Sections>? sections;
  Company? creator;
  // List<Assignees>? assignees;
  bool? active;
  bool? private;
  bool? blocked;
  String? createdAt;
  int? iV;

  Products(
      {this.sId,
      this.subscriptionId,
      this.name,
      this.model,
      this.company,
      this.category,
      this.subcategory,
      this.description,
      this.qrcode,
      this.sections,
      this.creator,
      // this.assignees,
      this.active,
      this.private,
      this.blocked,
      this.createdAt,
      this.iV});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    subscriptionId = json['subscriptionId'];
    name = json['name'];
    model = json['model'];
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
    category = json['category'];
    subcategory = json['subcategory'];
    description = json['description'];
    qrcode = json['qrcode'];
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(new Sections.fromJson(v));
      });
    }
    creator =
        json['creator'] != null ? new Company.fromJson(json['creator']) : null;
    // if (json['assignees'] != null) {
    //   assignees = <Assignees>[];
    //   json['assignees'].forEach((v) {
    //     assignees!.add(new Assignees.fromJson(v));
    //   });
    // }
    active = json['active'];
    private = json['private'];
    blocked = json['blocked'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['subscriptionId'] = this.subscriptionId;
    data['name'] = this.name;
    data['model'] = this.model;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    data['category'] = this.category;
    data['subcategory'] = this.subcategory;
    data['description'] = this.description;
    data['qrcode'] = this.qrcode;
    if (this.sections != null) {
      data['sections'] = this.sections!.map((v) => v.toJson()).toList();
    }
    if (this.creator != null) {
      data['creator'] = this.creator!.toJson();
    }
    // if (this.assignees != null) {
    //   data['assignees'] = this.assignees!.map((v) => v.toJson()).toList();
    // }
    data['active'] = this.active;
    data['private'] = this.private;
    data['blocked'] = this.blocked;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Company {
  String? sId;
  String? name;

  Company({this.sId, this.name});

  Company.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

class Sections {
  String? sId;
  String? name;
  String? comment;
  String? lastUpdated;

  Sections({this.sId, this.name, this.comment, this.lastUpdated});

  Sections.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    comment = json['comment'];
    lastUpdated = json['lastUpdated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['comment'] = this.comment;
    data['lastUpdated'] = this.lastUpdated;
    return data;
  }
}
