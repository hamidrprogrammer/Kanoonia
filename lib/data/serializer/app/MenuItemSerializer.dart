import 'dart:convert';

List<MenuItemSerializer> menuItemsSerializerFromJson(String str) =>
    List<MenuItemSerializer>.from(
        json.decode(str).map((x) => MenuItemSerializer.fromJson(x)));

String menuItemsSerializerToJson(List<MenuItemSerializer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuItemSerializer {
  MenuItemSerializer({
    this.kind,
    this.title,
    this.isActive,
  });

  MenuItemSerializer.fromJson(dynamic json) {
    kind = json['kind'];
    title = json['title'];
    isActive = json['isActive'];
  }

  String? kind;
  String? title;
  bool? isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['kind'] = kind;
    map['title'] = title;
    map['isActive'] = isActive;
    return map;
  }
}
