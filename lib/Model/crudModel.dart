class CrudModel {
  String? sid;
  String? title;
  String? description;
  bool? isCompleted;

  CrudModel({this.title, this.description, this.isCompleted});

  CrudModel.fromJson(Map<String, dynamic> json) {
    sid = json["_id"];
    title = json['title'];
    description = json['description'];
    isCompleted = json['is_completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sid;
    data['title'] = this.title;
    data['description'] = this.description;
    data['is_completed'] = this.isCompleted;
    return data;
  }
}
