class ResumeData {
  List<SavedData>? savedData;

  ResumeData({this.savedData});

  ResumeData.fromJson(Map<String, dynamic> json) {
    if (json['savedData'] != null) {
      savedData = <SavedData>[];
      json['savedData'].forEach((v) {
        savedData!.add(SavedData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.savedData != null) {
      data['savedData'] = this.savedData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SavedData {
  String? id;
  String? sectionId;
  double? position;

  SavedData({this.id, this.sectionId, this.position});

  SavedData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectionId = json['section_id'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['section_id'] = this.sectionId;
    data['position'] = this.position;
    return data;
  }
}
