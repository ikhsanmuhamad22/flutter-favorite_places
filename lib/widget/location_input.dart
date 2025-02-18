// ignore_for_file: unused_local_variable

import 'package:favorite_places_app/models/place.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
// import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectedLocation});
  final void Function(PlaceLocation location) onSelectedLocation;

  @override
  State<StatefulWidget> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  bool _isGetLocation = false;

  String get locationImage {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=Berkeley,CA&zoom=13&size=400x400&key=AIzaSyA3kg7YWugGl1lTXmAmaBGPNhDW9pEh5bo&signature=45D4gqkHrzXqD1o0ucV_geljI6A=';
  }

  void _getCurrenLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGetLocation = true;
    });

    locationData = await location.getLocation();

    // this is how you to use location via goggle but i not have any accont google map
    // final lat = locationData.latitude;
    // final long = locationData.longitude;
    // final url = Uri.parse(
    //     'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=YOUR_API_KEY');
    // final response = await http.get(url);
    // final resData = json.decode(response.body);
    // final address = resData['result'][0]['formatted_address'];

    final lat = 40.714232;
    final long = -73.9612889;
    final address = '277 Bedford Avenue, Brooklyn, NY 11211, USA';

    setState(() {
      _pickedLocation = PlaceLocation(lat: lat, lng: long, address: address);
      _isGetLocation = false;
    });

    widget.onSelectedLocation(_pickedLocation!);
  }

  void _pickLocation() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sorry this feature under developmet'),
        duration: Duration(seconds: 2),
      ),
    );
    return;
  }

  @override
  Widget build(BuildContext context) {
    Widget previewLocation = Text(
      'Pick your location',
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );

    if (_isGetLocation) {
      previewLocation = CircularProgressIndicator();
    }

    if (_pickedLocation != null) {
      previewLocation = Image.network(
        locationImage,
        width: double.infinity,
        height: double.infinity,
      );
    }

    return Column(
      children: [
        Container(
            height: 170,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
            ),
            child: previewLocation),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrenLocation,
              label: Text('Use your current location'),
              icon: Icon(Icons.location_city_sharp),
            ),
            TextButton.icon(
              onPressed: _pickLocation,
              label: Text('Pict location manualy'),
              icon: Icon(Icons.map),
            ),
          ],
        ),
      ],
    );
  }
}
