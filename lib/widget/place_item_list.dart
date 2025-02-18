import 'package:favorite_places_app/models/place.dart';
import 'package:favorite_places_app/screens/detail_place.dart';
import 'package:flutter/material.dart';

class PlaceItemList extends StatelessWidget {
  const PlaceItemList({super.key, required this.places});
  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        'No Places added yet',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );

    if (places.isNotEmpty) {
      content = ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 26,
                backgroundImage: FileImage(places[index].image),
              ),
              title: Text(
                places[index].title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white, fontSize: 18),
              ),
              subtitle: Text(
                places[index].location.address,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailPlace(place: places[index]),
                ),
              ),
            ),
          );
        },
      );
    }

    return content;
  }
}
