import "media.dart";

class Sound extends Media {
  String _categoryId = "";

  Sound(String id, String name, String path, String categoryId)
      : super(id: id, name: name, path: path) {
    _categoryId = categoryId;
  }

  @override
  static Sound fromJSON(String id, Map<String, dynamic> json) {
    return Sound(id, json["name"], json["path"], json["categoryId"]);
  }
}
