import 'dart:io';

import 'package:favorite_places_app/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
// import 'package:sqflite/sqlite_api.dart';

class PlaceProvider extends StateNotifier<List<Place>> {
  PlaceProvider() : super([]);

  void addPlace(String title, File image, PlaceLocation location) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');

    final newPlace =
        Place(title: title, image: copiedImage, location: location);

    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(path.join(dbPath, 'places_db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY, title TEXT,  image TEXT, address TEXT)');
    }, version: 1);
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'address': newPlace.location.address,
    });
    state = [newPlace, ...state];
  }
}

final placeProvider =
    StateNotifierProvider<PlaceProvider, List<Place>>((ref) => PlaceProvider());
