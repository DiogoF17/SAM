class Category {
  String id;
  String name;
  bool hasSound;

  Category(this.id, this.name, this.hasSound);

  @override
  static Category fromJSON(String id, Map<String, dynamic> json) {
    return Category(id, json["name"],json["hasSound"]);
  }
}