import "media.dart";

class MyImage extends Media {
  String soundId = "";
  String pathLearnMore = "";

  MyImage(String id, String name, String path, String pathLearnMore_,
      String soundId_)
      : super(id: id, name: name, path: path) {
    soundId = soundId_;
    pathLearnMore = pathLearnMore_;
   }

  @override
  static MyImage fromJSON(String id, Map<String, dynamic> json) {
    return MyImage(id, json["name"], json["path"], json["pathLearnMore"], json["soundId"]);
  }
}
