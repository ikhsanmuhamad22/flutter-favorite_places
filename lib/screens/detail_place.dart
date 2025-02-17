import 'package:favorite_places_app/models/place.dart';
import 'package:flutter/material.dart';

class DetailPlace extends StatelessWidget {
  const DetailPlace({super.key, required this.place});
  final Place place;


  // you should use u location image from lat and lng
  // but in this i use hardcore code couse i have not google map account
  String get locationImage {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=Berkeley,CA&zoom=13&size=400x400&key=AIzaSyA3kg7YWugGl1lTXmAmaBGPNhDW9pEh5bo&signature=45D4gqkHrzXqD1o0ucV_geljI6A=';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
        body: Stack(
          children: [
            Image.file(
              place.image,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Positioned(
                bottom: 30,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(locationImage),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.black12],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Text(
                        place.location.address,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                      ),
                    )
                  ],
                ))
          ],
        )
    );
  }
}
