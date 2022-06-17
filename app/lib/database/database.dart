import 'package:app/database/music.dart';
import 'package:firebase_database/firebase_database.dart';
import "dart:convert";

import "category.dart";
import "image.dart";
import "sound.dart";

DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

void createDatabaseStructure(int numEntries) {
  for (int i = 0; i < numEntries; i++) {
    DatabaseReference imgRef = databaseReference.child("images").push();
    imgRef.set({"name": "nd", "path": "nd", "soundId": "nd"});

    DatabaseReference soundRef = databaseReference.child("sounds").push();
    soundRef.set({"name": "nd", "path": "nd", "categoryId": "nd"});

    DatabaseReference categoriesRef =
        databaseReference.child("categories").push();
    categoriesRef.set({"name": "nd", "hasSound": "nd"});

    DatabaseReference categoriesImagesRef =
        databaseReference.child("categoriesImages").push();
    categoriesImagesRef.set({"categoryId": "nd", "imageId": "nd"});
  }
}

Future<List<Category>> loadCategories() async {
  List<Category> categories = [];

  Map<String, dynamic> JSON = await getAllDataFromTable("categories");

  if (JSON.isNotEmpty) {
    var keys = JSON.keys;
    for (String key in keys) {
      if (JSON[key]["name"] != "nd") {
        categories.add(Category.fromJSON(key, JSON[key]));
      }
    }
  }

  return categories;
}

Future<List<MyImage>> loadMedia(Category category) async {
  List<MyImage> images = [];

  Map<String, dynamic> JSON = await getAllDataFromTable("images");

  if (JSON.isNotEmpty) {
    var keys = JSON.keys;
    for (String key in keys) {
      if (JSON[key]["name"] != "nd") {
        images.add(MyImage.fromJSON(key, JSON[key]));
      }
    }
  }

  List<String> imageIdsToUse = [];

  JSON = await getAllDataFromTable("categoriesImages");

  if (JSON.isNotEmpty) {
    var keys = JSON.keys;
    for (String key in keys) {
      String imageId = JSON[key]["imageId"];
      String categoryId = JSON[key]["categoryId"];

      if (categoryId == category.id) imageIdsToUse.add(imageId);
    }
  }

  images.removeWhere((element) => !(imageIdsToUse.contains(element.id)));

  return images;
}

Future<List<Sound>> loadSounds(Category category) async {
  List<Sound> sounds = [];

  Map<String, dynamic> JSON = await getAllDataFromTable("sounds");

  if (JSON.isNotEmpty) {
    var keys = JSON.keys;
    for (String key in keys) {
      if (JSON[key]["name"] != "nd") {
        sounds.add(Sound.fromJSON(key, JSON[key]));
      }
    }
  }

  List<String> soundIdsToUse = [];

  if (JSON.isNotEmpty) {
    var keys = JSON.keys;
    for (String key in keys) {
      String categoryId = JSON[key]["categoryId"];

      if (categoryId == category.id) soundIdsToUse.add(key);
    }
  }

  sounds.removeWhere((element) => !(soundIdsToUse.contains(element.id)));

  return sounds;
}

Future<List<Music>> loadMusics() async {
  List<Music> musics = [];

  Map<String, dynamic> JSON = await getAllDataFromTable("music");

  if (JSON.isNotEmpty) {
    var keys = JSON.keys;
    for (String key in keys) {
      if (JSON[key]["name"] != "nd") {
        musics.add(Music.fromJSON(key, JSON[key]));
      }
    }
  }

  return musics;
}

Future<Map<String, dynamic>> getAllDataFromTable(String tableName) async {
  DatabaseEvent databaseEvent = await databaseReference.child(tableName).once();
  Map<String, dynamic> JSON = <String, dynamic>{};
  DataSnapshot databaseSnapshot = databaseEvent.snapshot;

  if (databaseSnapshot.value != null)
    JSON = json.decode(json.encode(databaseSnapshot.value));

  return JSON;
}

Future removeTableRowByAttribute(
    String tableName, String attribute, String value) async {
  Map<String, dynamic> JSON = await getAllDataFromTable(tableName);

  if (JSON.isNotEmpty) {
    var keys = JSON.keys;
    for (String key in keys) {
      String temp = JSON[key][attribute];
      if (temp == value)
        databaseReference.child(tableName + "/" + key).remove();
    }
  }
}

Future removeTableRowByKey(String tableName, String key) async {
  Map<String, dynamic> JSON = await getAllDataFromTable(tableName);

  if (JSON.isNotEmpty) {
    var keys = JSON.keys;
    if (keys.contains(key))
      databaseReference.child(tableName + "/" + key).remove();
  }
}

Future removeImageFromDB(String key) async {
  await removeTableRowByKey("images", key);
  await removeTableRowByAttribute("categoriesImages", "imageId", key);
}

void addImageToDB(String name, String path, String categoryId, String soundId, String pathLearnMore) {
  DatabaseReference imgRef = databaseReference.child("images").push();
  imgRef.set({"name": name, "path": path, "pathLearnMore": pathLearnMore, "soundId": soundId});
  DatabaseReference categoriesImagesRef =
      databaseReference.child("categoriesImages").push();
  categoriesImagesRef.set({"categoryId": categoryId, "imageId": imgRef.key});
}

void addSoundToDB(String name, String path, String categoryId) {
  DatabaseReference soundRef = databaseReference.child("sounds").push();
  soundRef.set({"name": name, "path": path, "categoryId": categoryId});
}

void addMusicToDB(String name, String path) {
  DatabaseReference musicRef = databaseReference.child("music").push();
  musicRef.set({"name": name, "path": path});
}