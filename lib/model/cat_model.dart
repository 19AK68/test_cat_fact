class CatModel {
  String? url;

  CatModel({this.url});

  CatModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['url'] = url;
    return data;
  }
}
