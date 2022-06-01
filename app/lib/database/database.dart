import 'package:firebase_database/firebase_database.dart';
import "dart:convert";

import "category.dart";
import "media.dart";
import "image.dart";
import "sound.dart";

DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

void createDatabaseStructure(int numEntries) {
  for (int i = 0; i < numEntries; i++) {
    DatabaseReference videoRef = databaseReference.child("videos").push();
    videoRef.set({"name": "nd", "path": "nd"});

    DatabaseReference imgRef = databaseReference.child("images").push();
    imgRef.set({"name": "nd", "path": "nd"});

    DatabaseReference soundRef = databaseReference.child("sounds").push();
    soundRef
        .set({"name": "nd", "path": "nd", "imageId": "nd", "videoId": "nd"});

    DatabaseReference categoriesRef =
        databaseReference.child("categories").push();
    categoriesRef.set({"name": "nd", "mediaType": "nd"});

    DatabaseReference categoriesSoundsRef =
        databaseReference.child("categoriesSounds").push();
    categoriesSoundsRef.set({"categoryId": "nd", "soundId": "nd"});

    DatabaseReference categoriesImagesRef =
        databaseReference.child("categoriesImages").push();
    categoriesImagesRef.set({"categoryId": "nd", "imageId": "nd"});

    DatabaseReference categoriesVideosRef =
        databaseReference.child("categoriesVideos").push();
    categoriesVideosRef.set({"categoryId": "nd", "videoId": "nd"});
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

// Future<List<MyImage>> loadMedia(Category category) async {
// if (category.mediaType == MediaType.image) {
// return await loadImages(category);
// }
// else {
//   return await loadVideos(category);
// }
// }

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

// Future<List<MyImage>> loadImages(Category category) async {
//   List<MyImage> images = [];

//   Map<String, dynamic> JSON = await getAllDataFromTable("images");

//   if (JSON.isNotEmpty) {
//     var keys = JSON.keys;
//     for (String key in keys) {
//       if (JSON[key]["name"] != "nd") {
//         images.add(MyImage.fromJSON(key, JSON[key]));
//       }
//     }
//   }

//   List<String> imageIdsToUse = [];

//   JSON = await getAllDataFromTable("categoriesImages");

//   if (JSON.isNotEmpty) {
//     var keys = JSON.keys;
//     for (String key in keys) {
//       String imageId = JSON[key]["imageId"];
//       String categoryId = JSON[key]["categoryId"];

//       if (categoryId == category.id) imageIdsToUse.add(imageId);
//     }
//   }

//   images.removeWhere((element) => !(imageIdsToUse.contains(element.id)));

//   return images;
// }

// Future<List<Video>> loadVideos(Category category) async {
//   List<Video> videos = [];

//   Map<String, dynamic> JSON = await getAllDataFromTable("videos");

//   if (JSON.isNotEmpty) {
//     var keys = JSON.keys;
//     for (String key in keys) {
//       if (JSON[key]["name"] != "nd") {
//         videos.add(Video.fromJSON(key, JSON[key]));
//       }
//     }
//   }

//   List<String> videoIdsToUse = [];

//   JSON = await getAllDataFromTable("categoriesVideos");

//   if (JSON.isNotEmpty) {
//     var keys = JSON.keys;
//     for (String key in keys) {
//       String videoId = JSON[key]["videoId"];
//       String categoryId = JSON[key]["categoryId"];

//       if (categoryId == category.id) videoIdsToUse.add(videoId);
//     }
//   }

//   videos.removeWhere((element) => !videoIdsToUse.contains(element.id));

//   return videos;
// }

Future<List<Sound>> loadSounds(Category category) async {
  List<Sound> sounds = [];

  return sounds;
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
  await removeTableRowByAttribute("sounds", "imageId", key);
  await removeTableRowByAttribute("categoriesImages", "imageId", key);
}

Future removeVideosFromDB(String key) async {
  await removeTableRowByKey("videos", key);
  await removeTableRowByAttribute("sounds", "videoId", key);
  await removeTableRowByAttribute("categoriesVideos", "videoId", key);
}

void addImageToDB(String name, String path, String categoryId) {
  DatabaseReference imgRef = databaseReference.child("images").push();
  imgRef.set({"name": name, "path": path});
  DatabaseReference categoriesImagesRef =
      databaseReference.child("categoriesImages").push();
  categoriesImagesRef.set({"categoryId": categoryId, "imageId": imgRef.key});
}

void addVideoToDB(String name, String? path, String? categoryId) {
  DatabaseReference videoRef = databaseReference.child("videos").push();
  videoRef.set({"name": name, "path": path});
  DatabaseReference categoriesVideosRef =
      databaseReference.child("categoriesVideos").push();
  categoriesVideosRef.set({"categoryId": categoryId, "videoId": videoRef.key});
}

void addSoundToDB(String name, String path, String imageId, String videoId,
    String categoryId) {
  DatabaseReference soundRef = databaseReference.child("sounds").push();
  soundRef.set(
      {"name": name, "path": path, "imageId": imageId, "videoId": videoId});
  DatabaseReference categoriesSoundsRef =
      databaseReference.child("categoriesSounds").push();
  categoriesSoundsRef.set({"categoryId": categoryId, "soundId": soundRef.key});
}

void runDBOperations() {}
