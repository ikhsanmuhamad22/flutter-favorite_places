import 'dart:io';

import 'package:favorite_places_app/models/place.dart';
import 'package:favorite_places_app/providers/place_provider.dart';
import 'package:favorite_places_app/widget/image_input.dart';
import 'package:favorite_places_app/widget/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlaces extends ConsumerStatefulWidget {
  const NewPlaces({super.key});

  @override
  ConsumerState<NewPlaces> createState() => _NewPlacesState();
}

class _NewPlacesState extends ConsumerState<NewPlaces> {
  final _inputTitle = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedPlace;

  @override
  void dispose() {
    _inputTitle.dispose();
    super.dispose();
  }

  _savePlaces() {
    final enteredText = _inputTitle.text;

    if (enteredText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter correctly'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    ref
        .read(placeProvider.notifier)
        .addPlace(enteredText, _selectedImage!, _selectedPlace!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Place'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextFormField(
                  maxLength: 30,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white),
                  decoration: InputDecoration(label: Text('Title')),
                  controller: _inputTitle,
                ),
                SizedBox(height: 12),
                ImageInput(onpickImage: (image) => _selectedImage = image),
                SizedBox(height: 12),
                LocationInput(
                  onSelectedLocation: (location) => _selectedPlace = location,
                ),
                SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: _savePlaces,
                  icon: Icon(Icons.add),
                  label: Text('Add Place'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
