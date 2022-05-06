class Media {
  String name = "nd";
  String path =
      "https://st4.depositphotos.com/17828278/24401/v/450/depositphotos_244011872-stock-illustration-image-vector-symbol-missing-available.jpg";

  String id = "nd";

  Media({id = "nd", name = "nd", path = "nd"}) {
    this.id = id;

    this.name = name;
    this.path = path;
  }

  bool isSound() {
    return false;
  }

  bool isImage() {
    return false;
  }

  bool isVideo() {
    return false;
  }
}
