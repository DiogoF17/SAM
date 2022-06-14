class Music {
  String name;
  String path;

  Music(this.name, this.path);

  static Music fromJSON(Map<String, dynamic> json) {
    String name = json["name"];
    String path = json["path"];
    return Music(name, path);
  }
}
