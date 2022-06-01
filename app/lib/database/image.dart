import "media.dart";

class MyImage extends Media {
  String soundId = "";

  MyImage(String id, String name, String path, String soundId_)
      : super(id: id, name: name, path: path) {
    soundId = soundId_;
  }

  @override
  static MyImage fromJSON(String id, Map<String, dynamic> json) {
    return MyImage(id, json["name"], json["path"], json["soundId"]);
  }
}
