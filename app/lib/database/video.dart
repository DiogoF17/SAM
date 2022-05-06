import "media.dart";

class Video extends Media {
  Video(String id, String name, String path)
      : super(id: id, name: name, path: path);

  @override
  static Video fromJSON(String id, Map<String, dynamic> json) {
    return Video(id, json["name"], json["path"]);
  }

  @override
  bool isVideo() {
    return true;
  }
}
