class RegisterTokenModel {
  int? id;
  String? token;

  RegisterTokenModel({this.id, this.token});

  RegisterTokenModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['token'] = this.token;
    return data;
  }
}