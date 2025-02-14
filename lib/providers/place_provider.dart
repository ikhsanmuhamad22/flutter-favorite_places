
import 'package:favorite_places_app/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceProvider extends StateNotifier<List<Place>> {
  PlaceProvider() : super([]);

  void addPlace(Place place) {
    state = [place, ...state];
  }
}

final placeProvider =
    StateNotifierProvider<PlaceProvider, List<Place>>((ref) => PlaceProvider());
