class Category {
  String id;
  String name;
  MediaType mediaType;

  Category(this.id, this.name, this.mediaType);

  @override
  static Category fromJSON(String id, Map<String, dynamic> json) {
    return Category(id, json["name"],
        json["mediaType"] == "imagens" ? MediaType.image : MediaType.video);
  }
}

enum MediaType { video, image }
