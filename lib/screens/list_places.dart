import 'package:favorite_places_app/screens/new_places.dart';
import 'package:flutter/material.dart';

class ListPlaces extends StatefulWidget {
  const ListPlaces({super.key});

  @override
  State<ListPlaces> createState() => _ListPlacesState();
}

class _ListPlacesState extends State<ListPlaces> {
  void _addPlace() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NewPlaces(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [IconButton(onPressed: _addPlace, icon: Icon(Icons.add))],
      ),
      body: Center(
        child: Text(
          'No Places added yet',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
