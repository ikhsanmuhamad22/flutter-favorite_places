import 'dart:io';

import 'package:uuid/uuid.dart';

var uuid = Uuid();

class PlaceLocation {
  PlaceLocation({required this.lat, required this.lng, required this.address});
  final double lat;
  final double lng;
  final String address;
}

class Place {
  Place({required this.title, required this.image, required this.location})
      : id = uuid.v4();
  final String id;
  final String title;
  final File image;
  final PlaceLocation location;
}
