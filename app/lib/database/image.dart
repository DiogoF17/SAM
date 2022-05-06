import "media.dart";

class Image extends Media {
  Image(String id, String name, String path)
      : super(id: id, name: name, path: path);

  @override
  static Image fromJSON(String id, Map<String, dynamic> json) {
    return Image(id, json["name"], json["path"]);
  }

  @override
  bool isImage() {
    return true;
  }
}
