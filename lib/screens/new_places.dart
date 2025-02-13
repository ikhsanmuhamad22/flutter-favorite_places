import 'package:flutter/material.dart';

class NewPlaces extends StatelessWidget {
  const NewPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Place'),
      ),
      body: Form(child: 
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(children: [
            TextFormField(decoration: 
              InputDecoration(label: Text('Title'),
                ),
              ),
              SizedBox(height: 12,),
            ElevatedButton(onPressed: () {}, child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Icon(Icons.add),
              SizedBox(width: 8),
              Text('Add Place')
              ],))
            ],
          ),
        ),
          ),
    );
  }
}
