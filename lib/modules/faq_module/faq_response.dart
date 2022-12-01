class FAQResponse {
  String? status;
  num? result;
  Data? data;

  FAQResponse({this.status, this.result, this.data});

  FAQResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = json['result'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['result'] = this.result;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Faqs>? faqs;

  Data({this.faqs});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['faqs'] != null) {
      faqs = <Faqs>[];
      json['faqs'].forEach((v) {
        faqs!.add(new Faqs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.faqs != null) {
      data['faqs'] = this.faqs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Faqs {
  String? sId;
  String? question;
  String? answer;
  bool? active;
  String? createdAt;

  Faqs({this.sId, this.question, this.answer, this.active, this.createdAt});

  Faqs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    question = json['question'];
    answer = json['answer'];
    active = json['active'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['active'] = this.active;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
