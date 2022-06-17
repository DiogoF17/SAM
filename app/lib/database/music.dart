import 'package:app/database/media.dart';

class Music extends Media {
  Music(String id, String name, String path) : super(id: id, name: name, path: path);

  static Music fromJSON(String id, Map<String, dynamic> json) {
    String name = json["name"];
    String path = json["path"];
    return Music(id, name, path);
  }
}
