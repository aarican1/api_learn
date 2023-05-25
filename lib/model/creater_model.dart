class CreaterModel {
  String? name;
  String? job;

  CreaterModel({this.name, this.job});

  CreaterModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    job = json['job'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['job'] = job;
    return data;
  }
}


class CreaterFeedBackModel {
  String? name;
  String? job;
  String? id;
  String? createdAt;

  CreaterFeedBackModel({this.name, this.job, this.id, this.createdAt});

  CreaterFeedBackModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    job = json['job'];
    id = json['id'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['job'] = job;
    data['id'] = id;
    data['createdAt'] = createdAt;
    return data;
  }
}

class UpdateFeedBackModel {
  String? name;
  String? job;
  String? id;
  String? UpdatedAt;
  

  UpdateFeedBackModel({this.name, this.job, this.id, this.UpdatedAt});

  UpdateFeedBackModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    job = json['job'];
    id = json['id'];
    UpdatedAt = json['updateddAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['job'] = job;
    data['id'] = id;
    data['updatedAt'] = UpdatedAt;
    return data;
  }
}
