class SingleProuctResponse {
  String? status;
  Data? data;

  SingleProuctResponse({this.status, this.data});

  SingleProuctResponse.fromJson(Map<String, dynamic> json) {
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
  Product? product;

  Data({this.product});

  Data.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  String? sId;
  String? name;
  String? model;
  String? category;
  List<Sections>? sections;
  String? createdAt;

  Product(
      {this.sId,
      this.name,
      this.model,
      this.category,
      this.sections,
      this.createdAt});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    model = json['model'];
    category = json['category'];
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(new Sections.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['model'] = this.model;
    data['category'] = this.category;
    if (this.sections != null) {
      data['sections'] = this.sections!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Sections {
  String? sId;
  String? name;
  String? product;
  String? creator;
  String? comment;
  String? content;
  String? lastUpdated;

  Sections(
      {this.sId,
      this.name,
      this.product,
      this.creator,
      this.comment,
      this.content,
      this.lastUpdated});

  Sections.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    product = json['product'];
    creator = json['creator'];
    comment = json['comment'];
    content = json['content'];
    lastUpdated = json['lastUpdated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['product'] = this.product;
    data['creator'] = this.creator;
    data['comment'] = this.comment;
    data['content'] = this.content;
    data['lastUpdated'] = this.lastUpdated;
    return data;
  }
}