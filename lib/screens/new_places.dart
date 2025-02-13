import 'package:favorite_places_app/models/place.dart';
import 'package:favorite_places_app/providers/place_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlaces extends ConsumerStatefulWidget {
  const NewPlaces({super.key});

  @override
  ConsumerState<NewPlaces> createState() => _NewPlacesState();
}

class _NewPlacesState extends ConsumerState<NewPlaces> {
  var _inputTitle = '';

  void _savePlaces() {
    Place newPlace = Place(id: DateTime.now().toString(), title: _inputTitle);
    ref.read(placeProvider.notifier).addPlace(newPlace);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Place'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextFormField(
                maxLength: 20,
                decoration: InputDecoration(label: Text('Title')),
                onChanged: (newValue) => _inputTitle = newValue,
              ),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: _savePlaces,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 8),
                    Text('Add Place')
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
