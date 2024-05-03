class FeatureModel {
  String? title;
  String? bgUrl;
  String? url;

  FeatureModel({this.title, this.bgUrl, this.url});

  FeatureModel.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? "";
    bgUrl = json['bgUrl'] ?? "";
    url = json['url'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['bgUrl'] = this.bgUrl;
    data['url'] = this.url;
    return data;
  }
}
