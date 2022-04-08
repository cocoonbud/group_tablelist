enum ShowcaseContentType {
  flutterUI,
  flutterAnimation,
  flutterMultithreading,
}

class ShowcaseEntity {
  String title;
  List<ShowcaseItemEntity> item;

  ShowcaseEntity({
    required this.title,
    required this.item,
  });

  factory ShowcaseEntity.fromJson(Map<String, dynamic> json) => ShowcaseEntity(
        title: json["title"],
        item: json["item"],
      );

  Map<String, dynamic> toJson() => {
        "name": title,
        "item": item,
      };
}

class ShowcaseItemEntity {
  String name;
  ShowcaseContentType contentType;

  ShowcaseItemEntity({
    required this.name,
    required this.contentType,
  });

  factory ShowcaseItemEntity.fromJson(Map<String, dynamic> json) =>
      ShowcaseItemEntity(
        name: json["name"],
        contentType: json["contentType"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "contentType": contentType,
      };
}
