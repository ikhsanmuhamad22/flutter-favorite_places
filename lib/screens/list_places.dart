import 'package:favorite_places_app/providers/place_provider.dart';
import 'package:favorite_places_app/screens/new_places.dart';
import 'package:favorite_places_app/widget/place_item_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListPlaces extends ConsumerStatefulWidget {
  const ListPlaces({super.key});

  @override
  ConsumerState<ListPlaces> createState() => _ListPlacesState();
}

class _ListPlacesState extends ConsumerState<ListPlaces> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(placeProvider.notifier).loadPlaces();
  }

  void _addPlace() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NewPlaces(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(placeProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text('Your Places'),
          actions: [IconButton(onPressed: _addPlace, icon: Icon(Icons.add))],
        ),
      body: FutureBuilder(
        future: _placesFuture,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : PlaceItemList(places: places),
      ),
    );
  }
}
