import 'dart:io';

import 'package:favorite_places_app/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final pathToDb = path.join(dbPath, 'places_db');

  return await sql.openDatabase(
    pathToDb,
    version: 1,
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
    },
  );
}

class PlaceProvider extends StateNotifier<List<Place>> {
  PlaceProvider() : super([]);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final places = data
        .map(
          (e) => Place(
            title: e['title'] as String,
            image: File(e['image'] as String),
            location: PlaceLocation(
                lat: e['lat'] as double,
                lng: e['lng'] as double,
                address: e['address'] as String),
          ),
        )
        .toList();
    state = places;
  }

  void addPlace(String title, File image, PlaceLocation location) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');

    final newPlace =
        Place(title: title, image: copiedImage, location: location);

    final db = await _getDatabase();
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': newPlace.location.lat,
      'lng': newPlace.location.lng,
      'address': newPlace.location.address,
    });
    state = [newPlace, ...state];
  }
}

final placeProvider =
    StateNotifierProvider<PlaceProvider, List<Place>>((ref) => PlaceProvider());
