import 'dart:convert';

List<ArticleItemSerializer> articleItemsSerializerFromJson(String str) =>
    List<ArticleItemSerializer>.from(
        json.decode(str).map((x) => ArticleItemSerializer.fromJson(x)));

String articleItemsSerializerToJson(List<ArticleItemSerializer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class ArticleItemSerializer {
  ArticleItemSerializer({
      this.articleId, 
      this.pictureUrl, 
      this.title, 
      this.subTitle, 
      this.modifyOn, 
      this.tabName, 
      this.categoryName, 
      this.url,});

  ArticleItemSerializer.fromJson(dynamic json) {
    articleId = json['articleId'];
    pictureUrl = json['pictureUrl'];
    title = json['title'];
    subTitle = json['subTitle'];
    modifyOn = json['modifyOn'];
    tabName = json['tabName'];
    categoryName = json['categoryName'];
    url = json['url'];
  }
  num? articleId;
  String? pictureUrl;
  String? title;
  String? subTitle;
  String? modifyOn;
  String? tabName;
  String? categoryName;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['articleId'] = articleId;
    map['pictureUrl'] = pictureUrl;
    map['title'] = title;
    map['subTitle'] = subTitle;
    map['modifyOn'] = modifyOn;
    map['tabName'] = tabName;
    map['categoryName'] = categoryName;
    map['url'] = url;
    return map;
  }

}