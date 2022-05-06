import 'package:firebase_database/firebase_database.dart';
import "dart:convert";

import "category.dart";
import "media.dart";
import "image.dart";
import "video.dart";

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

  DatabaseEvent databaseEvent =
      await databaseReference.child("categories/").once();

  DataSnapshot databaseSnapshot = databaseEvent.snapshot;
  if (databaseSnapshot.value != null) {
    Map<String, dynamic> JSON =
        json.decode(json.encode(databaseSnapshot.value));

    var keys = JSON.keys;
    for (String key in keys) {
      if (JSON[key]["name"] != "nd") {
        categories.add(Category.fromJSON(key, JSON[key]));
      }
    }
  }

  return categories;
}

Future<List<Media>> loadMedia(Category category) async {
  if (category.mediaType == MediaType.image) {
    return await loadImages(category);
  } else {
    return await loadVideos(category);
  }
}

Future<List<Image>> loadImages(Category category) async {
  List<Image> images = [];

  DatabaseEvent databaseEvent = await databaseReference.child("images/").once();

  DataSnapshot databaseSnapshot = databaseEvent.snapshot;
  if (databaseSnapshot.value != null) {
    Map<String, dynamic> JSON =
        json.decode(json.encode(databaseSnapshot.value));

    var keys = JSON.keys;
    for (String key in keys) {
      if (JSON[key]["name"] != "nd") {
        images.add(Image.fromJSON(key, JSON[key]));
      }
    }
  }

  List<String> imageIdsToUse = [];

  databaseEvent = await databaseReference.child("categoriesImages/").once();

  databaseSnapshot = databaseEvent.snapshot;
  if (databaseSnapshot.value != null) {
    Map<String, dynamic> JSON =
        json.decode(json.encode(databaseSnapshot.value));

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

Future<List<Video>> loadVideos(Category category) async {
  List<Video> videos = [];

  DatabaseEvent databaseEvent = await databaseReference.child("videos/").once();

  DataSnapshot databaseSnapshot = databaseEvent.snapshot;
  if (databaseSnapshot.value != null) {
    Map<String, dynamic> JSON =
        json.decode(json.encode(databaseSnapshot.value));

    var keys = JSON.keys;
    for (String key in keys) {
      if (JSON[key]["name"] != "nd") {
        videos.add(Video.fromJSON(key, JSON[key]));
      }
    }
  }

  List<String> videoIdsToUse = [];

  databaseEvent = await databaseReference.child("categoriesVideos/").once();

  databaseSnapshot = databaseEvent.snapshot;
  if (databaseSnapshot.value != null) {
    Map<String, dynamic> JSON =
        json.decode(json.encode(databaseSnapshot.value));

    var keys = JSON.keys;
    for (String key in keys) {
      String videoId = JSON[key]["videoId"];
      String categoryId = JSON[key]["categoryId"];

      if (categoryId == category.id) videoIdsToUse.add(videoId);
    }
  }

  videos.removeWhere((element) => !videoIdsToUse.contains(element.id));

  return videos;
}
