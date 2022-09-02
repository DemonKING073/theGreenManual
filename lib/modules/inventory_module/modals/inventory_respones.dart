class InventoryResponse {
  String? status;
  int? results;
  Data? data;

  InventoryResponse({this.status, this.results, this.data});

  InventoryResponse.fromJson(Map<String, dynamic> json) {
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
  List<InventoryItem>? projects;

  Data({this.projects});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['projects'] != null) {
      projects = <InventoryItem>[];
      json['projects'].forEach((v) {
        projects!.add(new InventoryItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.projects != null) {
      data['projects'] = this.projects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InventoryItem {
  String? sId;
  String? name;
  Product? product;
  String? user;
  String? createdAt;
  int? iV;

  InventoryItem(
      {this.sId, this.name, this.product, this.user, this.createdAt, this.iV});

  InventoryItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    user = json['user'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['user'] = this.user;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Product {
  String? sId;
  String? name;
  String? model;
  bool? active;
  bool? private;

  Product({this.sId, this.name, this.model, this.active, this.private});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    model = json['model'];
    active = json['active'];
    private = json['private'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['model'] = this.model;
    data['active'] = this.active;
    data['private'] = this.private;
    return data;
  }
}
