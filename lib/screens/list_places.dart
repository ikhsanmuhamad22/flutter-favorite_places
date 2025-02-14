import 'package:favorite_places_app/providers/place_provider.dart';
import 'package:favorite_places_app/screens/detail_place.dart';
import 'package:favorite_places_app/screens/new_places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListPlaces extends ConsumerStatefulWidget {
  const ListPlaces({super.key});

  @override
  ConsumerState<ListPlaces> createState() => _ListPlacesState();
}

class _ListPlacesState extends ConsumerState<ListPlaces> {
  void _addPlace() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NewPlaces(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final place = ref.watch(placeProvider);

    Widget content = Center(
      child: Text(
        'No Places added yet',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );

    if (place.isNotEmpty) {
      content = ListView.builder(
        itemCount: place.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 26,
                backgroundImage: FileImage(place[index].image),
              ),
              title: Text(
                place[index].title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white, fontSize: 18),
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailPlace(place: place[index]),
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Your Places'),
          actions: [IconButton(onPressed: _addPlace, icon: Icon(Icons.add))],
        ),
        body: content);
  }
}
